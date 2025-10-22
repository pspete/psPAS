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
            ApiURI             = 'https://SomeTenant.cyberark.cloud'
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

                #TODO: Figure out how to include Assert-VersionRequirement in P Cloud function tests
                Mock Assert-VersionRequirement -MockWith {}

                $InputObject = @{
                    'type'        = 'sometype'
                    'subtype'     = 'somesubtype'
                    'identifiers' = @{
                        'address'  = 'someaddress'
                        'username' = 'someusername'
                    }
                    'externalId'  = 'someexternalid'
                }

            }

            It 'sends request - single parameterset' {

                Test-PASDiscoveredLocalAccount @inputObject

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint - single parameterset' {

                Test-PASDiscoveredLocalAccount @inputObject

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.ApiURI)/api/discovered-accounts/check-existence"

                }

            }

            It 'sends request using expected method' {

                Test-PASDiscoveredLocalAccount @inputObject

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body - single parameterset' {

                Test-PASDiscoveredLocalAccount @inputObject

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -ne $null } -Times 1 -Exactly -Scope It

            }

        }

    }

}