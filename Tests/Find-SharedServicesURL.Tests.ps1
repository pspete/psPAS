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

    }

    InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

        Context 'General Operations' {

            BeforeEach {

                Mock Invoke-PASRestMethod -MockWith {

                    [pscustomobject]@{
                        identity_user_portal = [pscustomobject]@{api = 'https://SubDomainABC.id.cyberark.cloud' }
                        pcloud               = [pscustomobject]@{api = 'https://SomeSubDomain.privilegecloud.cyberark.cloud' }
                    }

                }

            }

            It 'sends request to expected endpoint when subdomain provided' {
                Find-SharedServicesURL -subdomain somedomain
                Assert-MockCalled -CommandName Invoke-PASRestMethod -Times 1 -ParameterFilter {
                    $URI -eq 'https://platform-discovery.cyberark.cloud/api/v2/services/subdomain/somedomain'
                } -Scope It -Exactly
            }

            It 'sends request to expected endpoint when url provided' {
                Find-SharedServicesURL -url https://someotherdomain.cyberark.cloud
                Assert-MockCalled -CommandName Invoke-PASRestMethod -Times 1 -ParameterFilter {
                    $URI -eq 'https://platform-discovery.cyberark.cloud/api/v2/services/subdomain/someotherdomain'
                } -Scope It -Exactly
            }

            It 'uses expected method' {
                Find-SharedServicesURL -url https://someotherdomain.cyberark.cloud
                Assert-MockCalled -CommandName Invoke-PASRestMethod -Times 1 -ParameterFilter {
                    $Method -eq 'GET'
                } -Scope It -Exactly
            }

            It 'outputs expected results' {
                $results = Find-SharedServicesURL -url https://someotherdomain.cyberark.cloud
                $results.pcloud.api | Should -Be 'https://SomeSubDomain.privilegecloud.cyberark.cloud'
                $results.identity_user_portal.api | Should -Be 'https://SubDomainABC.id.cyberark.cloud'
            }

            It 'outputs filtered results when service is specified' {
                Find-SharedServicesURL -subdomain somedomain -service pcloud | Select-Object -ExpandProperty api | Should -Be 'https://SomeSubDomain.privilegecloud.cyberark.cloud'
            }

            It 'throws if specifed service detail is not included in results' {
                { Find-SharedServicesURL -subdomain somedomain -service flows } | Should -Throw -ExpectedMessage 'URL for flows API not found'
            }

        }

    }

}