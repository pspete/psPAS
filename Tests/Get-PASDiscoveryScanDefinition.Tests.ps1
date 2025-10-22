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
            ApiURI             = 'https://SomeURL.cyberark.cloud'
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

            $Parameters = @{Parameter = 'ID' }

            It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

                param($Parameter)

                (Get-Command Get-PASDiscoveryScanDefinition).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

            }

        }



        Context 'Input' {

            BeforeEach {

                #TODO: Figure out how to include Assert-VersionRequirement in P Cloud function tests
                Mock Assert-VersionRequirement -MockWith {}

                Mock Invoke-PASRestMethod -MockWith {

                }

                $InputObj = [pscustomobject]@{
                    'ID' = '99_9'

                }


            }

            It 'sends request - byID ParameterSet' {

                Get-PASDiscoveryScanDefinition -Id '99_9'

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request - GetAllScanDefinitions ParameterSet' {

                Get-PASDiscoveryScanDefinition

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint - byID ParameterSet' {

                Get-PASDiscoveryScanDefinition -Id '99_9'

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.ApiURI)/api/scan-definitions/99_9"

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint - GetAllScanDefinitions ParameterSet' {

                Get-PASDiscoveryScanDefinition

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.ApiURI)/api/scan-definitions"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Get-PASDiscoveryScanDefinition

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with no body' {

                Get-PASDiscoveryScanDefinition

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

            }

            It 'sends expected filter' {

                Get-PASDiscoveryScanDefinition -Type SomeType

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.ApiURI)/api/scan-definitions?filter=type%20eq%20SomeType"

                } -Times 1 -Exactly -Scope It
            }

            It 'sends expected query' {

                Get-PASDiscoveryScanDefinition -search SomeTerm

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.ApiURI)/api/scan-definitions?search=SomeTerm"

                } -Times 1 -Exactly -Scope It
            }

        }

        Context 'Output - ById' {

            BeforeEach {

                #TODO: Figure out how to include Assert-VersionRequirement in P Cloud function tests
                Mock Assert-VersionRequirement -MockWith {}

                Mock Invoke-PASRestMethod -MockWith {
                    @{
                        'Property1' = 'Value'
                        'item'      = 'Value2'

                    }

                }

            }

            It 'provides output' {
                $response = Get-PASDiscoveryScanDefinition -id 'SomeID'
                $response | Should -Not -Be null

            }

            It 'outputs expected number of results' {

                $response = Get-PASDiscoveryScanDefinition -id 'SomeID'
                @($response).Count | Should -Be 1

            }

        }

        Context 'Output - GetAllScanDefinitions' {

            BeforeEach {

                #TODO: Figure out how to include Assert-VersionRequirement in P Cloud function tests
                Mock Assert-VersionRequirement -MockWith {}

                Mock Invoke-PASRestMethod -MockWith {
                    @{
                        'totalCount' = 300
                        'items'      = 1..100

                    }

                }

            }

            It 'provides output' {

                $response = Get-PASDiscoveryScanDefinition
                $response | Should -Not -Be null

            }

            It 'outputs expected number of results' {

                $response = Get-PASDiscoveryScanDefinition
                $response.Count | Should -Be 100

            }

        }

    }

}