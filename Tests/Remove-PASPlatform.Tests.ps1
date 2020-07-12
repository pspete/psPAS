Describe $($PSCommandPath -Replace ".Tests.ps1") {

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
		$Script:BaseURI = "https://SomeURL/SomeApp"
		$Script:ExternalVersion = "0.0"
		$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

	}


	AfterAll {

		$Script:RequestBody = $null

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		BeforeEach {
			Mock Invoke-PASRestMethod -MockWith {

			}

			$InputObj = [pscustomobject]@{
				"ID" = 1234

			}
		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'ID' },
			@{Parameter = 'TargetPlatform' },
			@{Parameter = 'DependentPlatform' },
			@{Parameter = 'GroupPlatform' },
			@{Parameter = 'RotationalGroup' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Remove-PASPlatform).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}



		Context "Input" {

			It "sends request" {
				$InputObj | Remove-PASPlatform -TargetPlatform
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - TargetPlatform" {
				$InputObj | Remove-PASPlatform -TargetPlatform
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Platforms/targets/1234"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - DependentPlatform" {
				$InputObj | Remove-PASPlatform -DependentPlatform
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Platforms/dependents/1234"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - GroupPlatform" {
				$InputObj | Remove-PASPlatform -GroupPlatform
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Platforms/groups/1234"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - RotationalGroup" {
				$InputObj | Remove-PASPlatform -RotationalGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Platforms/rotationalGroups/1234"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				$InputObj | Remove-PASPlatform -GroupPlatform
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'DELETE' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {
				$InputObj | Remove-PASPlatform -RotationalGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context "Output" {

			it "provides no output" {
				$response = $InputObj | Remove-PASPlatform -TargetPlatform
				$response | Should -BeNullOrEmpty

			}

		}

	}

}