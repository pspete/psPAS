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

            $Parameters = @{Parameter = 'userIds' },
            @{Parameter = 'allowedAuthenticationMethods' }

            It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

                param($Parameter)

                (Get-Command Remove-PASUserAllowedAuthenticationMethod).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should -Be $true

            }

        }

        Context 'Input' {

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {

                }

                $InputObj = [pscustomobject]@{
                    'userIds'                      = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
                    'allowedAuthenticationMethods' = 'SomeMethod', 'PKI', 'Radius', 'LDAP'

                }

                $response = $InputObj | Remove-PASUserAllowedAuthenticationMethod

            }

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/API/Users/RemoveAllowedAuthenticationMethods/Bulk"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PATCH' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -ne $null } -Times 1 -Exactly -Scope It

            }

            It 'throws error if version 12.1 requirement not met' {
                $psPASSession.ExternalVersion = '1.0'
                { $InputObj | Remove-PASUserAllowedAuthenticationMethod } | Should -Throw
                $psPASSession.ExternalVersion = '0.0'
            }

        }

        Context 'Output' {

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {

                }

                $InputObj = [pscustomobject]@{
                    'userIds'                      = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
                    'allowedAuthenticationMethods' = 'SomeMethod', 'PKI', 'Radius', 'LDAP'

                }

                $response = $InputObj | Remove-PASUserAllowedAuthenticationMethod

            }

            It 'provides no output' {

                $response | Should -BeNullOrEmpty

            }

        }

    }

}