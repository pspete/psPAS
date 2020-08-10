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

			It "specifies parameter UserName as mandatory for ParameterSet legacy" {

				(Get-Command Set-PASUser).Parameters["UserName"].ParameterSets["legacy"].IsMandatory | Should -Be $true

			}

			It "specifies parameter UserName as mandatory for ParameterSet 11.1" {

				(Get-Command Set-PASUser).Parameters["UserName"].ParameterSets["11.1"].IsMandatory | Should -Be $true

			}

		}

		Context "Input - legacy" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"UserName"    = "SomeUser"
					"NewPassword" = $("P_Password" | ConvertTo-SecureString -AsPlainText -Force)
					"FirstName"   = "Some"
					"LastName"    = "User"
					"ExpiryDate"  = "10/31/2018"

				}

				$response = $InputObj | Set-PASUser -NewPassword $("P_Password" | ConvertTo-SecureString -AsPlainText -Force) -ExpiryDate "10/31/2018" -UseClassicAPI

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/WebServices/PIMServices.svc/Users/SomeUser"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

		}

		Context "Input - V11" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"id"          = 1234
					"UserName"    = "SomeUser"
					"NewPassword" = $("P_Password" | ConvertTo-SecureString -AsPlainText -Force)
					"FirstName"   = "Some"
					"LastName"    = "User"
					"ExpiryDate"  = "10/31/2018"
					"workStreet"  = "SomeStreet"
					"homePage"    = "www.geocities.com"
					"faxNumber"   = "1979"

				}

				$response = $InputObj | Set-PASUser

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/api/Users/1234"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {
				$Script:ExternalVersion = "1.0"

				{ $InputObj | Set-PASUser } | Should -Throw
				$Script:ExternalVersion = "0.0"

			}


		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"UserName"    = "SomeUser"
					"NewPassword" = $("P_Password" | ConvertTo-SecureString -AsPlainText -Force)
					"FirstName"   = "Some"
					"LastName"    = "User"
					"ExpiryDate"  = "10/31/2018"

				}

				$response = $InputObj | Set-PASUser -NewPassword $("P_Password" | ConvertTo-SecureString -AsPlainText -Force) -ExpiryDate "10/31/2018" -UseClassicAPI

			}

			it "provides output" {

				$response | Should -Not -BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should -Be psPAS.CyberArk.Vault.User

			}



		}

	}

}