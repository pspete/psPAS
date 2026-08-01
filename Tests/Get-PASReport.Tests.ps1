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

        Context 'Input' {

            BeforeEach {
                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{'reports' = [PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' } }
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }

            It 'sends request' {
                Get-PASReport
                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {
                Get-PASReport
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Reports"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {
                Get-PASReport
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with no body' {
                Get-PASReport
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $psPASSession.ExternalVersion = '1.0'
                { Get-PASReport } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'sends request with expected query string for limit' {
                Get-PASReport -limit 25
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Reports?limit=25"

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected query string for search' {
                Get-PASReport -search SomeReport
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Reports?search=SomeReport"

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected query string for filter built from status parameter' {
                Get-PASReport -status Done
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Reports?filter=status%20EQ%20Done"

                } -Times 1 -Exactly -Scope It

            }

            It 'does not throw when using limit at the base version requirement' {
                $psPASSession.ExternalVersion = '14.6'
                { Get-PASReport -limit 25 } | Should -Not -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'throws error if search/filter version requirement not met' {
                $psPASSession.ExternalVersion = '14.6'
                { Get-PASReport -search SomeReport } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'does not throw when search/filter version requirement met' {
                $psPASSession.ExternalVersion = '15.0'
                { Get-PASReport -search SomeReport } | Should -Not -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'sends request with expected query string for sort' {
                Get-PASReport -sort CreatedAt
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Reports?sort=CreatedAt"

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected query string for sort with ascending sortDirection' {
                Get-PASReport -sort CreatedAt -sortDirection asc
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Reports?sort=CreatedAt"

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected query string for sort with descending sortDirection' {
                Get-PASReport -sort CreatedAt -sortDirection desc
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Reports?sort=-CreatedAt"

                } -Times 1 -Exactly -Scope It

            }

            It 'throws error if sort version requirement not met' {
                $psPASSession.ExternalVersion = '14.6'
                { Get-PASReport -sort CreatedAt } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'does not throw when sort version requirement met' {
                $psPASSession.ExternalVersion = '15.0'
                { Get-PASReport -sort CreatedAt } | Should -Not -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'throws error for an unsupported sort value' {
                { Get-PASReport -sort SomeOtherProperty } | Should -Throw
            }

        }

        Context 'Pagination' {

            BeforeEach {
                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

                $Script:CallCount = 0

                Mock Invoke-PASRestMethod -MockWith {

                    $Script:CallCount++

                    if ($Script:CallCount -eq 1) {

                        [PSCustomObject]@{
                            'reports'    = @([PSCustomObject]@{'name' = 'Report1'}, [PSCustomObject]@{'name' = 'Report2'})
                            'totalCount' = 3
                        }

                    } else {

                        [PSCustomObject]@{
                            'reports'    = @([PSCustomObject]@{'name' = 'Report3'})
                            'totalCount' = 3
                        }

                    }

                }
            }

            It 'sends additional requests while more reports remain' {
                Get-PASReport | Out-Null
                Assert-MockCalled Invoke-PASRestMethod -Times 2 -Exactly -Scope It
            }

            It 'sends the follow-up request with the expected offset' {
                Get-PASReport | Out-Null
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Reports?offset=2"

                } -Times 1 -Exactly -Scope It
            }

            It 'returns reports collected from every page' {
                (Get-PASReport).Count | Should -Be 3
            }

        }

        Context 'Output' {
            BeforeEach {
                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{
                        'reports' = [PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
                    }
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }
            It 'provides output' {

                Get-PASReport | Should -Not -BeNullOrEmpty

            }

            It 'has output with expected number of properties' {

                (Get-PASReport | Get-Member -MemberType NoteProperty).length | Should -Be 3

            }

            It 'outputs object with expected typename' {

                Get-PASReport | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Report

            }

        }

    }

}