Describe $($PSCommandPath -Replace ".Tests.ps1") {

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
		$Script:BaseURI = "https://SomeURL/SomeApp"
		$Script:ExternalVersion = "0.0"
		$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

	}


	AfterAll {

		$Script:RequestBody = $null

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		Context 'Minimum Version Met' {

			It 'returns nothing if version requirment is satisfied' {
				Assert-VersionRequirement -ExternalVersion "0.2" -RequiredVersion "0.1" | Should -BeNullOrEmpty
			}

			It 'does not throw if version requirment is satisfied' {
				{Assert-VersionRequirement -ExternalVersion "0.2" -RequiredVersion "0.1"} | Should -Not -Throw
			}

		}

		Context 'Version Check Skipped' {

			It 'returns nothing if external version is "0.0"' {
				Assert-VersionRequirement -ExternalVersion "0.0" -RequiredVersion "9.9" | Should -BeNullOrEmpty
			}

			It 'does not throw if external version is "0.0"' {
				{Assert-VersionRequirement -ExternalVersion "0.0" -RequiredVersion "1.1"} | Should -Not -Throw
			}

		}

		Context 'Minimum Version Not Met' {

			BeforeEach{
			Mock Get-ParentFunction -MockWith {
				[PSCustomObject]@{
					FunctionName     = "SomeFunction"
					ParameterSetName = "SomeParameterSet"
				}
			}
			Function Test-Failure {Assert-VersionRequirement -ExternalVersion "1.1" -RequiredVersion "2.0"}
}
			It 'throws error if external version is less than required version' {
				{Test-Failure} | Should -Throw
			}

			It 'throws expected error if no custom parameterset has been used in the parent function' {

				Mock Get-ParentFunction -MockWith {
					[PSCustomObject]@{
						FunctionName     = "Test-Example"
						ParameterSetName = "__AllParameterSets"
					}
				}

				{Test-Failure} | Should -Throw "CyberArk 1.1 does not meet the minimum version requirement of 2.0 for Test-Example (using ParameterSet: __AllParameterSets)"
			}

			It 'throws expected error if a custom parameterset has been used in the parent function' {
				Mock Get-ParentFunction -MockWith {
					[PSCustomObject]@{
						FunctionName     = "Test-Example"
						ParameterSetName = "SomeParamSet"
					}
				}
				{Test-Failure} | Should -Throw "CyberArk 1.1 does not meet the minimum version requirement of 2.0 for Test-Example (using ParameterSet: SomeParamSet)"
			}
		}




	}

}