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

			$Parameters = @{Parameter = 'Accountid' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Stop-PASCPMTask).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					'id' = 'SomeID'
				}

				$psPASSession.ExternalVersion = '0.0'
				$response = $InputObj | Stop-PASCPMTask

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Accounts/SomeID/Cancel/"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ $InputObj | Stop-PASCPMTask } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Bulk Input' {

			BeforeEach {
				$psPASSession.ExternalVersion = '15.2'

				Mock Invoke-PASRestMethod {
					param($Uri, $Method, $Body)
					$Script:RequestBodyRaw = $Body
				}

				$response = Stop-PASCPMTask -Accountid '1', '2', '3'

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Accounts/Cancel/Bulk"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with body for bulk cancel' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Body -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body for bulk cancel' {

				$Script:RequestBody = $Script:RequestBodyRaw | ConvertFrom-Json

				$Script:RequestBody.BulkItems | Should -Not -BeNullOrEmpty
				$Script:RequestBody.BulkItems.Count | Should -Be 3
				$Script:RequestBody.BulkItems[0].AccountID | Should -Be '1'

			}

		}

		Context 'Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					'id' = 'SomeID'
				}

				$psPASSession.ExternalVersion = '0.0'
				$response = $InputObj | Stop-PASCPMTask

			}

			It 'provides no output' {

				$response | Should -BeNullOrEmpty

			}

		}

	}

}
