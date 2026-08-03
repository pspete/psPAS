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

		$psPASSession = [ordered]@{
			IdleTimeout     = $null
			StartTime       = $null
			LastCommandTime = $null
		}

		New-Variable -Name psPASSession -Value $psPASSession -Scope Script -Force

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		Context 'IdleTimeout not known' {

			It 'returns null when IdleTimeout is not set' {

				$psPASSession.IdleTimeout = $null
				Get-PASIdleTimeRemaining | Should -BeNullOrEmpty

			}

		}

		Context 'No activity reference point' {

			It 'returns null when neither StartTime nor LastCommandTime is set' {

				$psPASSession.IdleTimeout = 20
				$psPASSession.StartTime = $null
				$psPASSession.LastCommandTime = $null
				Get-PASIdleTimeRemaining | Should -BeNullOrEmpty

			}

		}

		Context 'Calculation' {

			It 'calculates remaining time from StartTime when no command has been sent yet' {

				$psPASSession.IdleTimeout = 20
				$psPASSession.StartTime = (Get-Date).AddMinutes(-5)
				$psPASSession.LastCommandTime = $null
				$Result = Get-PASIdleTimeRemaining
				$Result.TotalMinutes | Should -BeGreaterThan 0
				$Result.TotalMinutes | Should -BeLessOrEqual 15

			}

			It 'calculates remaining time from LastCommandTime when available' {

				$psPASSession.IdleTimeout = 20
				$psPASSession.StartTime = (Get-Date).AddMinutes(-15)
				$psPASSession.LastCommandTime = (Get-Date).AddMinutes(-1)
				$Result = Get-PASIdleTimeRemaining
				$Result.TotalMinutes | Should -BeGreaterThan 18
				$Result.TotalMinutes | Should -BeLessOrEqual 19

			}

			It 'returns a zero TimeSpan instead of a negative value once the session has already idle-timed out' {

				$psPASSession.IdleTimeout = 20
				$psPASSession.StartTime = (Get-Date).AddMinutes(-30)
				$psPASSession.LastCommandTime = (Get-Date).AddMinutes(-25)
				$Result = Get-PASIdleTimeRemaining
				$Result.Ticks | Should -Be 0

			}

		}

	}

}
