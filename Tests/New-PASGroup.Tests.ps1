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

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }

				$InputObject = [PSCustomObject]@{
					GroupName = "SomeGroup"
					Description = "Some Description"
					Location = "\Some\Location"
				}

			}

			It "sends request" {
				$InputObject | New-PASGroup
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {
				$InputObject | New-PASGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/UserGroups"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				$InputObject | New-PASGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {
				New-PASGroup -groupName SomeGroup -description "Some Description" -location "/Some/Location"
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Body -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {
				$Script:ExternalVersion = "1.2"

				{ $InputObject | New-PASGroup } | Should -Throw

				$Script:ExternalVersion = "0.0"

			}

		}

		Context "Output" {

			BeforeEach {

				$InputObject = [PSCustomObject]@{
					GroupName   = "SomeGroup"
					Description = "Some Description"
					Location    = "\Some\Location"
				}

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						"Prop1" = "Value1"
						"Prop2" = "Value2"
						"Prop3" = "Value3"
						"Prop4" = "Value4"
					}
				}

			}

			it "provides output" {

				$response = $InputObject | New-PASGroup
				$response | Should -Not -BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				$response = $InputObject | New-PASGroup
				($response | Get-Member -MemberType NoteProperty).length | Should -Be 4

			}



		}

	}

}