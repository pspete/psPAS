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

            $Parameters = @{Parameter = 'ThemeName' }

            It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

                param($Parameter)

                (Get-Command Set-PASTheme).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should -Be $true

            }

        }


        Context 'Input' {

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
                }

                $InputObj = [pscustomobject]@{
                    'ThemeName'           = 'SomeTheme'
                    'name'                = 'SomeName'
                    'isDraft'             = $false
                    'mainBackgroundImage' = 'SomeImage'
                    'borderMain_Dark'     = '#FFFFFF'
                }

                Mock Get-PASTheme -MockWith {
                    [pscustomobject]@{
                        'name'                = 'SomeTheme'
                        'isDraft'             = $true
                        'mainBackgroundImage' = $null
                        'borderMain_Dark'     = '#000000'
                        'textMain'            = '#FFFFFF'
                        'borderMain'          = '#000000'
                        'backgroundMain'      = '#FFFFFF'
                        'menuIcon'            = '#000000'
                        'menuTextActive'      = '#000000'
                    }

                }
                $response = Set-PASTheme -ThemeName $InputObj.ThemeName `
                    -name $InputObj.name `
                    -isDraft $InputObj.isDraft `
                    -mainBackgroundImage $InputObj.mainBackgroundImage `
                    -borderMain_Dark $InputObj.borderMain_Dark

            }

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Themes/SomeTheme/"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

            }

            It 'gets existing theme settings' {
                Assert-MockCalled Get-PASTheme -ParameterFilter { $ThemeName -eq 'SomeTheme' } -Times 1 -Exactly -Scope It
            }

            It 'sends request with expected body' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Script:RequestBody = $Body | ConvertFrom-Json
                    ($Script:RequestBody) -ne $null

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected new details' {
                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Script:RequestBody = $Body | ConvertFrom-Json

                    ($Script:RequestBody).images.main.mainBackgroundImage -eq 'SomeImage'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Script:RequestBody = $Body | ConvertFrom-Json

                    ($Script:RequestBody).isDraft -eq $false

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $Script:RequestBody = $Body | ConvertFrom-Json

                    ($Script:RequestBody).colors.definitionByType.dark.borderMain -eq '#FFFFFF'

                } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version requirement not met' {
                $psPASSession.ExternalVersion = '1.0'

                { $InputObj | Set-PASTheme } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'

            }

        }

        Context 'Output' {

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {
                    [PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
                }

                $InputObj = [pscustomobject]@{
                    'ThemeName'           = 'SomeTheme'
                    'name'                = 'SomeName'
                    'isDraft'             = $false
                    'mainBackgroundImage' = 'SomeImage'
                    'borderMain_Dark'     = '#FFFFFF'
                }

                Mock Get-PASTheme -MockWith {
                    [pscustomobject]@{
                        'name'                = 'SomeTheme'
                        'isDraft'             = $true
                        'mainBackgroundImage' = $null
                        'borderMain_Dark'     = '#000000'
                        'textMain'            = '#FFFFFF'
                        'borderMain'          = '#000000'
                        'backgroundMain'      = '#FFFFFF'
                        'menuIcon'            = '#000000'
                        'menuTextActive'      = '#000000'
                    }

                }
                $response = Set-PASTheme -ThemeName $InputObj.ThemeName `
                    -name $InputObj.name `
                    -isDraft $InputObj.isDraft `
                    -mainBackgroundImage $InputObj.mainBackgroundImage `
                    -borderMain_Dark $InputObj.borderMain_Dark

            }

            It 'provides output' {

                $response | Should -Not -BeNullOrEmpty

            }

            It 'has output with expected number of properties' {

                ($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

            }

            It 'outputs object with expected typename' -Skip {

                $response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.User

            }



        }

    }

}