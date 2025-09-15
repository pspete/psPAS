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

                (Get-Command New-PASReportSchedule).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should -Be $true

            }

        }

        Context 'Input' {

            BeforeEach {
                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
                }

                $InputObj = [pscustomobject]@{
                    'subtype'            = 'SomeType'
                    'name'               = 'SomeName'
                    'keepTaskDefinition' = $true
                    'notifyOnFailure'    = $true
                }

                $Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
                $psPASSession.ExternalVersion = '0.0'
                $psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }

            It 'sends request' {

                $InputObj | New-PASReportSchedule

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                $InputObj | New-PASReportSchedule

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Tasks"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                $InputObj | New-PASReportSchedule

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                $InputObj | New-PASReportSchedule

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Script:RequestBody = $Body | ConvertFrom-Json

                    ($Script:RequestBody) -ne $null

                } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $psPASSession.ExternalVersion = '9.8'
                { $InputObj | New-PASReportSchedule } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }



            It 'throws error if version requirement not met for AdHocConnect' {
                $psPASSession.ExternalVersion = '10.4'
                { $AdHocObj | New-PASReportSchedule } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

        }

    }

}