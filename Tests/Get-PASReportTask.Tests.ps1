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
                        'tasks'      = @([PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' })
                        'totalCount' = 1
                    }
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }

            It 'sends request' {
                Get-PASReportTask
                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {
                Get-PASReportTask
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Tasks"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {
                Get-PASReportTask
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with no body' {
                Get-PASReportTask
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $psPASSession.ExternalVersion = '1.0'
                { Get-PASReportTask } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'sends request with expected query string for limit' {
                Get-PASReportTask -limit 25
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Tasks?limit=25"

                } -Times 1 -Exactly -Scope It

            }

            It 'does not throw when using limit at the base version requirement' {
                $psPASSession.ExternalVersion = '14.6'
                { Get-PASReportTask -limit 25 } | Should -Not -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'sends request with expected query string for search' {
                Get-PASReportTask -search SomeTask
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Tasks?search=SomeTask"

                } -Times 1 -Exactly -Scope It

            }

            It 'throws error if search/filter version requirement not met' {
                $psPASSession.ExternalVersion = '14.6'
                { Get-PASReportTask -search SomeTask } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'does not throw when search/filter version requirement met' {
                $psPASSession.ExternalVersion = '15.0'
                { Get-PASReportTask -search SomeTask } | Should -Not -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'sends request with expected query string for filter built from name parameter' {
                $psPASSession.ExternalVersion = '15.0'
                Get-PASReportTask -name SomeTask
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Tasks?filter=name%20EQ%20SomeTask"

                } -Times 1 -Exactly -Scope It
                $psPASSession.ExternalVersion = '0.0'

            }

            It 'sends request with expected query string for filter built from subType parameter' {
                $psPASSession.ExternalVersion = '15.0'
                Get-PASReportTask -subType InventoryReports.InventoryReportUI
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Tasks?filter=subType%20EQ%20InventoryReports.InventoryReportUI"

                } -Times 1 -Exactly -Scope It
                $psPASSession.ExternalVersion = '0.0'

            }

            It 'sends request with expected query string for filter built from multiple parameters' {
                #Clause order within the filter value is not guaranteed (it is built from a hashtable),
                #so clauses are compared as an unordered set rather than an exact string/URI match
                $psPASSession.ExternalVersion = '15.0'

                $Script:CapturedURI = $null

                Mock Invoke-PASRestMethod -MockWith {
                    param($URI)
                    $Script:CapturedURI = $URI
                    [PSCustomObject]@{
                        'tasks'      = @([PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' })
                        'totalCount' = 1
                    }
                }

                Get-PASReportTask -subType InventoryReports.InventoryReportUI -name SomeTask

                $ExpectedBaseURI = "$($Script:psPASSession.BaseURI)/API/Tasks?filter="

                $Script:CapturedURI | Should -Match "^$([regex]::Escape($ExpectedBaseURI))"

                $EncodedFilter = $Script:CapturedURI.Substring($ExpectedBaseURI.Length)
                $Filter = [System.Uri]::UnescapeDataString($EncodedFilter)
                $Clauses = $Filter -split ' AND ' | Sort-Object

                $Clauses | Should -Be @('name EQ SomeTask', 'subType EQ InventoryReports.InventoryReportUI')

                $psPASSession.ExternalVersion = '0.0'

            }

            It 'throws error if filter version requirement not met' {
                $psPASSession.ExternalVersion = '14.6'
                { Get-PASReportTask -name SomeTask } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
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
                            'tasks'      = @([PSCustomObject]@{'name' = 'Task1' }, [PSCustomObject]@{'name' = 'Task2' })
                            'totalCount' = 3
                        }

                    } else {

                        [PSCustomObject]@{
                            'tasks'      = @([PSCustomObject]@{'name' = 'Task3' })
                            'totalCount' = 3
                        }

                    }

                }
            }

            It 'sends additional requests while more tasks remain' {
                Get-PASReportTask | Out-Null
                Assert-MockCalled Invoke-PASRestMethod -Times 2 -Exactly -Scope It
            }

            It 'sends the follow-up request with the expected offset' {
                Get-PASReportTask | Out-Null
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Tasks?offset=2"

                } -Times 1 -Exactly -Scope It
            }

            It 'returns tasks collected from every page' {
                (Get-PASReportTask).Count | Should -Be 3
            }

        }

        Context 'Input - ID' {

            BeforeEach {
                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{'tasks' = [PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' } }
                }

                $InputObj = [pscustomobject]@{
                    'id' = 'SomeTaskID'
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }

            It 'sends request' {
                $InputObj | Get-PASReportTask
                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {
                $InputObj | Get-PASReportTask
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Tasks/SomeTaskID"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {
                $InputObj | Get-PASReportTask
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

            }

            It 'escapes the id value in the URL' {
                $InputObj = [pscustomobject]@{
                    'id' = 'Some Task ID'
                }
                $InputObj | Get-PASReportTask
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Tasks/Some%20Task%20ID"

                } -Times 1 -Exactly -Scope It

            }

        }

        Context 'Output' {
            BeforeEach {
                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{
                        'tasks'      = @([PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' })
                        'totalCount' = 1
                    }
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }
            It 'provides output' {

                Get-PASReportTask | Should -Not -BeNullOrEmpty

            }

            It 'has output with expected number of properties' {

                (Get-PASReportTask | Get-Member -MemberType NoteProperty).length | Should -Be 3

            }

            It 'outputs object with expected typename' -Skip {

                Get-PASReportTask | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.PSM.Recording

            }

        }

        Context 'Output - ID' {
            BeforeEach {
                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }

            It 'provides output' {

                Get-PASReportTask -id 'SomeTaskID' | Should -Not -BeNullOrEmpty

            }

            It 'does not error expanding a non-existent tasks property' {

                { Get-PASReportTask -id 'SomeTaskID' } | Should -Not -Throw

            }

            It 'has output with expected number of properties' {

                (Get-PASReportTask -id 'SomeTaskID' | Get-Member -MemberType NoteProperty).length | Should -Be 3

            }

        }

    }

}
