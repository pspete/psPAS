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

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'UserName' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASUser).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"UserName" = "SomeUser"

				}

				$InputObjV10 = [PSCustomObject]@{
					"Search"        = "SomeUser"
					"ComponentUser" = $true

				}

				$response = $InputObj | Get-PASUser

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/WebServices/PIMServices.svc/Users/SomeUser"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - Gen2" {

				$InputObjV10 | Get-PASUser

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					(($URI -eq "$($Script:BaseURI)/api/Users?Search=SomeUser&ComponentUser=True") -or
						($URI -eq "$($Script:BaseURI)/api/Users?ComponentUser=True&Search=SomeUser"))

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - Gen2ID" {

				Get-PASUser -id 123

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/api/Users/123"

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

				{ $InputObjV10 | Get-PASUser } | Should -Throw
				$Script:ExternalVersion = "0.0"

			}

			It "throws error if version requirement not met" {
				$Script:ExternalVersion = "10.9"

				{ Get-PASUser -id 123 } | Should -Throw
				$Script:ExternalVersion = "0.0"

			}

		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"UserName" = "SomeUser"

				}

				$InputObjV10 = [PSCustomObject]@{
					"Search"        = "SomeUser"
					"ComponentUser" = $true

				}

				$response = $InputObj | Get-PASUser

			}
			It "provides output" {

				$response | Should -Not -BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It "outputs object with expected typename" {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.User

			}

			It "outputs object with expected typename - Gen2" {

				Mock Invoke-PASRestMethod -MockWith { [PSCustomObject]@{"Users" =
						[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
					}
				}

				$response = $InputObjV10 | Get-PASUser
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.User.Extended

			}



		}

	}

}