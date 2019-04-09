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

				(Get-Command Get-PASAccount).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "Request Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					Write-Output @{ }
				}

				$InputObj = [pscustomobject]@{
					"sessionToken" = @{"Authorization" = "P_AuthValue" }
					"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"      = "https://P_URI"
					"PVWAAppName"  = "P_App"
				}

			}

			It "sends request - v10ByID parameterset" {

				$InputObj | Get-PASAccount -ID "SomeID"

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request - v10ByQuery parameterset" {

				$InputObj | Get-PASAccount -search SearchTerm

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request - legacy parameterset" {

				$InputObj | Get-PASAccount -Keywords SomeValue -Safe SomeSafe

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - v10ByQuery parameterset" {

				$InputObj | Get-PASAccount -search SearchTerm

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/api/Accounts?search=SearchTerm"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - v10ByID parameterset" {

				$InputObj | Get-PASAccount -ID "SomeID"

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/api/Accounts/SomeID"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - legacy parameterset" {

				$InputObj | Get-PASAccount -Keywords SomeValue -Safe SomeSafe

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					(($URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Accounts?Keywords=SomeValue&Safe=SomeSafe") -or
						($URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Accounts?Safe=SomeSafe&Keywords=SomeValue"))

				} -Times 1 -Exactly -Scope It

			}

			It "sends request using expected method" {

				$InputObj | Get-PASAccount -Keywords SomeValue -Safe SomeSafe

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {

				$InputObj | Get-PASAccount -Keywords SomeValue -Safe SomeSafe

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {
				{ $InputObj | Get-PASAccount -ID "SomeID" -ExternalVersion "1.0" } | Should Throw
			}

		}

		Context "Response Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					$result = [pscustomobject]@{
						"Count"    = 30
						"Accounts" = [pscustomobject]@{
							"AccountID"          = "66_6"
							"Properties"         = @(
								[pscustomobject]@{
									"Key"   = "Safe"
									"Value" = "zzTestSafe1"
								},
								[pscustomobject]@{
									"Key"   = "Folder"
									"Value" = "Root"
								},
								[pscustomobject]@{
									"Key"   = "Name"
									"Value" = "Operating System-_Test_WinDomain-VIRTUALREAL.IT-user01"
								},
								[pscustomobject]@{
									"Key"   = "UserName"
									"Value" = "user01"
								},
								[pscustomobject]@{
									"Key"   = "PolicyID"
									"Value" = "_Test_WinDomain"
								},
								[pscustomobject]@{
									"Key"   = "LogonDomain"
									"Value" = "VIRTUALREAL"
								},
								[pscustomobject]@{
									"Key"   = "LastSuccessVerification"
									"Value" = "1511973510"
								},
								[pscustomobject]@{
									"Key"   = "Address"
									"Value" = "VIRTUALREAL.IT"
								},
								[pscustomobject]@{
									"Key"   = "DeviceType"
									"Value" = "Operating System"
								}
							)
							"InternalProperties" = @(
								[pscustomobject]@{
									"Key"   = "CPMStatus"
									"Value" = "success"
								},
								[pscustomobject]@{
									"Key"   = "SequenceID"
									"Value" = "1"
								},
								[pscustomobject]@{
									"Key"   = "CreationMethod"
									"Value" = "PVWA"
								},
								[pscustomobject]@{
									"Key"   = "RetriesCount"
									"Value" = "-1"
								},
								[pscustomobject]@{
									"Key"   = "LastSuccessChange"
									"Value" = "1516127648"
								},
								[pscustomobject]@{
									"Key"   = "LastTask"
									"Value" = "ChangeTask"
								}
							)
						}
					}
					return $result

				}

				$InputObj = [pscustomobject]@{
					"sessionToken" = @{"Authorization" = "P_AuthValue" }
					"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"      = "https://P_URI"
					"PVWAAppName"  = "P_App"
				}

			}

			It "provides output - legacy parameterset" {
				$response = $InputObj | Get-PASAccount -Keywords SomeValue -Safe SomeSafe -WarningAction SilentlyContinue
				$response | Should not be null

			}

			It "provides output - V10ByID parameterset" {
				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						"Count" = 30
						"Value" = [pscustomobject]@{"Prop1" = "Val1" }
					}
				}
				$response = $InputObj | Get-PASAccount -id "SomeID"
				$response | Should not be null

			}

			It "provides output - V10ByQuery parameterset" {
				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						"Count" = 30
						"Value" = [pscustomobject]@{"Prop1" = "Val1" }
					}
				}
				$response = $InputObj | Get-PASAccount -search SomeSearchTerm
				$response | Should not be null

			}

			It "processes NextLink" {
				Mock Invoke-PASRestMethod -MockWith {
					if ($script:iteration -lt 10) {
						[pscustomobject]@{
							"Count"    = 30
							"nextLink" = "SomeLink"
							"Value"    = [pscustomobject]@{"Prop1" = "Val1" }
						}
						$script:iteration++
					} else {
						[pscustomobject]@{
							"Count" = 30
							"Value" = [pscustomobject]@{"Prop1" = "Val1" }
						}
					}
				}
				$script:iteration = 1
				$InputObj | Get-PASAccount
				Assert-MockCalled Invoke-PASRestMethod -Times 10 -Exactly -Scope It

			}

			It "has output with expected number of properties - legacy parameterset" {
				$response = $InputObj | Get-PASAccount -Keywords SomeValue -Safe SomeSafe -WarningAction SilentlyContinue
				($response | Get-Member -MemberType NoteProperty).length | Should Be 16

			}

			It "outputs object with expected typename - legacy parameterset" {
				$response = $InputObj | Get-PASAccount -Keywords SomeValue -Safe SomeSafe -WarningAction SilentlyContinue
				$response | Get-Member | Select-Object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Account

			}

			It "outputs object with expected typename - v10 parameterset" {
				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						"Count" = 30
						"Value" = [pscustomobject]@{"Prop1" = "Val1" }
					}
				}
				$response = $InputObj | Get-PASAccount -search SomeSearch
				$response | Get-Member | Select-Object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Account.V10

			}

			It "writes warning that more than 1 account returned from the search - legacy parameterset" {
				$response = $InputObj | Get-PASAccount -Keywords SomeValue -Safe SomeSafe -WarningVariable warning -WarningAction SilentlyContinue
				$warning | Should be "30 matching accounts found. Only the first result will be returned"

			}

			$DefaultProps = @{Property = 'sessionToken' },
			@{Property = 'WebSession' },
			@{Property = 'BaseURI' },
			@{Property = 'PVWAAppName' },
			@{Property = 'ExternalVersion' }

			It "returns default property <Property> in response" -TestCases $DefaultProps {
				param($Property)

				$($InputObj | Get-PASAccount -Keywords SomeValue -Safe SomeSafe -WarningAction SilentlyContinue).$Property | Should Not BeNullOrEmpty

			}

		}

	}

}