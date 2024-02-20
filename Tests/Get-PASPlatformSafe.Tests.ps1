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

			$Parameters = @{Parameter = 'PlatformID' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASPlatform).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Input - 11.1' {
			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{
						'count' = 2
						'value' = [array] 'value1', 'value2', 'value3'
					}
				}


				$InputObj = [pscustomobject]@{
					'PlatformID' = 'SomeName'
				}

				$response = $InputObj | Get-PASPlatformSafe

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/SomeName/Safes/"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '10.0'
				{ $InputObj | Get-PASPlatformSafe } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 123 }

				}

				$InputObj = [pscustomobject]@{
					'Name' = 'SomeName'

				}

				$response = $InputObj | Get-PASPlatform -Verbose

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties - legacy' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

			It 'has output with expected number of properties - 11.1' {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{
						'Platforms' = [PSCustomObject]@{
							'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 123
						}
					}

				}

				$response = Get-PASPlatform -Active $true

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Platform

			}

		}

	}

}