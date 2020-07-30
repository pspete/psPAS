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

		Context "Input - Legacy" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = 123 }

				}

				$InputObj = [pscustomobject]@{
					"Name" = "SomeName"

				}

				$response = $InputObj | Get-PASPlatform -verbose

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Platforms/SomeName"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {
				$Script:ExternalVersion = "1.0"
				{ $InputObj | Get-PASPlatform } | Should -Throw
				$Script:ExternalVersion = "0.0"
			}

		}

		Context "Input - 11.1" {
			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{
						"Platforms" = [PSCustomObject]@{
							"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = 123
						}
					}

				}

				$InputObj = [pscustomobject]@{
					"Search"       = "SomeName"
					"Active"       = $true
					"PlatformType" = "Regular"
				}

				$response = $InputObj | Get-PASPlatform

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {
				$Script:ExternalVersion = "10.0"
				{ $InputObj | Get-PASPlatform } | Should -Throw
				$Script:ExternalVersion = "0.0"
			}

		}

		Context "Input - 11.4" {
			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{
						"Platforms" = [PSCustomObject]@{
							"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = 123
						}
					}

				}

				Get-PASPlatform

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - target" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Platforms/targets"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - dependent" {

				Get-PASPlatform -DependentPlatform

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Platforms/dependents"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - group" {

				Get-PASPlatform -GroupPlatform

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Platforms/groups"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - rotational group" {

				Get-PASPlatform -RotationalGroup

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Platforms/rotationalGroups"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {
				$Script:ExternalVersion = "11.3"
				{ Get-PASPlatform } | Should -Throw
				$Script:ExternalVersion = "0.0"
			}

		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = 123 }

				}

				$InputObj = [pscustomobject]@{
					"Name" = "SomeName"

				}

				$response = $InputObj | Get-PASPlatform -verbose

			}

			it "provides output" {

				$response | Should -Not -BeNullOrEmpty

			}

			It "has output with expected number of properties - legacy" {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

			It "has output with expected number of properties - 11.1" {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{
						"Platforms" = [PSCustomObject]@{
							"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = 123
						}
					}

				}

				$response = Get-PASPlatform -Active $true -PlatformType Regular

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

			It "has output with expected number of properties - 11.4" {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{
						"Platforms" = [PSCustomObject]@{
							"Prop1" = "Val1"; "Prop2" = "Val2"; "Prop3" = 123
						}
					}

				}

				$response = Get-PASPlatform -Active $true

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Platform

			}

		}

	}

}