Describe $($PSCommandPath -Replace ".Tests.ps1") {

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
		$Script:BaseURI = "https://SomeURL/SomeApp"
		$Script:ExternalVersion = "0.0"
		$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

	}


	AfterAll {

		$Script:RequestBody = $null

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		Context "General" {

			BeforeEach {

				$InputObj = @{
					Property1 = "Value"
					Property2 = "Another Value"
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

			It "does not throw" {

				{ ConvertTo-SortedPermission } | Should -Not -Throw

			}

			It "produces no output if given no input" {

				ConvertTo-SortedPermission | Should -BeNullOrEmpty

			}

			It "produces no output if no permission values provided as input" {

				$InputObj | ConvertTo-SortedPermission | Should -BeNullOrEmpty

			}

			It "outputs values in expected order" {

				$Result = $Permissions | ConvertTo-SortedPermission
				$Result[0].Name | Should -Be "UnlockAccounts"
				$Result[1].Name | Should -Be "ManageSafe"
				$Result[2].Name | Should -Be "ManageSafeMembers"
				$Result[3].Name | Should -Be "BackupSafe"
				$Result[4].Name | Should -Be "ViewAuditLog"
				$Result[5].Name | Should -Be "ViewSafeMembers"
				$Result[6].Name | Should -Be "RequestsAuthorizationLevel"

			}

		}

	}

}