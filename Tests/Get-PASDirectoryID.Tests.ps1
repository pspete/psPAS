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

		BeforeEach {

			Mock Invoke-PASRestMethod -MockWith {
				[PSCustomObject]@{
					'IdentityUM'           = $true
					'OnPremiseMemberTypes' = @('User', 'Group')
					'IdentityMemberTypes'  = @('User', 'Group', 'Role')
					'Directories'          = @(
						[PSCustomObject]@{'Name' = 'Idira Cloud Directory'; 'ID' = '09B9A9B0-6CE8-465F-AB03-65766D33B05E' },
						[PSCustomObject]@{'Name' = 'Active Directory: ad.SomeDomain.com'; 'ID' = '77dac292-a38e-76c4-9eaa-d25e196c428d' }
					)
				}
			}

			$response = Get-PASDirectoryID

		}

		Context 'Input' {

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/settings/AddSafeMember"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'returns all directories' {

				$response.Count | Should -Be 2

			}

			It 'has output with expected number of properties' {

				($response[0] | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe.Member.Directory

			}

			It 'filters returned directories by name' {

				$response = Get-PASDirectoryID -Name 'Idira Cloud Directory'

				$response.Count | Should -Be 1
				$response.ID | Should -Be '09B9A9B0-6CE8-465F-AB03-65766D33B05E'

			}

			It 'returns the directory name as the ID for a self-hosted, AD-integrated Vault' {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'IdentityUM'           = $false
						'OnPremiseMemberTypes' = @('User', 'Group')
						'IdentityMemberTypes'  = @('User', 'Group', 'Role')
						'Directories'          = @(
							[PSCustomObject]@{'Name' = 'SomeDirectory'; 'ID' = 'SomeDirectory' }
						)
					}
				}

				$response = Get-PASDirectoryID

				$response.Name | Should -Be 'SomeDirectory'
				$response.ID | Should -Be 'SomeDirectory'

			}

		}

	}

}
