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

        Context 'General' {

            BeforeEach {


                $InputObj = @{
                    'reason'   = 'some reason'
                    'fromDate' = 5
                }

            }

            It 'does not throw' {

                { ConvertTo-BulkFilterItem } | Should -Not -Throw

            }

            It 'produces expected output if given no input' {

                $output = ConvertTo-BulkFilterItem
                $output['Reason'] | Should -BeNullOrEmpty
                $output['TicketingSystemName'] | Should -BeNullOrEmpty
                $output['TicketID'] | Should -BeNullOrEmpty
                $output['AdditionalInfo'] | Should -BeNullOrEmpty
                $output['multipleAccessRequired'] | Should -Be $false
                $output['fromDate'] | Should -Be 0
                $output['toDate'] | Should -Be 0

            }

            It 'outputs expected values' {

                $output = $InputObj | ConvertTo-BulkFilterItem
                $output['Reason'] | Should -Be 'some reason'
                $output['TicketingSystemName'] | Should -BeNullOrEmpty
                $output['TicketID'] | Should -BeNullOrEmpty
                $output['AdditionalInfo'] | Should -BeNullOrEmpty
                $output['multipleAccessRequired'] | Should -Be $false
                $output['fromDate'] | Should -Be 5
                $output['toDate'] | Should -Be 0

            }

        }

    }

}