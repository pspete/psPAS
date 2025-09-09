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
					'Components' = [PSCustomObject]@{'ComponentID' = 'SomValue'; 'ComponentName' = 'OtherValue'; 'Role' = 'SomValue'; 'IP' = 'OtherValue'; 'IsLoggedOn' = 'OtherValue' }
					'Vaults'     = [PSCustomObject]@{'Role' = 'SomValue'; 'IP' = 'OtherValue'; 'IsLoggedOn' = 'OtherValue' }
				}
			}

			$response = Get-PASComponentSummary
		}
		Context 'Input' {

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/ComponentsMonitoringSummary"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ Get-PASComponentSummary } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output' {

			It 'outputs components data' {

				$response | Where-Object { $_.ComponentID -eq 'SomValue' } | Should -Not -BeNullOrEmpty

			}

			Context 'Vault Output' {

				BeforeEach {
					# Set version to 14.6+ to enable replication status fields
					$psPASSession.ExternalVersion = [System.Version]'14.6.0'
					
					Mock Invoke-PASRestMethod -MockWith {
						[PSCustomObject]@{
							'Components' = [PSCustomObject]@{'ComponentID' = 'SomValue'; 'ComponentName' = 'OtherValue'; 'Role' = 'SomValue'; 'IP' = 'OtherValue'; 'IsLoggedOn' = 'OtherValue' }
							'Vaults'     = @(
								[PSCustomObject]@{
									'Role'              = 'Primary'; 
									'IP'                = '192.168.1.1'; 
									'IsLoggedOn'        = $true;
									'ReplicationStatus' = $null
								},
								[PSCustomObject]@{
									'Role'              = 'DR'; 
									'IP'                = '192.168.1.2'; 
									'IsLoggedOn'        = $true;
									'ReplicationStatus' = [PSCustomObject]@{
										'DBReplicationDiffSecs'    = 30;
										'IsDBReplicationHealthy'   = $true;
										'FileReplicationDiffSecs'  = 45;
										'IsFileReplicationHealthy' = $true
									}
								}
							)
						}
					}

					$response = Get-PASComponentSummary
				}
				
				AfterEach {
					# Reset version back to 0.0
					$psPASSession.ExternalVersion = [System.Version]'0.0'
				}

				It 'outputs primary vaults without replication fields' {
					
					$primaryVault = $response | Where-Object { $_.Role -eq 'Primary' }
					$primaryVault | Should -Not -BeNullOrEmpty
					$primaryVault.ComponentID | Should -Be 'EPV'
					$primaryVault.ComponentName | Should -Be 'EPV'
					$primaryVault.IP | Should -Be '192.168.1.1'
					$primaryVault | Get-Member -Name 'DBReplicationDiffSecs' | Should -BeNullOrEmpty

				}

				It 'outputs DR vaults with replication fields' {
					
					$drVault = $response | Where-Object { $_.Role -eq 'DR' }
					$drVault | Should -Not -BeNullOrEmpty
					$drVault.ComponentID | Should -Be 'EPV'
					$drVault.ComponentName | Should -Be 'EPV'
					$drVault.IP | Should -Be '192.168.1.2'
					$drVault.DBReplicationDiffSecs | Should -Be 30
					$drVault.IsDBReplicationHealthy | Should -Be $true
					$drVault.FileReplicationDiffSecs | Should -Be 45
					$drVault.IsFileReplicationHealthy | Should -Be $true

				}

			}

		}

	}

}