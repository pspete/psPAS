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
        $Script:BaseURI = 'https://SomeURL/SomeApp'
        $Script:ExternalVersion = '0.0'
        $Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

    }


    AfterAll {

        $Script:RequestBody = $null

    }

    InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

        BeforeEach {

            Mock Invoke-PASRestMethod -MockWith {
                [pscustomobject]@{
                    'LinkedAccounts'        = [pscustomobject]@{
                        'prop5' = 'val5'
                        'prop6' = 'val6'
                        'prop7' = 'val7'
                        'prop8' = 'val8'
                        'prop9' = 'val9'
                    }
                    'LinkedGroupId'         = 123
                    'LinkedGroupName'       = 'SomeName'
                    'LinkedGroupPolicyName' = 'SomeName'

                }
            }

            $InputObj = [pscustomobject]@{
                'AccountID' = '66_6'

            }

            $response = $InputObj | Get-PASLinkedGroup -Verbose
        }

        Context 'Mandatory Parameters' {

            $Parameters = @{Parameter = 'id' }

            It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

                param($Parameter)

                (Get-Command Get-PASLinkedGroup).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

            }



        }

        Context 'Input' {

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:BaseURI)/api/ExtendedAccounts/66_6/LinkedAccounts"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with no body' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

            }

        }

        Context 'Output' {

            It 'provides output' {

                $response | Should -Not -Be null

            }

            It 'has output with expected number of properties' {

                ($response | Get-Member -MemberType NoteProperty).length | Should -Be 3

            }

        }

    }

}