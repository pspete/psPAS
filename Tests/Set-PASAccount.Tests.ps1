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

			$Parameters = @{Parameter = 'AccountID' },
			@{Parameter = 'Folder' },
			@{Parameter = 'AccountName' },
			@{Parameter = 'op' },
			@{Parameter = 'path' },
			@{Parameter = 'operations' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Set-PASAccount).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'v10 API' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'UpdateAccountResult' = [pscustomobject]@{
							'Prop1' = 'Value1'
							'Prop2' = 'Value2'
							'Prop3' = 'Value3'
							'Prop4' = 'Value4'
						}
					}
				}

				$InputObjV10 = [pscustomobject]@{
					'PVWAAppName' = 'P_App'
					'AccountID'   = '12_3'
				}

				[array]$MultiOps = (
					@{'op' = 'add'; 'path' = '/addthis'; 'value' = 'AddValue' },
					@{'op' = 'replace'; 'path' = '/replace/this/path'; 'value' = 'ReplaceValue' },
					@{'op' = 'remove'; 'path' = '/removethispath' }
				)

			}

			It 'sends request - V10SingleOp ParameterSet' {

				$InputObjV10 | Set-PASAccount -op Add -path '/somepath' -value SomeValue
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request - V10SingleOp ParameterSet' {

				$InputObjV10 | Set-PASAccount -op Add -path '/somepath' -value SomeValue
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request - V10MultiOp ParameterSet' {

				$InputObjV10 | Set-PASAccount -operations $MultiOps
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - V10SingleOp ParameterSet' {
				$InputObjV10 | Set-PASAccount -op Remove -path '/somepath' -value SomeValue
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/12_3"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - V10MultiOp ParameterSet' {
				$InputObjV10 | Set-PASAccount -operations $MultiOps
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/12_3"

				} -Times 1 -Exactly -Scope It

			}

			It 'provides output - V10 ParameterSet' {
				$response = $InputObjV10 | Set-PASAccount -op Replace -path '/somepath' -value SomeValue
				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties - V10 ParameterSet' {
				$response = $InputObjV10 | Set-PASAccount -op Replace -path '/somepath' -value SomeValue
				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It 'outputs object with expected typename - V10 ParameterSet' {
				$response = $InputObjV10 | Set-PASAccount -op Replace -path '/somepath' -value SomeValue
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Account.V10

			}

		}

		Context 'Classic API' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'UpdateAccountResult' = [pscustomobject]@{
							'Prop1' = 'Value1'
							'Prop2' = 'Value2'
							'Prop3' = 'Value3'
							'Prop4' = 'Value4'
						}
					}
				}

				$InputObj = [pscustomobject]@{
					'AccountID'   = '12_3'
					'Folder'      = 'Root'
					'AccountName' = 'Name'
					'Name'        = 'SomeName'
					'PolicyID'    = 'SomePolicy'
					'Safe'        = 'SafeName'
					'Random'      = 'Rand'
					'Random1'     = 'RandomValue'

				}
				[void]$InputObj.PSObject.TypeNames.Insert(0, 'psPAS.CyberArk.Vault.Account')

			}

			It 'sends request - V9 ParameterSet' {
				$InputObj | Set-PASAccount -Properties @{'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - V9 ParameterSet' {
				$InputObj | Set-PASAccount -Properties @{'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Accounts/12_3"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method - V9 ParameterSet' {
				$InputObj | Set-PASAccount -Properties @{'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body - V9 ParameterSet' {
				$InputObj | Set-PASAccount -Properties @{'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | Select-Object -ExpandProperty Accounts) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'provides output - V9 ParameterSet' {
				$response = $InputObj | Set-PASAccount -Properties @{'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties - V9 ParameterSet' {
				$response = $InputObj | Set-PASAccount -Properties @{'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
				($response | Get-Member -MemberType NoteProperty).length | Should -Be 5

			}

			It 'outputs object with expected typename - V9 ParameterSet' {
				$response = $InputObj | Set-PASAccount -Properties @{'Prop1' = 'Val1'; 'Prop2' = 'Val2'; 'Prop3' = 'Val3' }
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Account

			}

		}

	}

}