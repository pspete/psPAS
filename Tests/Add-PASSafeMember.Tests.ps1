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
		$psPASSession = [ordered]@{
			BaseURI            = 'https://SomeURL/SomeApp'
			User               = $null
			ExternalVersion    = [System.Version]'0.0'
			WebSession         = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			StartTime          = $null
			ElapsedTime        = $null
			LastCommand        = $null
			LastCommandTime    = $null
			LastCommandResults = $null
		}

		New-Variable -Name psPASSession -Value $psPASSession -Scope Script -Force

	}


	AfterAll {

		$Script:RequestBody = $null

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'SafeName' },
			@{Parameter = 'MemberName' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASSafeMember).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Gen1 Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'member' = [PSCustomObject]@{
							'MemberName'               = 'SomeMember'
							'MembershipExpirationDate' = '1/1/1970'
							'SearchIn'                 = 'SomePlace'
							'Permissions'              = @(
								[pscustomobject]@{
									'Key'   = 'Key1'
									'Value' = 'Value1'
								},
								[pscustomobject]@{
									'Key'   = 'Key2'
									'Value' = 'Value2'
								},
								[pscustomobject]@{
									'Key'   = 'TrueKey'
									'Value' = 'true'
								},
								[pscustomobject]@{
									'Key'   = 'FalseKey'
									'Value' = $false
								},
								[pscustomobject]@{
									'Key'   = 'AnotherKey'
									'Value' = 'AnotherValue'
								},
								[pscustomobject]@{
									'Key'   = 'AnotherFalseKey'
									'Value' = $false
								},
								[pscustomobject]@{
									'Key'   = 'IntegerKey'
									'Value' = 1
								}


							)
						}
					}

				}

				$InputObj = [pscustomobject]@{
					'SafeName'                               = 'SomeSafe'
					'MemberName'                             = 'SomeUser'
					'SearchIn'                               = 'SomePlace'
					'UseAccounts'                            = $true
					'RetrieveAccounts'                       = $true
					'ListAccounts'                           = $true
					'AddAccounts'                            = $false
					'UpdateAccountContent'                   = $false
					'UpdateAccountProperties'                = $false
					'InitiateCPMAccountManagementOperations' = $true
					'SpecifyNextAccountContent'              = $false
					'RenameAccounts'                         = $false
					'DeleteAccounts'                         = $false
					'UnlockAccounts'                         = $true
					'ManageSafe'                             = $false
					'ManageSafeMembers'                      = $false
					'BackupSafe'                             = $false
					'ViewAuditLog'                           = $true
					'ViewSafeMembers'                        = $true
					'RequestsAuthorizationLevel'             = 0
					'AccessWithoutConfirmation'              = $false
					'CreateFolders'                          = $false
					'DeleteFolders'                          = $false
					'MoveAccountsAndFolders'                 = $false


				}

				$response = $InputObj | Add-PASSafeMember -MembershipExpirationDate '12/31/18' -UseGen1API

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Safes/SomeSafe/Members"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.member) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody.member | Get-Member -MemberType NoteProperty).length | Should -Be 4

			}

			It 'has expected number of nested properties' {

				($Script:RequestBody.member.permissions).Count | Should -Be 21

			}

			It 'throws if invalid date pattern specified' {

				{ $InputObj | Add-PASSafeMember -MembershipExpirationDate '31/12/18' } | Should -Throw

			}

			It 'throws error if version exceeds 12.2' {
				$psPASSession.ExternalVersion = '12.3'
				{ Find-PASSafe } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Gen2 Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'MemberName'               = 'SomeMember'
						'MembershipExpirationDate' = '1/1/1970'
						'SearchIn'                 = 'SomePlace'
						'Permissions'              = [pscustomobject]@{
							'Key1'            = 'Value1'
							'Key2'            = 'Value2'
							'TrueKey'         = 'true'
							'FalseKey'        = $false
							'AnotherKey'      = 'AnotherValue'
							'AnotherFalseKey' = $false
							'IntegerKey'      = 1
						}

					}

				}

				$InputObj = [pscustomobject]@{
					'SafeName'                               = 'SomeSafe'
					'MemberName'                             = 'SomeUser'
					'SearchIn'                               = 'SomePlace'
					'MemberType'                             = 'Group'
					'UseAccounts'                            = $true
					'RetrieveAccounts'                       = $true
					'ListAccounts'                           = $true
					'AddAccounts'                            = $false
					'UpdateAccountContent'                   = $false
					'UpdateAccountProperties'                = $false
					'InitiateCPMAccountManagementOperations' = $true
					'SpecifyNextAccountContent'              = $false
					'RenameAccounts'                         = $false
					'DeleteAccounts'                         = $false
					'UnlockAccounts'                         = $true
					'ManageSafe'                             = $false
					'ManageSafeMembers'                      = $false
					'BackupSafe'                             = $false
					'ViewAuditLog'                           = $true
					'ViewSafeMembers'                        = $true
					'AccessWithoutConfirmation'              = $false
					'CreateFolders'                          = $false
					'DeleteFolders'                          = $false
					'MoveAccountsAndFolders'                 = $false
					'requestsAuthorizationLevel1'            = $true



				}

				$response = $InputObj | Add-PASSafeMember -MembershipExpirationDate '12/31/18'

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Safes/SomeSafe/Members"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 5

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ $InputObj | Add-PASSafeMember } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Gen1 Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'member' = [PSCustomObject]@{
							'MemberName'               = 'SomeMember'
							'MembershipExpirationDate' = '1/1/1970'
							'SearchIn'                 = 'SomePlace'
							'Permissions'              = @(
								[pscustomobject]@{
									'Key'   = 'Key1'
									'Value' = 'Value1'
								},
								[pscustomobject]@{
									'Key'   = 'Key2'
									'Value' = 'Value2'
								},
								[pscustomobject]@{
									'Key'   = 'TrueKey'
									'Value' = 'true'
								},
								[pscustomobject]@{
									'Key'   = 'FalseKey'
									'Value' = $false
								},
								[pscustomobject]@{
									'Key'   = 'AnotherKey'
									'Value' = 'AnotherValue'
								},
								[pscustomobject]@{
									'Key'   = 'AnotherFalseKey'
									'Value' = $false
								},
								[pscustomobject]@{
									'Key'   = 'IntegerKey'
									'Value' = 1
								}


							)
						}
					}

				}

				$InputObj = [pscustomobject]@{
					'SafeName'                               = 'SomeSafe'
					'MemberName'                             = 'SomeUser'
					'SearchIn'                               = 'SomePlace'
					'UseAccounts'                            = $true
					'RetrieveAccounts'                       = $true
					'ListAccounts'                           = $true
					'AddAccounts'                            = $false
					'UpdateAccountContent'                   = $false
					'UpdateAccountProperties'                = $false
					'InitiateCPMAccountManagementOperations' = $true
					'SpecifyNextAccountContent'              = $false
					'RenameAccounts'                         = $false
					'DeleteAccounts'                         = $false
					'UnlockAccounts'                         = $true
					'ManageSafe'                             = $false
					'ManageSafeMembers'                      = $false
					'BackupSafe'                             = $false
					'ViewAuditLog'                           = $true
					'ViewSafeMembers'                        = $true
					'RequestsAuthorizationLevel'             = 0
					'AccessWithoutConfirmation'              = $false
					'CreateFolders'                          = $false
					'DeleteFolders'                          = $false
					'MoveAccountsAndFolders'                 = $false


				}

				$response = $InputObj | Add-PASSafeMember -MembershipExpirationDate '12/31/18' -UseGen1API

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 5

			}

			It 'has expected number of nested permission properties' {

				($response.permissions | Get-Member -MemberType NoteProperty).count | Should -Be 7

			}

			It 'has expected boolean false property value' {

				$response.permissions.FalseKey | Should -Be $False


			}

			It 'has expected boolean true property value' {


				$response.permissions.TrueKey | Should -Be $True

			}

			It 'has expected integer property value' {


				$response.permissions.IntegerKey | Should -Be 1

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe.Member.Extended

			}

		}

		Context 'Gen2 Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'MemberName'               = 'SomeMember'
						'MembershipExpirationDate' = '1/1/1970'
						'SearchIn'                 = 'SomePlace'
						'Permissions'              = [pscustomobject]@{
							'Key1'            = 'Value1'
							'Key2'            = 'Value2'
							'TrueKey'         = 'true'
							'FalseKey'        = $false
							'AnotherKey'      = 'AnotherValue'
							'AnotherFalseKey' = $false
							'IntegerKey'      = 1
						}

					}

				}

				$InputObj = [pscustomobject]@{
					'SafeName'                               = 'SomeSafe'
					'MemberName'                             = 'SomeUser'
					'SearchIn'                               = 'SomePlace'
					'UseAccounts'                            = $true
					'RetrieveAccounts'                       = $true
					'ListAccounts'                           = $true
					'AddAccounts'                            = $false
					'UpdateAccountContent'                   = $false
					'UpdateAccountProperties'                = $false
					'InitiateCPMAccountManagementOperations' = $true
					'SpecifyNextAccountContent'              = $false
					'RenameAccounts'                         = $false
					'DeleteAccounts'                         = $false
					'UnlockAccounts'                         = $true
					'ManageSafe'                             = $false
					'ManageSafeMembers'                      = $false
					'BackupSafe'                             = $false
					'ViewAuditLog'                           = $true
					'ViewSafeMembers'                        = $true
					'AccessWithoutConfirmation'              = $false
					'CreateFolders'                          = $false
					'DeleteFolders'                          = $false
					'MoveAccountsAndFolders'                 = $false
					'requestsAuthorizationLevel1'            = $true



				}

				$response = $InputObj | Add-PASSafeMember -MembershipExpirationDate '12/31/18'

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 5

			}

			It 'has expected number of nested permission properties' {

				($response.permissions | Get-Member -MemberType NoteProperty).count | Should -Be 7

			}

			It 'has expected boolean false property value' {

				$response.permissions.FalseKey | Should -Be $False


			}

			It 'has expected boolean true property value' {


				$response.permissions.TrueKey | Should -Be $True

			}

			It 'has expected integer property value' {


				$response.permissions.IntegerKey | Should -Be 1

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe.Member.Gen2

			}

		}

	}

}