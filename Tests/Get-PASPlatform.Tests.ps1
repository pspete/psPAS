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

		Context 'Input - Legacy' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 123 }

				}

				Mock Add-ObjectDetail -MockWith {}

				$InputObj = [pscustomobject]@{
					'Name' = 'SomeName'

				}

				$response = $InputObj | Get-PASPlatform -Verbose

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/SomeName/"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ $InputObj | Get-PASPlatform } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Input - 11.4' {
			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[PSCustomObject]@{
						'Platforms' = [PSCustomObject]@{
							'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 123
						}
					}

				}

				Mock Add-ObjectDetail -MockWith {}

				Get-PASPlatform

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 2 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 2 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - target' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/targets"

				} -Scope It -Times 1 -Exactly

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms?PlatformType=Regular"

				} -Scope It -Times 1 -Exactly

			}

			It 'sends request to expected endpoint - dependent' {

				Get-PASPlatform -DependentPlatform

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/dependents"

				} -Scope It

			}

			It 'sends request to expected endpoint - group' {

				Get-PASPlatform -GroupPlatform

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/groups"

				} -Scope It -Times 1 -Exactly

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms?PlatformType=Group"

				} -Scope It -Times 1 -Exactly

			}

			It 'sends request to expected endpoint - rotational group' {

				Get-PASPlatform -RotationalGroup

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/rotationalGroups"

				} -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 2 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '11.3'
				{ Get-PASPlatform } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

	}

}