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
			@{Parameter = 'SessionToken' },
			@{Parameter = 'SafeName' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASSafeMember).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					"sessionToken" = @{"Authorization" = "P_AuthValue" }
					"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"      = "https://P_URI"
					"PVWAAppName"  = "P_App"
					"SafeName"     = "SomeSafe"

				}

				$response = $InputObj | Get-PASSafeMember

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Safes/SomeSafe/Members"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				$response = $InputObj | Get-PASSafeMember -MemberName SomeMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Safes/SomeSafe/Members/SomeMember"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected GET method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "uses expected PUT method" {

				$response = $InputObj | Get-PASSafeMember -MemberName SomeMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						"members" = [PSCustomObject]@{
							"UserName"    = "SomeMember"
							"Permissions" = [pscustomobject]@{
								"Key1"            = $true
								"Key2"            = $true
								"FalseKey"        = $false
								"AnotherKey"      = $true
								"AnotherFalseKey" = $false
							}
						}
					}

				}

				$InputObj = [pscustomobject]@{
					"sessionToken" = @{"Authorization" = "P_AuthValue" }
					"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"      = "https://P_URI"
					"PVWAAppName"  = "P_App"
					"SafeName"     = "SomeSafe"

				}

				$response = $InputObj | Get-PASSafeMember

			}

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 8

			}

			It "has expected number of nested array elements" {

				($response.permissions).count | Should Be 3

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Safe.Member

			}

			it "outputs object with expected safename property" {

				$response.SafeName | Should Be "SomeSafe"

			}

			it "outputs object with expected username property" {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						"member" = [PSCustomObject]@{
							"Permissions" = @(
								[pscustomobject]@{
									"Key"   = "Key1"
									"Value" = $true
								},
								[pscustomobject]@{
									"Key"   = "Key2"
									"Value" = $true
								},
								[pscustomobject]@{
									"Key"   = "TrueKey"
									"Value" = $true
								},
								[pscustomobject]@{
									"Key"   = "FalseKey"
									"Value" = $false
								},
								[pscustomobject]@{
									"Key"   = "AnotherKey"
									"Value" = $true
								},
								[pscustomobject]@{
									"Key"   = "AnotherFalseKey"
									"Value" = $false
								}


							)
						}
					}

				}

				$response = $InputObj | Get-PASSafeMember -MemberName SomeMember

				$response.UserName | Should Be "SomeMember"

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