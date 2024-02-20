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

			It 'specifies parameter NumberOfVersionsRetention as mandatory for ParameterSet NumberOfVersionsRetention' {

				(Get-Command Add-PASSafe).Parameters['NumberOfVersionsRetention'].ParameterSets['NumberOfVersionsRetention'].IsMandatory | Should -Be $true

			}

			It 'specifies parameter NumberOfDaysRetention as mandatory for ParameterSet NumberOfDaysRetention' {

				(Get-Command Add-PASSafe).Parameters['NumberOfDaysRetention'].ParameterSets['NumberOfDaysRetention'].IsMandatory | Should -Be $true

			}

			It 'specifies parameter NumberOfVersionsRetention as mandatory for ParameterSet Gen1-NumberOfVersionsRetention' {

				(Get-Command Add-PASSafe).Parameters['NumberOfVersionsRetention'].ParameterSets['Gen1-NumberOfVersionsRetention'].IsMandatory | Should -Be $true

			}

			It 'specifies parameter NumberOfDaysRetention as mandatory for ParameterSet Gen1-NumberOfDaysRetention' {

				(Get-Command Add-PASSafe).Parameters['NumberOfDaysRetention'].ParameterSets['Gen1-NumberOfDaysRetention'].IsMandatory | Should -Be $true

			}

		}

		Context 'Gen1 Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'addsaferesult' = [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' } }
				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeName'

				}

				$response = $InputObj | Add-PASSafe -NumberOfDaysRetention 1 -UseGen1API

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Safes"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.safe) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody.safe | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

		}

		Context 'Gen2 Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'addsaferesult' = [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' } }
				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeName'

				}

				$response = $InputObj | Add-PASSafe -NumberOfDaysRetention 1

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Safes"

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

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}
			It 'throws error if version 12.0 requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ Add-PASSafe -SafeName SomeSafe -NumberOfVersionsRetention 1 } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Gen1 Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'addsaferesult' = [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' } }
				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeName'

				}

				$response = $InputObj | Add-PASSafe -NumberOfDaysRetention 1 -UseGen1API

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

		Context 'Gen2 Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeName'

				}

				$response = $InputObj | Add-PASSafe -NumberOfDaysRetention 1

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