#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repository Root folder
$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

if ( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

}

BeforeAll {

	$Script:RequestBody = $null

}

AfterAll {

	$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI' },
			@{Parameter = 'SessionToken' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command New-PASUser).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

			It "specifies parameter UserName as mandatory for ParameterSet legacy" {

				(Get-Command New-PASUser).Parameters["UserName"].ParameterSets["legacy"].IsMandatory | Should be $true

			}

			It "specifies parameter UserName as mandatory for ParameterSet 10_9" {

				(Get-Command New-PASUser).Parameters["UserName"].ParameterSets["10_9"].IsMandatory | Should be $true

			}

			It "specifies parameter InitialPassword as mandatory for ParameterSet legacy" {

				(Get-Command New-PASUser).Parameters["InitialPassword"].ParameterSets["legacy"].IsMandatory | Should be $true

			}

		}

		Context "Input - legacy" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"sessionToken"    = @{"Authorization" = "P_AuthValue" }
					"WebSession"      = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"         = "https://P_URI"
					"PVWAAppName"     = "P_App"
					"UserName"        = "SomeUser"
					"InitialPassword" = $("P_Password" | ConvertTo-SecureString -AsPlainText -Force)
					"FirstName"       = "Some"
					"LastName"        = "User"
					"ExpiryDate"      = "10/31/2018"

				}

				$response = $InputObj | New-PASUser -UseV9API

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Users"

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

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 5

			}

		}

		Context "Input - V10" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"sessionToken"    = @{"Authorization" = "P_AuthValue" }
					"WebSession"      = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"         = "https://P_URI"
					"PVWAAppName"     = "P_App"
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

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/api/Users"

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

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 7

			}

			It "throws error if version requirement not met" {

				{ $InputObj | New-PASUser -ExternalVersion "1.0" } | Should Throw

			}


		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"sessionToken"    = @{"Authorization" = "P_AuthValue" }
					"WebSession"      = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"         = "https://P_URI"
					"PVWAAppName"     = "P_App"
					"UserName"        = "SomeUser"
					"InitialPassword" = $("P_Password" | ConvertTo-SecureString -AsPlainText -Force)
					"FirstName"       = "Some"
					"LastName"        = "User"
					"ExpiryDate"      = "10/31/2018"

				}

				$response = $InputObj | New-PASUser -UseV9API

			}

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 7

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.User

			}

			it "outputs object with expected typename - V10" {
				$response = $InputObj | New-PASUser
				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.User.Extended

			}

			$DefaultProps = @{Property = 'sessionToken' },
			@{Property = 'WebSession' },
			@{Property = 'BaseURI' },
			@{Property = 'PVWAAppName' },
			@{Property = 'ExternalVersion' }

			It "returns default property <Property> in response" -TestCases $DefaultProps {
				param($Property)

				$response.$Property | Should Not BeNullOrEmpty

			}

		}

	}

}