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

            $Parameters = @{Parameter = 'subType' },
            @{Parameter = 'name' },
            @{Parameter = 'keepTaskDefinition' },
            @{Parameter = 'notifyOnFailure' }

            It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

                param($Parameter)

                (Get-Command New-PASReportTask).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should -Be $true

            }

        }

        Context 'Input' {

            BeforeEach {
                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
                }

                $InputObj = [pscustomobject]@{
                    'subtype'            = 'InventoryReports.InventoryReportUI'
                    'name'               = 'SomeName'
                    'keepTaskDefinition' = $true
                    'notifyOnFailure'    = $true
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }

            It 'sends request' {

                $InputObj | New-PASReportTask

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                $InputObj | New-PASReportTask

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Tasks"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                $InputObj | New-PASReportTask

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                $InputObj | New-PASReportTask

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Script:RequestBody = $Body | ConvertFrom-Json

                    ($Script:RequestBody) -ne $null

                } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $psPASSession.ExternalVersion = '9.8'
                { $InputObj | New-PASReportTask } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }



            It 'throws error if version requirement not met for AdHocConnect' {
                $psPASSession.ExternalVersion = '10.4'
                { $AdHocObj | New-PASReportTask } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

        }

        Context 'Input - Subscribers' {

            BeforeEach {
                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
                }

                $ldapInfo = [LdapInfo]::new('SomeDirectory', 'CN=SomeUser,DC=domain,DC=com')
                $subscriber = [Subscriber]::new('someone@example.com', 'email', $true, $ldapInfo)

                $InputObj = [pscustomobject]@{
                    'subtype'            = 'InventoryReports.InventoryReportUI'
                    'name'               = 'SomeName'
                    'keepTaskDefinition' = $true
                    'notifyOnFailure'    = $true
                    'Subscribers'        = @($subscriber)
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }

            It 'does not truncate nested Subscriber/LdapInfo properties in the request body' {

                $InputObj | New-PASReportTask -WarningVariable JsonWarning -WarningAction SilentlyContinue

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $ParsedBody = $Body | ConvertFrom-Json
                    $ParsedBody.Subscribers[0].ldapInfo.directoryName -eq 'SomeDirectory'

                } -Times 1 -Exactly -Scope It

                $JsonWarning | Should -BeNullOrEmpty

            }

        }

        Context 'Input - Filters' {

            BeforeEach {
                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
                }

                #'safe' is a documented filter name for the InventoryReports.InventoryReportUI subType
                $filter = [TaskFilter]::new('safe', 'SomeValue')

                $InputObj = [pscustomobject]@{
                    'subtype'            = 'InventoryReports.InventoryReportUI'
                    'name'               = 'SomeName'
                    'keepTaskDefinition' = $true
                    'notifyOnFailure'    = $true
                    'Filters'            = @($filter)
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }

            It 'includes the Filters array in the request body' {

                $InputObj | New-PASReportTask -WarningVariable JsonWarning -WarningAction SilentlyContinue

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $ParsedBody = $Body | ConvertFrom-Json
                    ($ParsedBody.Filters[0].name -eq 'safe') -and ($ParsedBody.Filters[0].value -eq 'SomeValue')

                } -Times 1 -Exactly -Scope It

                $JsonWarning | Should -BeNullOrEmpty

            }

            It 'does not warn when a filter name is documented for the specified subType' {

                $InputObj | New-PASReportTask -WarningVariable FilterWarning -WarningAction SilentlyContinue | Out-Null

                $FilterWarning | Should -BeNullOrEmpty

            }

            It 'warns when a filter name is not documented for the specified subType' {

                $undocumentedFilter = [TaskFilter]::new('SomeUndocumentedFilter', 'SomeValue')
                $InputObj.Filters = @($undocumentedFilter)

                $InputObj | New-PASReportTask -WarningVariable FilterWarning -WarningAction SilentlyContinue | Out-Null

                $FilterWarning | Where-Object { $_ -match "'SomeUndocumentedFilter'" } | Should -Not -BeNullOrEmpty

            }

            It 'does not throw for a subType with no documented filters' {

                $InputObj.subtype = 'CyberArk.Reports.LicenseCapacityReport.LicenseCapacityReportUI'

                { $InputObj | New-PASReportTask -WarningAction SilentlyContinue } | Should -Not -Throw

            }

            It 'throws error if version requirement for Filters not met' {
                $psPASSession.ExternalVersion = '14.6'
                { $InputObj | New-PASReportTask -WarningAction SilentlyContinue } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

            It 'does not throw when using Filters at the base version requirement' {
                $psPASSession.ExternalVersion = '15.0'
                { $InputObj | New-PASReportTask -WarningAction SilentlyContinue } | Should -Not -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

        }

        Context 'Input - Schedule Recurrence' {

            BeforeEach {
                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }

            It 'does not throw when startTime and recurrence parameters are specified together' {

                $InputObj = [pscustomobject]@{
                    'subtype'            = 'InventoryReports.InventoryReportUI'
                    'name'               = 'SomeName'
                    'keepTaskDefinition' = $true
                    'notifyOnFailure'    = $true
                    'startTime'          = Get-Date
                    'recurrenceType'     = 'Weekly'
                    'recurrenceValue'    = '1'
                    'daysOfWeek'         = '1,2,3'
                    'weekNumber'         = '1'
                }

                { $InputObj | New-PASReportTask } | Should -Not -Throw

            }

            It 'does not throw when a recurrence parameter is specified without startTime' {

                $InputObj = [pscustomobject]@{
                    'subtype'            = 'InventoryReports.InventoryReportUI'
                    'name'               = 'SomeName'
                    'keepTaskDefinition' = $true
                    'notifyOnFailure'    = $true
                    'recurrenceType'     = 'Weekly'
                }

                { $InputObj | New-PASReportTask } | Should -Not -Throw

            }

            It 'builds expected nested schedule/recurrence body' {

                $InputObj = [pscustomobject]@{
                    'subtype'            = 'InventoryReports.InventoryReportUI'
                    'name'               = 'SomeName'
                    'keepTaskDefinition' = $true
                    'notifyOnFailure'    = $true
                    'recurrenceType'     = 'Weekly'
                    'recurrenceValue'    = '1'
                    'daysOfWeek'         = '1,2,3'
                    'weekNumber'         = '1'
                }

                $InputObj | New-PASReportTask

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $ParsedBody = $Body | ConvertFrom-Json

                    ($ParsedBody.schedule.recurrence.type -eq 'Weekly') -and
                    ($ParsedBody.schedule.recurrence.recurrenceValue -eq '1') -and
                    ($ParsedBody.schedule.recurrence.daysOfWeek -join ',') -eq '1,2,3' -and
                    ($ParsedBody.schedule.recurrence.weekNumber -eq '1')

                } -Times 1 -Exactly -Scope It

            }

        }

    }

}