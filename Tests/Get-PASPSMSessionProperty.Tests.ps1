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

			$Parameters = @{Parameter = 'liveSessionId' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASPSMSessionProperty).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					'liveSessionId' = 'SomeID'

				}

			}

			It 'sends request' {
				$InputObj | Get-PASPSMSessionProperty
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {
				$InputObj | Get-PASPSMSessionProperty
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/LiveSessions/SomeID/properties"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {
				$InputObj | Get-PASPSMSessionProperty
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {
				$InputObj | Get-PASPSMSessionProperty
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '10.5'

				{ $InputObj | Get-PASPSMSessionProperty } | Should -Throw
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

				$InputObj = [pscustomobject]@{
					'liveSessionId' = 'SomeID'
				}

			}

			It 'provides output' {
				$response = $InputObj | Get-PASPSMSessionProperty
				$response | Should -Not -BeNullOrEmpty

			}

			It 'outputs object with expected typename' {
				$response = $InputObj | Get-PASPSMSessionProperty
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.PSM.Session.Property

			}

			It 'has output with expected number of properties' {
				$response = $InputObj | Get-PASPSMSessionProperty
				($response | Get-Member -MemberType NoteProperty).length | Should -Be 4

			}


		}

	}

}