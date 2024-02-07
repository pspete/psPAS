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

                $props = @{'SomeProp' = 'SomeValue' }
                $InputObj = [PSCustomObject]@{
                    'AccountId'              = '123_4'
                    'Reason'                 = 'Some Reason'
                    'TicketingSystemName'    = 'SomeITSM'
                    'TicketID'               = '1234'
                    'MultipleAccessRequired' = $false
                    'FromDate'               = $(Get-Date -Month 1 -Day 22 -Year 2023 -Hour 0 -Minute 0 -Second 0 -Millisecond 0)
                    'ToDate'                 = $(Get-Date -Month 1 -Day 23 -Year 2023 -Hour 0 -Minute 0 -Second 0 -Millisecond 0)
                    'AdditionalInfo'         = $props
                    'PSMRemoteMachine'       = 'SomeMachine'
                }
                Mock Invoke-PASRestMethod -MockWith {  }


            }

            It 'does not throw' {

                { $InputObj | New-PASRequestObject } | Should -Not -Throw

            }

            It 'outputs expected object type' {
                $InputObj | New-PASRequestObject | Should -BeOfType Hashtable
            }

            It 'has output with expected number of keys' {
                $result = $InputObj | New-PASRequestObject
                $result.keys.count | Should -Be 9
            }

            It 'has expected value for ConnectionParams' {
                $result = $InputObj | New-PASRequestObject
                $result['ConnectionParams'].keys | Should -Contain PSMRemoteMachine
            }

            It 'has expected value for AdditionalInfo' {
                $result = $InputObj | New-PASRequestObject
                $result['AdditionalInfo'].keys | Should -Contain SomeProp
            }

            It 'has expected value for FromDate' {
                $result = $InputObj | New-PASRequestObject
                $result['FromDate'] | Should -Be 1674345600
            }

            It 'has expected value for ToDate' {
                $result = $InputObj | New-PASRequestObject
                $result['ToDate'] | Should -Be 1674432000
            }

        }

    }

}