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
            BaseURI            = 'https://SomeTenant.cyberark.cloud'
            ApiURI             = 'https://SomeTenant.cyberark.cloud'
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
            $psPASSession.ExternalVersion = '0.0'

            Mock Invoke-PASRestMethod -MockWith {
            }

            $InputObject = [PSCustomObject]@{

                AccountID              = '12_3'
                dependentAccountId     = '45_6'
                extraPasswordAccountId = '78_9'
                extraPasswordIndex     = 1

            }

            #TODO: Figure out how to include Assert-VersionRequirement in P Cloud function tests
            Mock Assert-VersionRequirement -MockWith {}

            $response = $InputObject | Set-PASDependentLinkedAccount

        }

        Context 'Input' {

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/12_3/account-dependents/45_6/link-accounts"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
                    $($Body | ConvertFrom-Json) -ne $null
                } -Times 1 -Exactly -Scope It

            }

        }

        Context 'Output' {

            It 'provides no output' {

                $response | Should -BeNullOrEmpty

            }

        }

    }

}