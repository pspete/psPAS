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

		Context 'Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'LiveSessions' = [PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' } }
				}

				$InputObj = [pscustomobject]@{

					'Limit' = 9

				}

				$Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}

			It 'sends request' {
				$InputObj | Get-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {
				$InputObj | Get-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/LiveSessions?Limit=9"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected FromTime value' {
				Get-PASPSMSession -FromTime (Get-Date -Year 1979 -Month 11 -Day 12 -Hour 0 -Minute 0 -Second 0 -Millisecond 0)
				#311212800 1674345600 311212800 311212800
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -like "$($Script:psPASSession.BaseURI)/API/LiveSessions?*FromTime=311212800*"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected ToTime value' {
				Get-PASPSMSession -ToTime (Get-Date -Year 2023 -Day 22 -Month 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0)
				#311212800 1674345600
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -like "$($Script:psPASSession.BaseURI)/API/LiveSessions?*ToTime=1674345600*"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected Limit value' {
				Get-PASPSMSession -ToTime (Get-Date -Year 2023 -Day 22 -Month 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0)

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -like "$($Script:psPASSession.BaseURI)/API/LiveSessions?*Limit=25*"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses specified Limit value' {
				Get-PASPSMSession -ToTime (Get-Date -Year 2023 -Day 22 -Month 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0) -Limit 50

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -like "$($Script:psPASSession.BaseURI)/API/LiveSessions?*Limit=50*"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {
				$InputObj | Get-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {
				$InputObj | Get-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint when querying by ID' {

				Get-PASPSMSession -liveSessionId SomeID

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/LiveSessions/SomeID"

				} -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ $InputObj | Get-PASPSMSession } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if version requirement not met when querying by ID' {
				$psPASSession.ExternalVersion = '10.5'
				{ Get-PASPSMSession -liveSessionId SomeID } | Should -Throw

				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output' {
			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'LiveSessions' = [PSCustomObject]@{'Prop1' = 'VAL1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
						'Total'        = 1
					}
				}

				$InputObj = [pscustomobject]@{

					'Limit' = 9

				}

				$Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}
			It 'provides output' {

				$InputObj | Get-PASPSMSession | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($InputObj | Get-PASPSMSession | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

			It 'outputs object with expected typename' {

				$InputObj | Get-PASPSMSession | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.PSM.Session

			}

			It 'processes NextLink expected number of times' {
				Mock Invoke-PASRestMethod -MockWith {
					If ($script:iteration -le 4) {
						[PSCustomObject]@{
							'LiveSessions'    = @(1..25)
							$script:iteration = $script:iteration++
							'Total'           = 124
						}
					} else {
						[PSCustomObject]@{
							'LiveSessions' = @(1..24)
							'Total'        = 124
						}
					}
				}
				$script:iteration = 1

				Get-PASPSMSession
				Assert-MockCalled Invoke-PASRestMethod -Times 5 -Exactly -Scope It

			}

		}

	}

}