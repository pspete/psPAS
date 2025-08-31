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

			$Parameters = @{Parameter = 'RequestID' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Approve-PASRequest).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Single Request'{
			It 'sends request' {
				$InputObj = [pscustomobject]@{
					'RequestID' = '24_68'
					'Reason'    = 'Some Reason'

				}

				Mock Invoke-PASRestMethod -MockWith {

				}
				$psPASSession.ExternalVersion = '9.10'
				Approve-PASRequest -RequestID 24_68 -Reason 'Some Reason'
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}
		}

		Context 'Input' {

			BeforeAll{
				$InputObj = [pscustomobject]@{
					'RequestID' = '24_68'
					'Reason'    = 'Some Reason'

				}

				Mock Invoke-PASRestMethod -MockWith {

				}
				$psPASSession.ExternalVersion = '9.10'

			}

			It 'sends request' {
				Approve-PASRequest -RequestID 24_68 -Reason 'Some Reason'
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Approve-PASRequest -RequestID 24_68 -Reason 'Some Reason'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/IncomingRequests/24_68/Confirm"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Approve-PASRequest -RequestID 24_68 -Reason 'Some Reason'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Approve-PASRequest -RequestID 24_68 -Reason 'Some Reason'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 1

			}

			It 'throws error if version requirement not met' {

				Approve-PASRequest -RequestID 24_68 -Reason 'Some Reason'

				$psPASSession.ExternalVersion = '1.0'
				{ $InputObj | Approve-PASRequest } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if version requirement not met for bulk requests' {

				$psPASSession.ExternalVersion = '14.5'
				{ Approve-PASRequest -RequestID '24_68', '24_69', '24_70' -Reason 'Some Reason' } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'sends requests for bulk requests to expected endpoint' {

				$psPASSession.ExternalVersion = '14.6'
				Approve-PASRequest -RequestID '24_68', '24_69', '24_70' -Reason 'Some Reason'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/IncomingRequests/Confirm/Bulk"

				} -Times 1 -Exactly -Scope It
			}

			It 'sends request with expected body for bulk confirmations' {

				Approve-PASRequest -RequestID '24_68', '24_69', '24_70', '22_45' -Reason 'Some Reason'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.BulkItems) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of confirmations' {

				($Script:RequestBody.BulkItems).count | Should -Be 4

			}

		}

		Context 'Output' -skip {

			It 'provides no output'  {

				$response | Should -BeNullOrEmpty

			}

		}

	}

}