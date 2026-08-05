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

    }

    InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

        Context 'Output' {

            It 'returns the documented filter names for a known subType' {

                $Result = Get-PASReportFilterName -SubType 'InventoryReports.InventoryReportUI'

                $Result | Should -Contain 'safe'
                $Result | Should -Contain 'accountName'

            }

            It 'returns different filter names for a different subType' {

                $Result = Get-PASReportFilterName -SubType 'CyberArk.Reports.OwnersListReport.OwnersListReportUI'

                $Result | Should -Be @('safe', 'userOrGroup')

            }

            It 'returns no filter names for the License capacity subType' {

                $Result = Get-PASReportFilterName -SubType 'CyberArk.Reports.LicenseCapacityReport.LicenseCapacityReportUI'

                $Result | Should -BeNullOrEmpty

            }

            It 'returns nothing for an unrecognised subType' {

                $Result = Get-PASReportFilterName -SubType 'SomeUnknownSubType'

                $Result | Should -BeNullOrEmpty

            }

        }

    }

}
