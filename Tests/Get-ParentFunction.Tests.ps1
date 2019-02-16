#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repo Root folder
$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

if( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		It 'returns parent function name' {
			Function Test-Parent {Test-Child}
			Function Test-Child {Get-ParentFunction}
			$ThisTest = Test-Parent

			$ThisTest.FunctionName | Should Be Test-Parent
		}

		It 'returns expected parent function name from expected scope' {
			Function Test-Example {
				[CmdletBinding()]
				param([parameter(ParameterSetName = "ExampleParamSet")][string]$Name)
				Test-Parent
			}
			Function Test-Parent {Test-Child}
			Function Test-Child {Get-ParentFunction -Scope 3}
			$ThisTest = Test-Example -Name "test"

			$ThisTest.FunctionName | Should Be "Test-Example"

		}

		It 'returns expected ParameterSetName from expected scope' {
			Function Test-Example {
				[CmdletBinding()]
				param([parameter(ParameterSetName = "ExampleParamSet")][string]$Name)
				Test-Parent
			}
			Function Test-Parent {Test-Child}
			Function Test-Child {Get-ParentFunction -Scope 3}
			$ThisTest = Test-Example -Name "test"

			$ThisTest.ParameterSetName | Should Be "ExampleParamSet"
		}


	}

}