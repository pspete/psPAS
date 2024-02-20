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
					PSMRemoteMachine = 'RemoteMachineValue'
					LogonDomain      = 'LogonDomainValue'
					SomeProperty     = 'SomeValue'
				}

			}

			It 'does not throw' {

				{ ConvertTo-ConnectionParam } | Should -Not -Throw

			}

			It 'produces no output if given no input' {

				ConvertTo-ConnectionParam | Should -BeNullOrEmpty

			}

			It 'outputs expected ConnectionParams properties' {

				$result = $InputObj | ConvertTo-ConnectionParam
				$result['ConnectionParams']['PSMRemoteMachine']['Value'] | Should -Be 'RemoteMachineValue'
				$result['ConnectionParams']['LogonDomain']['Value'] | Should -Be 'LogonDomainValue'
				$result['SomeProperty'] | Should -Be 'SomeValue'

			}

			It 'returns expected hashtable if no ConnectionParams are specified' {

				$InputObj = @{
					Property1 = 'SomeValue'
					Property2 = 'SomeOtherValue'
				}

				$result = $InputObj | ConvertTo-ConnectionParam

				$result['Property1'] | Should -Be 'SomeValue'
				$result['Property2'] | Should -Be 'SomeOtherValue'
				$result['ConnectionParams'] | Should -BeNullOrEmpty

			}

		}

	}

}