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

if( -not (Get-Module -Name $ModuleName -All)) {

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

		Mock Invoke-PASRestMethod -MockWith {
			[PSCustomObject]@{
				"member" = [PSCustomObject]@{
					"MemberName"               = "SomeMember"
					"MembershipExpirationDate" = "1/1/1970"
					"SearchIn"                 = "SomePlace"
					"Permissions"              = @(
						[pscustomobject]@{
							"Key"   = "Key1"
							"Value" = "Value1"
						},
						[pscustomobject]@{
							"Key"   = "Key2"
							"Value" = "Value2"
						},
						[pscustomobject]@{
							"Key"   = "TrueKey"
							"Value" = "true"
						},
						[pscustomobject]@{
							"Key"   = "FalseKey"
							"Value" = $false
						},
						[pscustomobject]@{
							"Key"   = "AnotherKey"
							"Value" = "AnotherValue"
						},
						[pscustomobject]@{
							"Key"   = "AnotherFalseKey"
							"Value" = $false
						}


					)
				}
			}

		}

		$InputObj = [pscustomobject]@{
			"sessionToken"                           = @{"Authorization" = "P_AuthValue"}
			"WebSession"                             = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"                                = "https://P_URI"
			"PVWAAppName"                            = "P_App"
			"SafeName"                               = "SomeSafe"
			"MemberName"                             = "SomeUser"
			"SearchIn"                               = "SomePlace"
			"UseAccounts"                            = $true
			"RetrieveAccounts"                       = $true
			"ListAccounts"                           = $true
			"AddAccounts"                            = $false
			"UpdateAccountContent"                   = $false
			"UpdateAccountProperties"                = $false
			"InitiateCPMAccountManagementOperations" = $true
			"SpecifyNextAccountContent"              = $false
			"RenameAccounts"                         = $false
			"DeleteAccounts"                         = $false
			"UnlockAccounts"                         = $true
			"ManageSafe"                             = $false
			"ManageSafeMembers"                      = $false
			"BackupSafe"                             = $false
			"ViewAuditLog"                           = $true
			"ViewSafeMembers"                        = $true
			"RequestsAuthorizationLevel"             = 0
			"AccessWithoutConfirmation"              = $false
			"CreateFolders"                          = $false
			"DeleteFolders"                          = $false
			"MoveAccountsAndFolders"                 = $false


		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'},
			@{Parameter = 'SafeName'},
			@{Parameter = 'MemberName'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASSafeMember).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		$response = $InputObj | Add-PASSafeMember -MembershipExpirationDate "12/31/18"

		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Safes/SomeSafe/Members"

				} -Times 1 -Exactly -Scope Describe

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope Describe

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.member) -ne $null

				} -Times 1 -Exactly -Scope Describe

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody.member | Get-Member -MemberType NoteProperty).length | Should Be 4

			}

			It "has expected number of nested properties" {

				($Script:RequestBody.member.permissions).Count | Should Be 21

			}

			It "throws if invalid date pattern specified" {

				{$InputObj | Add-PASSafeMember -MembershipExpirationDate "31/12/18"} | Should throw

			}

		}

		Context "Output" {

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 10

			}

			It "has expected number of nested properties" {

				($response.permissions).count | Should Be 4

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Safe.Member.Extended

			}

			$DefaultProps = @{Property = 'sessionToken'},
			@{Property = 'WebSession'},
			@{Property = 'BaseURI'},
			@{Property = 'PVWAAppName'},
			@{Property = 'ExternalVersion'}

			It "returns default property <Property> in response" -TestCases $DefaultProps {
				param($Property)

				$response.$Property | Should Not BeNullOrEmpty

			}

		}

	}

}