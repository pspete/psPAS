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

				(Get-Command Set-PASSafeMember).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}



		Context 'Gen1 Input' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {}

				$InputObj = [pscustomobject]@{
					'SafeName'                               = 'SomeSafe'
					'MemberName'                             = 'SomeUser'
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
					'RequestsAuthorizationLevel'             = 1
					'AccessWithoutConfirmation'              = $false
					'CreateFolders'                          = $false
					'DeleteFolders'                          = $false
					'MoveAccountsAndFolders'                 = $false


				}

				$response = $InputObj | Set-PASSafeMember -MembershipExpirationDate 12/31/18 -UseGen1API
			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Safes/SomeSafe/Members/SomeUser/"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'throws if invalid date pattern specified' {

				{ $InputObj | Set-PASSafeMember -MembershipExpirationDate '31/12/18' } | Should -Throw

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.member) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody.member | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It 'has expected number of nested properties' {

				($Script:RequestBody.member.permissions).Count | Should -Be 21

			}

		}

		Context 'Gen2 Input' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {}
				Mock Get-PASSafeMember -MockWith {}

				$InputObj = [pscustomobject]@{
					'SafeName'                               = 'SomeSafe'
					'MemberName'                             = 'SomeUser'
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

				$response = $InputObj | Set-PASSafeMember -MembershipExpirationDate 12/31/18
			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Safes/SomeSafe/Members/SomeUser/"

				} -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '12.1'
				{ $InputObj | Set-PASSafeMember } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Gen1 Output' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'member' = [PSCustomObject]@{
							'MembershipExpirationDate' = '31/12/2018'
							'Permissions'              = @(
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
					'RequestsAuthorizationLevel'             = 1
					'AccessWithoutConfirmation'              = $false
					'CreateFolders'                          = $false
					'DeleteFolders'                          = $false
					'MoveAccountsAndFolders'                 = $false


				}

				$response = $InputObj | Set-PASSafeMember -MembershipExpirationDate 12/31/18 -UseGen1API
			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 4

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

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe.Member

			}

			It 'outputs object with expected safename property' {

				$response.SafeName | Should -Be 'SomeSafe'

			}

			It 'outputs object with expected username property' {

				$response.UserName | Should -Be 'SomeUser'

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

				Mock Get-PASSafeMember -MockWith {}
				$response = $InputObj | Set-PASSafeMember -MembershipExpirationDate '12/31/18'

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