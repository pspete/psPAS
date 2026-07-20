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
			Mock Invoke-PASRestMethod -MockWith { }

			Rename-PASPlatform -ID 42 -Name 'NewPlatformName'
		}

		Context 'Input' {

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/targets/42"

				} -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					If ($null -ne $Body) {
						$($Body | ConvertFrom-Json | Select-Object -ExpandProperty Name) -eq 'NewPlatformName'
					}
				} -Scope It -Times 1

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ Rename-PASPlatform -ID 42 -Name 'NewPlatformName' } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if run against Privilege Cloud' {
				$psPASSession.BaseURI = 'https://something.cyberark.cloud'
				{ Rename-PASPlatform -ID 42 -Name 'NewPlatformName' } | Should -Throw
				$psPASSession.BaseURI = 'https://SomeURL/SomeApp'
			}

		}

		Context 'Output' {

			It 'provides no output' {
				Mock Invoke-PASRestMethod -MockWith { }

				$response = Rename-PASPlatform -ID 42 -Name 'NewPlatformName'

				$response | Should -BeNullOrEmpty

			}

		}

	}

}
