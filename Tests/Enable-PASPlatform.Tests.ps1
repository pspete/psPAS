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
				'ID' = 1234

			}
		}

		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'ID' },
			@{Parameter = 'TargetPlatform' },
			@{Parameter = 'GroupPlatform' },
			@{Parameter = 'RotationalGroup' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Enable-PASPlatform).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}



		Context 'Input' {

			It 'sends request' {
				$InputObj | Enable-PASPlatform -TargetPlatform
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - TargetPlatform' {
				$InputObj | Enable-PASPlatform -TargetPlatform
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/targets/1234/activate"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - GroupPlatform' {
				$InputObj | Enable-PASPlatform -GroupPlatform
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/groups/1234/activate"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - RotationalGroup' {
				$InputObj | Enable-PASPlatform -RotationalGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/rotationalGroups/1234/activate"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {
				$InputObj | Enable-PASPlatform -GroupPlatform
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {
				$InputObj | Enable-PASPlatform -RotationalGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'provides no output' {
				$response = $InputObj | Enable-PASPlatform -TargetPlatform
				$response | Should -BeNullOrEmpty

			}

		}

	}

}