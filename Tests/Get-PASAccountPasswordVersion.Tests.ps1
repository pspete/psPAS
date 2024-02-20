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

            $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
            $psPASSession.ExternalVersion = '0.0'
            $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{
                        'Versions' = @(
                            [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
                            [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
                            [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
                            [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
                            [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
                        )
                    }
                }

                Get-PASAccountPasswordVersion -AccountID 12_3

            }

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/12_3/Secret/Versions"

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected query' {

                Get-PASAccountPasswordVersion -AccountID 12_3 -showTemporary $True

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/12_3/Secret/Versions?showTemporary=True"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with no body' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $psPASSession.ExternalVersion = '1.0'
                { Get-PASAccountPasswordVersion -AccountID 12_3 } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

        }

        Context 'Response Output' {

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{
                        'Versions' = @(
                            [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
                            [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
                            [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
                            [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
                            [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
                        )
                    }
                }

                $response = Get-PASAccountPasswordVersion -AccountID 12_3

            }

            It 'provides output' {

                $response | Should -Not -BeNullOrEmpty

            }

            It 'has output with expected number of properties' {

                ($response | Get-Member -MemberType NoteProperty).length | Should -Be 3

            }

            It 'outputs object with expected typename' {

                $response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Credential.Version

            }

        }

    }

}