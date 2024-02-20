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
			ExternalVersion    = [System.Version]'11.4'
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

			$Parameters = @{Parameter = 'TargetPlatform' },
			@{Parameter = 'DependentPlatform' },
			@{Parameter = 'GroupPlatform' },
			@{Parameter = 'RotationalGroup' },
			@{Parameter = 'ID' },
			@{Parameter = 'name' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Copy-PASPlatform).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Input' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
				}

				$InputObj = [pscustomobject]@{
					'name' = 'SomeName'
					'ID'   = 1234
				}

				$response = $InputObj | Copy-PASPlatform -TargetPlatform

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - TargetPlatform' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/targets/1234/duplicate"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - DependentPlatform' {
				$response = $InputObj | Copy-PASPlatform -DependentPlatform
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/dependents/1234/duplicate"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - RotationalGroup' {

				$response = $InputObj | Copy-PASPlatform -RotationalGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/rotationalGroups/1234/duplicate"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - GroupPlatform' {

				$response = $InputObj | Copy-PASPlatform -GroupPlatform
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Platforms/groups/1234/duplicate"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 1

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '11.0'
				{ $InputObj | Copy-PASPlatform -GroupPlatform } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output' {

			BeforeEach {

				$psPASSession.ExternalVersion = '11.4'
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
				}

				$InputObj = [pscustomobject]@{
					'name' = 'SomeName'
					'ID'   = 1234
				}

				$response = $InputObj | Copy-PASPlatform -TargetPlatform

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

		}

	}

}