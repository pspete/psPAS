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
	$Script:BaseURI = "https://SomeURL/SomeApp"
	$Script:ExternalVersion = "0.0"
	$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

}

AfterAll {

	$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'UserName' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASUser).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"UserName"     = "SomeUser"

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

			It "sends request to expected endpoint -V10" {

				$InputObjV10 | Get-PASUser

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					(($URI -eq "$($Script:BaseURI)/api/Users?Search=SomeUser&ComponentUser=True") -or
						($URI -eq "$($Script:BaseURI)/api/Users?ComponentUser=True&Search=SomeUser"))

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {

				{ $InputObjV10 | Get-PASUser -ExternalVersion "1.0" } | Should Throw

			}

		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
				}

				$InputObj = [pscustomobject]@{
					"UserName"     = "SomeUser"

				}

				$InputObjV10 = [PSCustomObject]@{
					"Search"        = "SomeUser"
					"ComponentUser" = $true

				}

				$response = $InputObj | Get-PASUser

			}
			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 2

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.User

			}

			it "outputs object with expected typename - V10" {

				Mock Invoke-PASRestMethod -MockWith { [PSCustomObject]@{"Users" =
						[PSCustomObject]@{"Detail1" = "Detail"; "Detail2" = "Detail" }
					}
				}

				$response = $InputObjV10 | Get-PASUser
				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.User.Extended

			}



		}

	}

}