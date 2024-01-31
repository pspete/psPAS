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

        Context 'Input' {

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {

                }

                $Script:BaseURI = 'https://SomeURL/SomeApp'
                $Script:ExternalVersion = '0.0'
                $Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

            }

            It 'sends request' {
                Get-PASPTARiskEvent
                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {
                Get-PASPTARiskEvent
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -match "$($Script:BaseURI)/API/pta/API/Risks/RisksEvents/"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected date filter - date range' {
                Get-PASPTARiskEvent -FromTime (Get-Date 12/11/79) -ToTime (Get-Date 22/1/23)
                #311212800000 1674345600000
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
                    $URI -eq "$($Script:BaseURI)/API/pta/API/Risks/RisksEvents/?filter=detectionTime%20BETWEEN%20%22311212800000%22%20TO%20%221674345600000%22"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected date filter - before date' {
                Get-PASPTARiskEvent -ToTime (Get-Date 22/1/23) #1674345600000
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
                    $URI -eq "$($Script:BaseURI)/API/pta/API/Risks/RisksEvents/?filter=detectionTime%20lte%20%221674345600000%22"

                } -Times 1 -Exactly -Scope It
            }

            It 'uses expected date filter - after date' {
                Get-PASPTARiskEvent -FromTime (Get-Date 22/1/23) #1674345600000
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
                    $URI -eq "$($Script:BaseURI)/API/pta/API/Risks/RisksEvents/?filter=detectionTime%20gte%20%221674345600000%22"

                } -Times 1 -Exactly -Scope It
            }

            It 'uses expected method' {
                Get-PASPTARiskEvent
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with no body' {
                Get-PASPTARiskEvent
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Body -eq $null

                } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $Script:ExternalVersion = '1.0'
                { Get-PASPTARiskEvent } | Should -Throw
                $Script:ExternalVersion = '0.0'
            }

        }

        Context 'Output' {
            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{
                        'totalEntities' = 1
                        'totalpages'    = 0
                        'entities'      = [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
                    }
                }

                $Script:BaseURI = 'https://SomeURL/SomeApp'
                $Script:ExternalVersion = '0.0'
                $Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

            }
            It 'provides output' {

                Get-PASPTARiskEvent | Should -Not -BeNullOrEmpty

            }

            It 'has output with expected number of properties' {

				(Get-PASPTARiskEvent | Get-Member -MemberType NoteProperty).length | Should -Be 2

            }

            It 'outputs object with expected typename' {

                Get-PASPTARiskEvent | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.PTA.Event.Risk

            }

            It 'processes NextLink' {
                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{
                        'totalEntities' = 799
                        'totalpages'    = 10
                        'entities'      = @([PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }, [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }, [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' })
                    }
                }
                #$script:iteration = 1
                Get-PASPTARiskEvent
                Assert-MockCalled Invoke-PASRestMethod -Times 10 -Exactly -Scope It

            }

        }

    }

}