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

			$Parameters = @{Parameter = 'Id' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Set-PASOnboardingRule ).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Input' {

			BeforeEach {
				Mock Get-PASOnboardingRule -MockWith {}
				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					'SystemTypeFilter' = 'Windows'
					'TargetSafeName'   = 'SomeSafe'
					'TargetPlatformId' = 'SomePlatform'
					'Id'               = '123'

				}

			}

			It 'sends request' {
				$InputObj | Set-PASOnboardingRule
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It

			}

			It 'sends request to expected endpoint' {
				$InputObj | Set-PASOnboardingRule
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/AutomaticOnboardingRules/123/"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {
				$InputObj | Set-PASOnboardingRule
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {
				$InputObj | Set-PASOnboardingRule
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					($Body) -ne $null
				} -Times 1 -Scope It

			}

			It 'has a request body with expected number of properties' {
				$InputObj | Set-PASOnboardingRule
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | Get-Member -MemberType NoteProperty).length -eq 3

				} -Times 1 -Exactly -Scope It
			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.2'

				{ $InputObj | Set-PASOnboardingRule } | Should -Throw

				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[pscustomobject]@{
						'Prop1' = 'Value1'
						'Prop2' = 'Value2'
						'Prop3' = 'Value3'
						'Prop4' = 'Value4'
					}

				}

				Mock Get-PASOnboardingRule -MockWith {}
				$InputObj = [pscustomobject]@{
					'SystemTypeFilter' = 'Windows'
					'TargetSafeName'   = 'SomeSafe'
					'TargetPlatformId' = 'SomePlatform'
					'Id'               = '123'

				}

			}

			It 'provides output' {
				$response = $InputObj | Set-PASOnboardingRule
				$response | Should -Not -BeNullOrEmpty

			}

			It 'outputs object with expected typename' {
				$response = $InputObj | Set-PASOnboardingRule
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.OnboardingRule

			}

		}

	}

}