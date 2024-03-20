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

		Context 'Standard Operation' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
				}

				$InputObj = [pscustomobject]@{
					'DirectoryName' = 'SomeDirectory'
					'MappingID'     = 'SomeMappingID'
					'MappingName'   = 'SomeName'
					'LDAPBranch'    = 'SomeBranch'

				}

			}

			It 'sends request' {
				$InputObj | Set-PASDirectoryMapping -MappingAuthorizations AddUpdateUsers ActivateUsers
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It

			}

			It 'sends request to expected endpoint' {
				$InputObj | Set-PASDirectoryMapping -MappingAuthorizations AddUpdateUsers, ActivateUsers
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Configuration/LDAP/Directories/SomeDirectory/Mappings/SomeMappingID/"

				} -Times 1 -Scope It

			}

			It 'uses expected method' {
				$InputObj | Set-PASDirectoryMapping -MappingAuthorizations AddUpdateUsers, ActivateUsers
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ $InputObj | Set-PASDirectoryMapping } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '10.9'
				{ $InputObj | Set-PASDirectoryMapping -UserActivityLogPeriod 10 } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '13.9'
				{ $InputObj | Set-PASDirectoryMapping -UsedQuota 10 } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

	}

}