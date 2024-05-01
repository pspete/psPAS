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
        $psPASSession = [ordered]@{
            BaseURI            = 'https://SomeURL.cyberark.cloud/SomeApp'
            ApiURI             = 'https://SomeURL.cyberark.cloud'
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

            #TODO: Figure out how to include Assert-VersionRequirement in P Cloud function tests
            Mock Assert-VersionRequirement -MockWith {}

            Mock Invoke-PASRestMethod -MockWith {
                [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
            }

            $InputObject = [PSCustomObject]@{

                'customerPublicIPs' = @('123.123.123.123/24', '123.122.121.120/32')

            }

            $response = $InputObject | Set-PASIPAllowList

        }

        Context 'Input' {

            It 'sends request' {

                Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

            }

            It 'throws if invalid CIDR Range is specified in request' {

                { Set-PASIPAllowList -customerPublicIPs '303.606.909.123/22' } | Should -Throw

            }

            It 'throws if out of range CIDR is specified in request' {

                { Set-PASIPAllowList -customerPublicIPs '123.123.123.123/8' } | Should -Throw

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

                    $URI -eq "$($Script:psPASSession.ApiURI)/api/advanced-settings/ip-allowlist"

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
                    $($Body | ConvertFrom-Json) -ne $null
                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
                    $($Body | ConvertFrom-Json).customerPublicIPs -ne $null
                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
                    $($Body | ConvertFrom-Json).customerPublicIPs.count -eq 2
                } -Times 1 -Exactly -Scope It

            }

        }

        Context 'Output' {

            It 'provides output' {

                $response | Should -Not -BeNullOrEmpty

            }

            It 'has output with expected number of properties' {

                ($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

            }

        }

    }

}