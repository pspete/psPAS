Describe $($PSCommandPath -replace '.Tests.ps1') {

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

        Context 'Mandatory Parameters' {

            $Parameters = @{Parameter = 'AccountId' },
            @{Parameter = 'platformId' },
            @{Parameter = 'platformAccountProperties' }

            It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

                param($Parameter)

                (Get-Command Add-PASDependentAccount).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

            }

        }

        Context 'Input' {

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {
                    Write-Output @{ }
                }

                $InputObj = [pscustomobject]@{
                    'AccountId'                  = '12_3'
                    'name'                       = 'SomeName'
                    'platformId'                 = 'SomePlatform'
                    'platformAccountProperties'  = @{'SomeUser' = 'SomeVal'; 'SomeKey' = 'SomeVal2' }
                    'automaticManagementEnabled' = $true
                    'manualManagementReason'     = 'someReason'
                }
                $psPASSession.ExternalVersion = '0.0'

            }

            It 'sends request' {

                $InputObj | Add-PASDependentAccount

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                $InputObj | Add-PASDependentAccount

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Accounts/12_3/dependentAccounts"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                $InputObj | Add-PASDependentAccount

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                $InputObj | Add-PASDependentAccount

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    ($Body | ConvertFrom-Json) -ne $null

                } -Times 1 -Exactly -Scope It

            }

            It 'has a request body with expected number of properties' {

                $InputObj | Add-PASDependentAccount

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
                    ($Body | ConvertFrom-Json | Get-Member -MemberType NoteProperty).length -eq 4
                } -Times 1 -Exactly -Scope It

            }

            It 'has expected number of secretManagement nested properties' {
                $InputObj | Add-PASDependentAccount

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    ($Body | ConvertFrom-Json | Select-Object -ExpandProperty secretManagement | Get-Member -MemberType NoteProperty).length -eq 2

                } -Times 1 -Exactly -Scope It

            }

            It 'has expected number of platformAccountProperties nested properties' {

                $InputObj | Add-PASDependentAccount

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    ($Body | ConvertFrom-Json | Select-Object -ExpandProperty platformAccountProperties | Get-Member -MemberType NoteProperty).length -eq 2

                } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {

                $psPASSession.ExternalVersion = '1.0'
                { $InputObj | Add-PASDependentAccount } | Should -Throw
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
                    'AccountId'                  = '12_3'
                    'name'                       = 'SomeName'
                    'platformId'                 = 'SomePlatform'
                    'platformAccountProperties'  = @{'SomeUser' = 'SomeVal'; 'SomeKey' = 'SomeVal2' }
                    'automaticManagementEnabled' = $true
                    'manualManagementReason'     = 'someReason'
                }
                $psPASSession.ExternalVersion = '0.0'

            }

            It 'provides output' {
                $response = $InputObj | Add-PASDependentAccount
                $response | Should -Not -BeNullOrEmpty

            }

        }
        #>
    }



}