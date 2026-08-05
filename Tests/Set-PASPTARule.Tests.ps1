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

			}
			Mock Get-PASPTARule -MockWith {}
			$InputObj = [pscustomobject]@{
				'id'             = 99
				'category'       = 'KEYSTROKES'
				'regex'          = '(.*)Some Pattern(.*)'
				'score'          = 80
				'description'    = 'Some String'
				'response'       = 'NONE'
				'active'         = $true
				'vaultUsersMode' = 'INCLUDE'
				'vaultUsersList' = 'User1', 'User2'
				'machinesMode'   = 'EXCLUDE'
				'machinesList'   = 'Machine1'

			}

			$response = $InputObj | Set-PASPTARule

		}
		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'id' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Set-PASPTARule).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}



		Context 'Input' {

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/pta/API/Settings/RiskyActivity/"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 8

			}

			It 'has a request body with expected scope properties' {

				$Script:RequestBody.scope.vaultUsers.mode | Should -Be 'INCLUDE'
				$Script:RequestBody.scope.machines.mode | Should -Be 'EXCLUDE'
				$Script:RequestBody.scope.vaultUsers.list | Should -HaveCount 2
				$Script:RequestBody.scope.vaultUsers.list | Should -Contain User1
				$Script:RequestBody.scope.vaultUsers.list | Should -Contain User2
				$Script:RequestBody.scope.machines.list | Should -HaveCount 1
				$Script:RequestBody.scope.machines.list | Should -Contain Machine1
			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ $InputObj | Set-PASPTARule } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output' {

			It 'provides no output' {

				$response | Should -BeNullOrEmpty

			}

		}

		Context 'Scope Merging' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {}

			}

			It 'copies existing machines scope when only vaultUsers scope is updated' {

				#Note: Format-PutRequestObject copies any *existing* scope wholesale before the
				#scope-merge logic below runs, so the "fill in the untouched half" branch only
				#fires when the existing rule never had that half configured at all.
				Mock Get-PASPTARule -MockWith {
					[pscustomobject]@{
						'ID'    = 99
						'scope' = @{
							'machines' = @{'mode' = 'EXCLUDE'; 'list' = @('ExistingMachine') }
						}
					}
				}

				[pscustomobject]@{'id' = 99; 'vaultUsersMode' = 'INCLUDE'; 'vaultUsersList' = 'NewUser' } | Set-PASPTARule

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Parsed = $Body | ConvertFrom-Json
					$Parsed.scope.machines.list -contains 'ExistingMachine'

				} -Times 1 -Exactly -Scope It

			}

			It 'copies existing vaultUsers scope when only machines scope is updated' {

				Mock Get-PASPTARule -MockWith {
					[pscustomobject]@{
						'ID'    = 99
						'scope' = @{
							'vaultUsers' = @{'mode' = 'INCLUDE'; 'list' = @('ExistingUser') }
						}
					}
				}

				[pscustomobject]@{'id' = 99; 'machinesMode' = 'INCLUDE'; 'machinesList' = 'NewMachine' } | Set-PASPTARule

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Parsed = $Body | ConvertFrom-Json
					$Parsed.scope.vaultUsers.list -contains 'ExistingUser'

				} -Times 1 -Exactly -Scope It

			}

			It 'sets scope to the (absent) existing scope when no scope parameters are specified' {

				#Existing rule has no scope property at all, and no scope parameters are supplied -
				#exercises the default branch that copies whatever existing scope there is (here: none).
				Mock Get-PASPTARule -MockWith {
					[pscustomobject]@{
						'ID' = 99
					}
				}

				[pscustomobject]@{'id' = 99; 'category' = 'KEYSTROKES' } | Set-PASPTARule

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Parsed = $Body | ConvertFrom-Json
					$null -eq $Parsed.scope

				} -Times 1 -Exactly -Scope It

			}

			It 'clears a scope item when its value is explicitly null' {

				Mock Get-PASPTARule -MockWith {
					[pscustomobject]@{
						'ID'    = 99
						'scope' = @{
							'vaultUsers' = @{'mode' = 'INCLUDE'; 'list' = @('ExistingUser') }
						}
					}
				}

				Set-PASPTARule -id 99 -vaultUsersList $null

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Parsed = $Body | ConvertFrom-Json
					$null -eq $Parsed.scope.vaultUsers

				} -Times 1 -Exactly -Scope It

			}

			It 'clears a machines scope item when its value is explicitly null' {

				Mock Get-PASPTARule -MockWith {
					[pscustomobject]@{
						'ID'    = 99
						'scope' = @{
							'machines' = @{'mode' = 'EXCLUDE'; 'list' = @('ExistingMachine') }
						}
					}
				}

				Set-PASPTARule -id 99 -machinesList $null

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Parsed = $Body | ConvertFrom-Json
					$null -eq $Parsed.scope.machines

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}