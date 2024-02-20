Describe $($PSCommandPath -Replace '.Tests.ps1') {

    BeforeAll {
        #Get Current Directory
        $Here = Split-Path -Parent $PSCommandPath

        #Assume ModuleName from Repository Root folder
        $ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

        #Resolve Path to Module Directory
        $ModulePath = Resolve-Path "$Here\..\$ModuleName"

        #Define Path to Module Manifest
        $ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

        if ( -not (Get-Module -Name $ModuleName -All)) {

            Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

        }

        $Script:RequestBody = $null
        $psPASSession = [ordered]@{
			BaseURI            = 'https://SomeURL/SomeApp'
			User               = $null
			ExternalVersion    = [System.Version]'0.0'
			WebSession         = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			StartTime          = $null
			ElapsedTime        = $null
			LastCommand        = $null
			LastCommandTime    = $null
			LastCommandResults = $null
		}

		New-Variable -Name psPASSession -Value $psPASSession -Scope Script -Force

    }

    AfterAll {

        $Script:RequestBody = $null

    }

    InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

        Context 'Input' {

            BeforeEach {

                $secureString = $('P_Password' | ConvertTo-SecureString -AsPlainText -Force)
                Mock Invoke-PASRestMethod -MockWith {
                    Write-Output @{ }
                }

                $InputObj = [pscustomobject]@{
                    'address'  = 'someaddress'
                    'userName' = 'SomeUser'
                    'secret'   = $secureString
                }

                $psPASSession.ExternalVersion = '0.0'

            }

            It 'sends request' {

                $InputObj | Add-PASPersonalAdminAccount

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                $InputObj | Add-PASPersonalAdminAccount

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/PersonalAdminAccount"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                $InputObj | Add-PASPersonalAdminAccount

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                $InputObj | Add-PASPersonalAdminAccount

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json) -ne $null

                } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {

                $psPASSession.ExternalVersion = '1.0'
                { $InputObj | Add-PASPersonalAdminAccount } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'

            }

        }

        Context 'Output' {

            BeforeEach {

                $secureString = $('P_Password' | ConvertTo-SecureString -AsPlainText -Force)
                Mock Invoke-PASRestMethod -MockWith {
                    $result = [pscustomobject]@{
                        'Prop1' = 'Val1'
                        'Prop2' = 'Val2'
                        'Prop3' = 'Val3'
                    }

                    $result
                }

                $InputObj = [pscustomobject]@{
                    'address'  = 'someaddress'
                    'userName' = 'SomeUser'
                    'secret'   = $secureString
                }
                $psPASSession.ExternalVersion = '0.0'

            }

            It 'provides output' {
                $response = $InputObj | Add-PASPersonalAdminAccount
                $response | Should -Not -BeNullOrEmpty

            }

            It 'outputs object with expected typename' {
                Mock Invoke-PASRestMethod -MockWith {
                    [pscustomobject]@{
                        'Count' = 30
                        'Value' = [pscustomobject]@{'Prop1' = 'Val1' }
                    }
                }
                $response = $InputObj | Add-PASPersonalAdminAccount
                $response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Account.V10

            }



        }
        #>
    }



}