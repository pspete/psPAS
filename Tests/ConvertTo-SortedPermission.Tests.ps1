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

		Context 'Gen1 General' {

			BeforeEach {

				$InputObj = @{
					Property1 = 'Value'
					Property2 = 'Another Value'
				}

				$Permissions = @{
					RequestsAuthorizationLevel = 0 #7
					BackupSafe                 = $false #4
					ManageSafe                 = $false #2
					ManageSafeMembers          = $false #3
					ViewSafeMembers            = $false #6
					ViewAuditLog               = $false #5
					UnlockAccounts             = $false #1
				}

			}

			It 'does not throw' {

				{ ConvertTo-SortedPermission -Gen1 } | Should -Not -Throw

			}

			It 'produces no output if given no input' {

				ConvertTo-SortedPermission -Gen1 | Should -BeNullOrEmpty

			}

			It 'produces no output if no permission values provided as input' {

				$InputObj | ConvertTo-SortedPermission -Gen1 | Should -BeNullOrEmpty

			}

			It 'outputs values in expected order' {

				$Result = $Permissions | ConvertTo-SortedPermission -Gen1
				$Result[0].Name | Should -Be 'UnlockAccounts'
				$Result[1].Name | Should -Be 'ManageSafe'
				$Result[2].Name | Should -Be 'ManageSafeMembers'
				$Result[3].Name | Should -Be 'BackupSafe'
				$Result[4].Name | Should -Be 'ViewAuditLog'
				$Result[5].Name | Should -Be 'ViewSafeMembers'
				$Result[6].Name | Should -Be 'RequestsAuthorizationLevel'

			}

		}

		Context 'Gen2 General' {

			BeforeEach {

				$InputObj = @{
					Property1 = 'Value'
					Property2 = 'Another Value'
				}

				$Permissions = @{
					requestsAuthorizationLevel1 = 0 #7
					BackupSafe                  = $false #4
					ManageSafe                  = $false #2
					ManageSafeMembers           = $false #3
					ViewSafeMembers             = $false #6
					ViewAuditLog                = $false #5
					UnlockAccounts              = $false #1
				}

			}

			It 'does not throw' {

				{ ConvertTo-SortedPermission -Gen2 } | Should -Not -Throw

			}

			It 'produces no output if given no input' {

				ConvertTo-SortedPermission -Gen2 | Should -BeNullOrEmpty

			}

			It 'produces no output if no permission values provided as input' {

				$InputObj | ConvertTo-SortedPermission -Gen2 | Should -BeNullOrEmpty

			}

			It 'outputs values in expected order' {

				$Result = $Permissions | ConvertTo-SortedPermission -Gen2
				$Result.Keys | Should -BeExactly @(
					'unlockAccounts',
					'manageSafe',
					'manageSafeMembers',
					'backupSafe',
					'viewAuditLog',
					'viewSafeMembers',
					'requestsAuthorizationLevel1'
				)

			}

		}

	}

}