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

        BeforeEach {
            Mock Invoke-PASRestMethod -MockWith {

                New-Object Byte[] 512

            }

            Mock Out-PASFile -MockWith { }

            $InputObj = @{
                Safe         = 'SomeSafe'
                Folder       = 'SomeFolder'
                FileName     = 'SomeReport'
                Type         = 'SomeType'
                ReportFormat = 'XLS'
                path         = "$env:Temp\testExport.zip"
            }
            $response = Export-PASReport @InputObj
        }

        Context 'Mandatory Parameters' {

            $Parameters = @{Parameter = 'Safe' },
            @{Parameter = 'Folder' },
            @{Parameter = 'FileName' },
            @{Parameter = 'Type' },
            @{Parameter = 'ReportFormat' },
            @{Parameter = 'path' }

            It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

                param($Parameter)

                (Get-Command Export-PASReport).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

            }

        }



        Context 'Input' {

            It 'throws if path is invalid' {
                { $InputObj | Export-PASReport -ReportFormat 'XLS' -path A:\test.txt } | Should -Throw
            }

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Scope It -Times 1 -Exactly

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -like "$($Script:psPASSession.BaseURI)/API/ClassicReports*"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $psPASSession.ExternalVersion = '1.0'
                { Export-PASReport @InputObj } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

        }

    }

}