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

			$InputObj = [pscustomobject]@{
				'AccountID' = '22_2'

			}

			$response = $InputObj | Unlock-PASAccount

		}
		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'AccountID' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Unlock-PASAccount).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}



		Context 'Input' {

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - check-in' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Accounts/22_2/CheckIn"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - unlock' {

				$InputObj | Unlock-PASAccount -unlock

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Accounts/22_2/Unlock"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Bulk CheckIn' {

			BeforeAll {
				$psPASSession.ExternalVersion = '15.2'

				$Script:Calls = @()

				Mock Invoke-PASRestMethod {
					param($Uri, $Method, $Body)
					$Script:Calls += [pscustomobject]@{
						Uri    = $Uri
						Method = $Method
						Body   = $Body
					}
				}

				$null = Unlock-PASAccount -AccountID '22_2', '33_3'

			}

			It 'sends request' {

				$Script:Calls.Count | Should -Be 1

			}

			It 'sends request to expected endpoint' {

				$Script:Calls[0].Uri | Should -Be "$($Script:psPASSession.BaseURI)/API/Accounts/CheckIn/Bulk"

			}

			It 'uses expected method' {

				$Script:Calls[0].Method | Should -Be 'POST'

			}

			It 'sends request with body for bulk check-in' {

				$Script:Calls[0].Body | Should -Not -BeNullOrEmpty

			}

			It 'sends request with expected body for bulk check-in' {

				$Script:RequestBody = $Script:Calls[0].Body | ConvertFrom-Json

				$Script:RequestBody.BulkItems | Should -Not -BeNullOrEmpty
				$Script:RequestBody.BulkItems.Count | Should -Be 2
				$Script:RequestBody.BulkItems[0].AccountID | Should -Be '22_2'

			}

		}

		Context 'Bulk CheckIn Version' {

			It 'throws error if bulk version requirement not met' {
				$psPASSession.ExternalVersion = '15.1'
				{ Unlock-PASAccount -AccountID '22_2', '33_3' } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Bulk Unlock' {

			It 'throws a not supported error' {
				$psPASSession.ExternalVersion = '15.2'
				{ Unlock-PASAccount -AccountID '22_2', '33_3' -Unlock } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output' {

			It 'provides no output' {

				$response | Should -BeNullOrEmpty

			}

		}

	}

}