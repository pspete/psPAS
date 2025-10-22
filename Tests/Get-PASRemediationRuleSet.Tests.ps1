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

                (Get-Command Get-PASRemediationRuleSet).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

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

                Get-PASRemediationRuleSet -Id '99_9'

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request - GetAllRemediationRuleSets ParameterSet' {

                Get-PASRemediationRuleSet

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint - byID ParameterSet' {

                Get-PASRemediationRuleSet -Id '99_9'

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.ApiURI)/api/discovery-rule-sets/99_9"

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint - GetAllRemediationRuleSets ParameterSet' {

                Get-PASRemediationRuleSet

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.ApiURI)/api/discovery-rule-sets?Limit=50"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Get-PASRemediationRuleSet

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with no body' {

                Get-PASRemediationRuleSet

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

            }

            It 'sends expected query' {

                Get-PASRemediationRuleSet -search SomeTerm

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.ApiURI)/api/discovery-rule-sets?search=SomeTerm&Limit=50"

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
                $response = Get-PASRemediationRuleSet -id 'SomeID'
                $response | Should -Not -Be null

            }

            It 'outputs expected number of results' {

                $response = Get-PASRemediationRuleSet -id 'SomeID'
                @($response).Count | Should -Be 1

            }

        }

        Context 'Output - GetAllRemediationRuleSets' {

            BeforeEach {

                #TODO: Figure out how to include Assert-VersionRequirement in P Cloud function tests
                Mock Assert-VersionRequirement -MockWith {}

                Mock Invoke-PASRestMethod -MockWith {
                    1..100 | ForEach-Object {
                        [pscustomobject]@{
                            'Property' = "Value$_"
                            'item'     = "Value2_$_"

                        }


                    }

                }

            }

            It 'provides output' {

                $response = Get-PASRemediationRuleSet
                $response | Should -Not -Be null

            }

            It 'outputs expected number of results' {

                $response = Get-PASRemediationRuleSet
                $response.Count | Should -Be 200

            }

        }

    }

}