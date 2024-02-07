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

		It 'returns parent function name' {
			Function Test-Parent { Test-Child }
			Function Test-Child { Get-ParentFunction }
			$ThisTest = Test-Parent

			$ThisTest.FunctionName | Should -Be Test-Parent
		}

		It 'returns expected parent function name from expected scope' {
			Function Test-Example {
				[CmdletBinding()]
				param([parameter(ParameterSetName = 'ExampleParamSet')][string]$Name)
				Test-Parent
			}
			Function Test-Parent { Test-Child }
			Function Test-Child { Get-ParentFunction -Scope 3 }
			$ThisTest = Test-Example -Name 'test'

			$ThisTest.FunctionName | Should -Be 'Test-Example'

		}

		It 'returns expected ParameterSetName from expected scope' {
			Function Test-Example {
				[CmdletBinding()]
				param([parameter(ParameterSetName = 'ExampleParamSet')][string]$Name)
				Test-Parent
			}
			Function Test-Parent { Test-Child }
			Function Test-Child { Get-ParentFunction -Scope 3 }
			$ThisTest = Test-Example -Name 'test'

			$ThisTest.ParameterSetName | Should -Be 'ExampleParamSet'
		}


	}

}