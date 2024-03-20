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

			$Parameters = @{Parameter = 'SafeName' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASSafe).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}



		Context 'Input-Gen1' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'UpdateSafeResult' = [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' } }
				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeName'

				}
				Mock Get-PASSafe -MockWith {}
				$response = $InputObj | Set-PASSafe -NumberOfDaysRetention 1 -ManagingCPM SomeCPM -NewSafeName SomeNewName -UseGen1API

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Safes/SomeName"

				} -Times 1 -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.safe) -ne $null

				} -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody.safe | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

		}

		Context 'Input-Gen2' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
				}
				Mock Get-PASSafe -MockWith {
					[PSCustomObject]@{'UpdateSafeResult' = [PSCustomObject]@{'description' = 'Val1'; 'location' = 'Val2' } }
				}
				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeName'

				}

				$response = $InputObj | Set-PASSafe -NumberOfDaysRetention 1 -ManagingCPM SomeCPM -NewSafeName SomeNewName

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Safes/SomeName"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					$Script:RequestBody -ne $null

				} -Times 1 -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 5

			}

		}

		Context 'Output-Gen1' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'UpdateSafeResult' = [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' } }
				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeName'

				}

				$response = $InputObj | Set-PASSafe -NumberOfDaysRetention 1 -ManagingCPM SomeCPM -NewSafeName SomeNewName -UseGen1API

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe

			}



		}

		Context 'Output-Gen2' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeName'

				}
				Mock Get-PASSafe -MockWith {}
				$response = $InputObj | Set-PASSafe -NumberOfDaysRetention 1 -ManagingCPM SomeCPM -NewSafeName SomeNewName

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe.Gen2

			}



		}

	}

}