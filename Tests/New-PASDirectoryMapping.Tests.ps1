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

		Context 'Standard Operation' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
				}

				$InputObj = [pscustomobject]@{
					'DirectoryName' = 'SomeDirectory'
					'MappingName'   = 'SomeMapping'
					'LDAPBranch'    = 'SomeBranch'
					'DomainGroups'  = 'SomeGroup'

				}

			}

			It 'does not throw - v10.4 parameterset' {
				$Script:ExternalVersion = '10.4'
				{ $InputObj | New-PASDirectoryMapping -MappingAuthorizations RestoreAllSafes } | Should -Not -Throw
				$Script:ExternalVersion = '0.0'
			}


			It 'does not throw - v10.7 parameterset' {
				$Script:ExternalVersion = '10.7'
				{ $InputObj | New-PASDirectoryMapping -VaultGroups Group1, Group2 } | Should -Not -Throw
				$Script:ExternalVersion = '0.0'
			}

			It 'does not throw - v10.10 parameterset' {
				$Script:ExternalVersion = '10.10'
				{ $InputObj | New-PASDirectoryMapping -UserActivityLogPeriod 10 } | Should -Not -Throw
				$Script:ExternalVersion = '0.0'
			}

			It 'sends request' {
				$InputObj | New-PASDirectoryMapping -MappingAuthorizations RestoreAllSafes
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {
				$InputObj | New-PASDirectoryMapping -MappingAuthorizations RestoreAllSafes
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/api/Configuration/LDAP/Directories/SomeDirectory/Mappings/"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {
				$InputObj | New-PASDirectoryMapping -MappingAuthorizations RestoreAllSafes
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$Script:ExternalVersion = '1.0'
				{ $InputObj | New-PASDirectoryMapping -MappingAuthorizations RestoreAllSafes, BackupAllSafes } | Should -Throw
				$Script:ExternalVersion = '0.0'
			}

			It 'throws error if version requirement not met' {
				$Script:ExternalVersion = '10.6'
				{ $InputObj | New-PASDirectoryMapping -VaultGroups 'Group1', 'Group2' } | Should -Throw
				$Script:ExternalVersion = '0.0'
			}

			It 'throws error if version requirement not met' {
				$Script:ExternalVersion = '10.9'
				{ $InputObj | New-PASDirectoryMapping -MappingAuthorizations RestoreAllSafes, BackupAllSafes -VaultGroups 'Group1', 'Group2' -UserActivityLogPeriod 10 } | Should -Throw
				$Script:ExternalVersion = '0.0'
			}

			It 'does not throw if version requirement met' {
				$Script:ExternalVersion = '10.10'
				{ $InputObj | New-PASDirectoryMapping -MappingAuthorizations RestoreAllSafes, BackupAllSafes -VaultGroups 'Group1', 'Group2' -UserActivityLogPeriod 10 } | Should -Not -Throw
				$Script:ExternalVersion = '0.0'
			}

			It 'throws error if version requirement not met' {
				$Script:ExternalVersion = '13.9'
				{ $InputObj | New-PASDirectoryMapping -MappingAuthorizations RestoreAllSafes, BackupAllSafes -VaultGroups 'Group1', 'Group2' -UserActivityLogPeriod 10 -UsedQuota 10 } | Should -Throw
				$Script:ExternalVersion = '0.0'
			}

		}

	}

}