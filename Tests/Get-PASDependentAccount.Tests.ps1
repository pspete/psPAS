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

        Context 'Request Input' {

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {
                    Write-Output @{ }
                }

            }

            It 'sends request - SpecificAccount parameterset' {

                Get-PASDependentAccount -id 'SomeID'

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request - SpecificDependentAccount parameterset' {

                Get-PASDependentAccount -id 'SomeID' -dependentAccountId 'SomeDependentID'

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request - AllDependentAccounts parameterset' {

                Get-PASDependentAccount

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint - SpecificAccount parameterset' {

                Get-PASDependentAccount -id 'SomeID'

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/SomeID/dependentAccounts"

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint - SpecificDependentAccount parameterset' {

                Get-PASDependentAccount -id 'SomeID' -dependentAccountId 'SomeDependentID'

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/SomeID/dependentAccounts/SomeDependentID"

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint - AllDependentAccounts parameterset' {

                Get-PASDependentAccount

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/dependentAccounts?limit=100"

                } -Times 1 -Exactly -Scope It

            }

            It 'sends expected filters - AllDependentAccounts parameterset' {

                Get-PASDependentAccount -modificationTime $(Get-Date -Month 01 -Day 01 -Year 2020 -Hour 0 -Minute 0 -Second 0 -Millisecond 0) -SafeName SomeSafe

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    ($URI -eq "$($Script:psPASSession.BaseURI)/API/dependentAccounts?limit=100&filter=modificationTime%20gte%201577836800%20AND%20safeName%20eq%20SomeSafe") -or
                    ($URI -eq "$($Script:psPASSession.BaseURI)/API/dependentAccounts?limit=100&filter=safeName%20eq%20SomeSafe%20AND%20modificationTime%20gte%201577836800") -or
                    ($URI -eq "$($Script:psPASSession.BaseURI)/API/dependentAccounts?filter=modificationTime%20gte%201577836800%20AND%20safeName%20eq%20SomeSafe&limit=100") -or
                    ($URI -eq "$($Script:psPASSession.BaseURI)/API/dependentAccounts?filter=safeName%20eq%20SomeSafe%20AND%20modificationTime%20gte%201577836800&limit=100")

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request using expected method' {

                Get-PASDependentAccount

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with no body' {

                Get-PASDependentAccount

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {

                $psPASSession.ExternalVersion = '1.0'
                { Get-PASDependentAccount -id 'SomeID' } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'

            }

        }

        Context 'Response Output' {

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {

                    $result = [pscustomobject]@{
                        'Total'             = 30
                        'DependentAccounts' = [pscustomobject]@{
                            'AccountID'  = '66_6'
                            'Properties' = @(
                                [pscustomobject]@{
                                    'Key'   = 'Safe'
                                    'Value' = 'zzTestSafe1'
                                },
                                [pscustomobject]@{
                                    'Key'   = 'Folder'
                                    'Value' = 'Root'
                                },
                                [pscustomobject]@{
                                    'Key'   = 'Name'
                                    'Value' = 'Operating System-_Test_WinDomain-VIRTUALREAL.IT-user01'
                                },
                                [pscustomobject]@{
                                    'Key'   = 'UserName'
                                    'Value' = 'user01'
                                },
                                [pscustomobject]@{
                                    'Key'   = 'PolicyID'
                                    'Value' = '_Test_WinDomain'
                                },
                                [pscustomobject]@{
                                    'Key'   = 'LogonDomain'
                                    'Value' = 'VIRTUALREAL'
                                },
                                [pscustomobject]@{
                                    'Key'   = 'LastSuccessVerification'
                                    'Value' = '1511973510'
                                },
                                [pscustomobject]@{
                                    'Key'   = 'Address'
                                    'Value' = 'VIRTUALREAL.IT'
                                },
                                [pscustomobject]@{
                                    'Key'   = 'DeviceType'
                                    'Value' = 'Operating System'
                                }
                            )
                        }
                    }
                    return $result

                }


            }

            It 'provides output - AllDependentAccounts parameterset' {
                $response = Get-PASDependentAccount
                $response | Should -Not -Be Null

            }

            It 'provides output - SpecificAccount parameterset' {
                Mock Invoke-PASRestMethod -MockWith {
                    [pscustomobject]@{'Prop1' = 'Val1' }
                }
                $response = Get-PASDependentAccount -id 'SomeID'
                $response | Should -Not -Be null

            }

            It 'provides output - SpecificDependentAccount parameterset' {
                Mock Invoke-PASRestMethod -MockWith {
                    [pscustomobject]@{'Prop1' = 'Val1' }
                }
                $response = Get-PASDependentAccount -id 'SomeID' -dependentAccountId 'SomeDependentID'
                $response | Should -Not -Be null

            }

            It 'processes NextLink' {
                Mock Invoke-PASRestMethod -MockWith {
                    if ($script:iteration -lt 10) {
                        [pscustomobject]@{
                            'Total'             = 100
                            'DependentAccounts' = 1..100

                        }
                        $script:iteration++
                    } else {
                        throw 'No more pages'
                    }
                }
                $script:iteration = 1
                Get-PASDependentAccount
                Assert-MockCalled Invoke-PASRestMethod -Times 10 -Exactly -Scope It

            }

        }

    }

}