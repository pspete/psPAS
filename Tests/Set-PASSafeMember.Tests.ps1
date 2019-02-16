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
					"MembershipExpirationDate" = "31/12/2018"
					"Permissions"              = @(
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

		$InputObj = [pscustomobject]@{
			"sessionToken"                           = @{"Authorization" = "P_AuthValue"}
			"WebSession"                             = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"                                = "https://P_URI"
			"PVWAAppName"                            = "P_App"
			"SafeName"                               = "SomeSafe"
			"MemberName"                             = "SomeUser"
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

				(Get-Command Set-PASSafeMember).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		$response = $InputObj | Set-PASSafeMember -MembershipExpirationDate 12/31/18

		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Safes/SomeSafe/Members/SomeUser"

				} -Times 1 -Exactly -Scope Describe

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'PUT' } -Times 1 -Exactly -Scope Describe

			}

			It "throws if invalid date pattern specified" {

				{$InputObj | Set-PASSafeMember -MembershipExpirationDate "31/12/18"} | Should throw

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.member) -ne $null

				} -Times 1 -Exactly -Scope Describe

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody.member | Get-Member -MemberType NoteProperty).length | Should Be 2

			}

			It "has expected number of nested properties" {

				($Script:RequestBody.member.permissions).Count | Should Be 21

			}

		}

		Context "Output" {

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 9

			}

			It "has expected number of nested array elements" {

				($response.permissions).count | Should Be 4

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Safe.Member

			}

			it "outputs object with expected safename property" {

				$response.SafeName | Should Be "SomeSafe"

			}

			it "outputs object with expected username property" {

				$response.UserName | Should Be "SomeUser"

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