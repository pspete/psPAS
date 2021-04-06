Describe $($PSCommandPath -Replace '.Tests.ps1') {

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
		$Script:BaseURI = 'https://SomeURL/SomeApp'
		$Script:ExternalVersion = '0.0'
		$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

	}


	AfterAll {

		$Script:RequestBody = $null

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		Context 'Gen1 Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeSafe'

				}

				$response = Get-PASSafeMember -SafeName SomeSafe -UseGen1API

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/WebServices/PIMServices.svc/Safes/SomeSafe/Members"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				$response = $InputObj | Get-PASSafeMember -MemberName SomeMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/WebServices/PIMServices.svc/Safes/SomeSafe/Members/SomeMember"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected GET method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'uses expected PUT method' {

				$response = Get-PASSafeMember -SafeName SomeSafe -MemberName SomeMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'throws for PUT method if version exceeds 12.2' {

				$Script:ExternalVersion = '12.3'
				{ Get-PASSafeMember -SafeName SomeSafe -MemberName SomeMember } | Should -Throw
				$Script:ExternalVersion = '0.0'

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Gen2 Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeSafe'

				}

				$response = Get-PASSafeMember -SafeName SomeSafe

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/api/Safes/SomeSafe/Members"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends expected query' {
				Get-PASSafeMember -SafeName SomeSafe -search SomeMember -memberType user
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/api/Safes/SomeSafe/Members?filter=memberType%20eq%20user&search=SomeMember"

				} -Times 1 -Exactly -Scope It
			}

			It 'uses expected GET method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version 12.0 requirement not met' {
				$Script:ExternalVersion = '1.0'
				{ Get-PASSafeMember -SafeName SomeSafe } | Should -Throw
				$Script:ExternalVersion = '0.0'
			}

			It 'throws error if version 12.1 requirement not met' {
				$Script:ExternalVersion = '12.0'
				{ Get-PASSafeMember -SafeName SomeSafe -search SomeMember } | Should -Throw
				$Script:ExternalVersion = '0.0'
			}

		}

		Context 'Gen1 Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'members' = [PSCustomObject]@{
							'UserName'    = 'SomeMember'
							'Permissions' = [pscustomobject]@{
								'Key1'            = $true
								'Key2'            = $true
								'FalseKey'        = $false
								'AnotherKey'      = $true
								'AnotherFalseKey' = $false
								'IntegerKey'      = 1
							}
						}
					}

				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeSafe'

				}

				$response = $InputObj | Get-PASSafeMember -UseGen1API

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

			It 'has expected number of nested permission properties' {

				($response.permissions | Get-Member -MemberType NoteProperty).count | Should -Be 6

			}

			It 'has expected boolean false property value' {

				$response.permissions.FalseKey | Should -Be $False


			}

			It 'has expected boolean true property value' {


				$response.permissions.Key1 | Should -Be $True

			}

			It 'has expected integer property value' {


				$response.permissions.IntegerKey | Should -Be 1

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe.Member

			}

			It 'outputs object with expected safename property' {

				$response.SafeName | Should -Be 'SomeSafe'

			}

			It 'outputs object with expected username property' {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'member' = [PSCustomObject]@{
							'Permissions' = @(
								[pscustomobject]@{
									'Key'   = 'Key1'
									'Value' = $true
								},
								[pscustomobject]@{
									'Key'   = 'Key2'
									'Value' = $true
								},
								[pscustomobject]@{
									'Key'   = 'TrueKey'
									'Value' = $true
								},
								[pscustomobject]@{
									'Key'   = 'FalseKey'
									'Value' = $false
								},
								[pscustomobject]@{
									'Key'   = 'AnotherKey'
									'Value' = $true
								},
								[pscustomobject]@{
									'Key'   = 'AnotherFalseKey'
									'Value' = $false
								}


							)
						}
					}

				}

				$response = $InputObj | Get-PASSafeMember -MemberName SomeMember

				$response.UserName | Should -Be 'SomeMember'

			}



		}

		Context 'Gen2 Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'Count' = 1
						'Value' = @(
							[PSCustomObject]@{
								'safeUrlId'                 = 'SomeSafe'
								'safeName'                  = 'SomeSafe'
								'safeNumber'                = 37
								'memberId'                  = 0
								'memberName'                = 'SomeMember'
								'memberType'                = 'User'
								'membershipExpirationDate'  = $null
								'isExpiredMembershipEnable' = $false
								'isPredefinedUser'          = $true
								'permissions'               = [PSCustomObject]@{
									'useAccounts'                            = $true
									'retrieveAccounts'                       = $true
									'listAccounts'                           = $true
									'addAccounts'                            = $true
									'updateAccountContent'                   = $true
									'updateAccountProperties'                = $true
									'initiateCPMAccountManagementOperations' = $true
									'specifyNextAccountContent'              = $true
									'renameAccounts'                         = $true
									'deleteAccounts'                         = $true
									'unlockAccounts'                         = $true
									'manageSafe'                             = $true
									'manageSafeMembers'                      = $true
									'backupSafe'                             = $true
									'viewAuditLog'                           = $true
									'viewSafeMembers'                        = $true
									'accessWithoutConfirmation'              = $true
									'createFolders'                          = $true
									'deleteFolders'                          = $true
									'moveAccountsAndFolders'                 = $true
									'requestsAuthorizationLevel1'            = $false
									'requestsAuthorizationLevel2'            = $false
								}

							}
						)

					}

				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeSafe'
				}


				$response = $InputObj | Get-PASSafeMember

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 11

			}

			It 'has expected number of nested permission properties' {

				($response.permissions | Get-Member -MemberType NoteProperty).count | Should -Be 22

			}

			It 'has expected boolean false property value' {

				$response.permissions.requestsAuthorizationLevel1 | Should -Be $False


			}

			It 'has expected boolean true property value' {


				$response.permissions.createFolders | Should -Be $True

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe.Member.Gen2

			}

		}

	}

}