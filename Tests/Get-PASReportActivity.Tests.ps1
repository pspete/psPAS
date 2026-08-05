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
                    [PSCustomObject]@{
                        'activityGroups' = @(
                            [PSCustomObject]@{
                                'activityGroup' = 'Group1'
                                'displayName'   = 'Group One'
                                'activities'    = @(
                                    [PSCustomObject]@{'code' = '1'; 'name' = 'Activity One' }
                                )
                            }
                        )
                    }
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }

            It 'sends request' {
                Get-PASReportActivity
                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {
                Get-PASReportActivity
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/ReportParams/Activities"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {
                Get-PASReportActivity
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with no body' {
                Get-PASReportActivity
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $psPASSession.ExternalVersion = '14.6'
                { Get-PASReportActivity } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'does not throw when using the base version requirement' {
                $psPASSession.ExternalVersion = '15.0'
                { Get-PASReportActivity } | Should -Not -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'sends request with expected query string for Type' {
                Get-PASReportActivity -Type ActivitiesReport
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/ReportParams/Activities?Type=ActivitiesReport"

                } -Times 1 -Exactly -Scope It

            }

            It 'rejects an unsupported Type value' {

                { Get-PASReportActivity -Type SomeOtherReport } | Should -Throw

            }

        }

        Context 'Output' {
            BeforeEach {
                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{
                        'activityGroups' = @(
                            [PSCustomObject]@{
                                'activityGroup' = 'Group1'
                                'displayName'   = 'Group One'
                                'activities'    = @(
                                    [PSCustomObject]@{'code' = '1'; 'name' = 'Activity One' }
                                )
                            },
                            [PSCustomObject]@{
                                'activityGroup' = 'Group2'
                                'displayName'   = 'Group Two'
                                'activities'    = @(
                                    [PSCustomObject]@{'code' = '2'; 'name' = 'Activity Two' }
                                )
                            }
                        )
                    }
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }

            It 'provides output' {

                Get-PASReportActivity | Should -Not -BeNullOrEmpty

            }

            It 'returns an activity group per group in the response' {

                (Get-PASReportActivity).Count | Should -Be 2

            }

            It 'has output with expected number of properties' {

                (Get-PASReportActivity | Select-Object -First 1 | Get-Member -MemberType NoteProperty).length | Should -Be 3

            }

            It 'outputs object with expected typename' {

                Get-PASReportActivity | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Report.ActivityGroup

            }

        }

    }

}
