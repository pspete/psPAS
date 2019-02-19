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

		It 'returns TRUE if version is greater than minimum version' {
			Compare-MinimumVersion -Version "9.8.0" -MinimumVersion "8.9.0" | Should Be $true
		}

		It 'returns FALSE if version is less than minimum version' {
			Compare-MinimumVersion -Version "9.8.0" -MinimumVersion "9.9.0" | Should Be $false
		}

		It 'returns TRUE if version is 0.0' {

			Compare-MinimumVersion -Version "0.0" -MinimumVersion "1.1.0" | Should Be $true

		}



	}

}