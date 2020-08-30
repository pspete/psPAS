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

			It "specifies parameter UserName as mandatory for ParameterSet Gen1" {

				(Get-Command New-PASUser).Parameters["UserName"].ParameterSets["Gen1"].IsMandatory | Should -Be $true

			}

			It "specifies parameter UserName as mandatory for ParameterSet Gen2" {

				(Get-Command New-PASUser).Parameters["UserName"].ParameterSets["Gen2"].IsMandatory | Should -Be $true

			}

			It "specifies parameter InitialPassword as mandatory for ParameterSet Gen1" {

				(Get-Command New-PASUser).Parameters["InitialPassword"].ParameterSets["Gen1"].IsMandatory | Should -Be $true

			}

		}

		Context "Input - Gen1" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"UserName"        = "SomeUser"
					"InitialPassword" = $("P_Password" | ConvertTo-SecureString -AsPlainText -Force)
					"FirstName"       = "Some"
					"LastName"        = "User"
					"ExpiryDate"      = "10/31/2018"

				}

				$response = $InputObj | New-PASUser -UseClassicAPI

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/WebServices/PIMServices.svc/Users"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 5

			}

		}

		Context "Input - Gen2" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"UserName"        = "SomeUser"
					"InitialPassword" = $("P_Password" | ConvertTo-SecureString -AsPlainText -Force)
					"FirstName"       = "Some"
					"LastName"        = "User"
					"ExpiryDate"      = "10/31/2018"
					"workStreet"      = "SomeStreet"
					"homePage"        = "www.geocities.com"
					"faxNumber"       = "1979"

				}

				$response = $InputObj | New-PASUser

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/api/Users"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 7

			}

			It "throws error if version requirement not met" {
				$Script:ExternalVersion = "1.0"

				{ $InputObj | New-PASUser } | Should -Throw
				$Script:ExternalVersion = "0.0"

			}


		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"UserName"        = "SomeUser"
					"InitialPassword" = $("P_Password" | ConvertTo-SecureString -AsPlainText -Force)
					"FirstName"       = "Some"
					"LastName"        = "User"
					"ExpiryDate"      = "10/31/2018"

				}

				$response = $InputObj | New-PASUser -UseClassicAPI

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
				$response = $InputObj | New-PASUser
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.User.Extended

			}



		}

	}

}