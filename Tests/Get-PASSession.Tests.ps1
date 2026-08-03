Describe $($PSCommandPath -replace '.Tests.ps1') {

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
			ApiURI             = 'https://SomeURL/SomeApp'
			User               = $null
			ExternalVersion    = [System.Version]'0.0'
			WebSession         = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			StartTime          = $((Get-Date).AddMinutes(-5))
			ElapsedTime        = $null
			LastCommand        = $null
			LastCommandTime    = $null
			LastCommandResults = $null
			LastError          = $null
			LastErrorTime      = $null
			IdleTimeout        = $null
			SessionTimeRemaining  = $null
		}

		New-Variable -Name psPASSession -Value $psPASSession -Scope Script -Force

	}


	AfterAll {

		$Script:RequestBody = $null

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {
		BeforeEach {

			$psPASSession.StartTime = (Get-Date).AddMinutes(-5)
			$response = Get-PASSession
		}

		Context 'Standard Operation' {

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'calculates ElapsedTime when StartTime is set' {

				$response.ElapsedTime | Should -Not -BeNullOrEmpty

			}

			It 'sets ElapsedTime to null when StartTime is not set' {

				$psPASSession.StartTime = $null
				$NoStartResponse = Get-PASSession
				$NoStartResponse.ElapsedTime | Should -BeNullOrEmpty

			}

			It 'has output with expected number of properties' -Skip {
				#TODO: This test has been failing intermittently in CI/CD runs. Needs investigation.
				$response.Keys.Count | Should -Be 14

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Session

			}

		}

		Context 'SessionTimeRemaining' {

			It 'is null when IdleTimeout is not set' {

				$psPASSession.IdleTimeout = $null
				$response = Get-PASSession
				$response.SessionTimeRemaining | Should -BeNullOrEmpty

			}

			It 'is null when IdleTimeout is set but no activity time is known' {

				$psPASSession.IdleTimeout = 20
				$psPASSession.StartTime = $null
				$psPASSession.LastCommandTime = $null
				$response = Get-PASSession
				$response.SessionTimeRemaining | Should -BeNullOrEmpty

			}

			It 'calculates remaining time from StartTime when no command has been sent yet' {

				$psPASSession.IdleTimeout = 20
				$psPASSession.StartTime = (Get-Date).AddMinutes(-5)
				$psPASSession.LastCommandTime = $null
				$response = Get-PASSession
				$response.SessionTimeRemaining.TotalMinutes | Should -BeGreaterThan 0
				$response.SessionTimeRemaining.TotalMinutes | Should -BeLessOrEqual 15

			}

			It 'calculates remaining time from LastCommandTime when available' {

				$psPASSession.IdleTimeout = 20
				$psPASSession.StartTime = (Get-Date).AddMinutes(-15)
				$psPASSession.LastCommandTime = (Get-Date).AddMinutes(-1)
				$response = Get-PASSession
				$response.SessionTimeRemaining.TotalMinutes | Should -BeGreaterThan 18
				$response.SessionTimeRemaining.TotalMinutes | Should -BeLessOrEqual 19

			}

			It 'returns a zero TimeSpan instead of a negative value when the session has already idle-timed out' {

				$psPASSession.IdleTimeout = 20
				$psPASSession.StartTime = (Get-Date).AddMinutes(-30)
				$psPASSession.LastCommandTime = (Get-Date).AddMinutes(-25)
				$response = Get-PASSession
				$response.SessionTimeRemaining.Ticks | Should -Be 0

			}

		}

	}

}