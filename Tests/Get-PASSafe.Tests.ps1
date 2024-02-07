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

		BeforeEach {
			Mock Invoke-PASRestMethod -MockWith {
				[PSCustomObject]@{
					'SearchSafesResult' = [PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
					'GetSafesResult'    = [PSCustomObject]@{'PropA' = 'ValA'; 'PropB' = 'ValB'; 'PropC' = 'ValC' }
					'GetSafeResult'     = [PSCustomObject]@{'Prop5' = 'Val5'; 'Prop6' = 'Val6'; 'Prop7' = 'Val7'; 'Prop8' = 'Val8' }
				}
			}
		}
		Context 'Input - Gen1-byAll ParameterSet' {

			BeforeEach {

				Get-PASSafe -FindAll -UseGen1API

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

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws if version exceeds 12.2' {

				$psPASSession.ExternalVersion = '12.3'
				{ Get-PASSafe -FindAll -UseGen1API } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'

			}

		}

		Context 'Input - Gen1-byName ParameterSet' {

			BeforeEach {

				Get-PASSafe -SafeName SomeSafe -UseGen1API

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Safes/SomeSafe"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws if version exceeds 12.2' {

				$psPASSession.ExternalVersion = '12.3'
				{ Get-PASSafe -SafeName SomeSafe -UseGen1API } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'

			}

		}

		Context 'Input - Gen1-byQuery ParameterSet' {

			BeforeEach {

				Get-PASSafe -query 'SomeSafe'

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Safes?query=SomeSafe"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws if version exceeds 12.2' {

				$psPASSession.ExternalVersion = '12.3'
				{ Get-PASSafe -query 'SomeSafe' } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'

			}

		}

		Context 'Input - Gen2 ParameterSet' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'Count' = 30
						'Value' = @([pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' })
					}

				}

				Get-PASSafe

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Safes"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends expected query' {

				Get-PASSafe -search SomeSafe

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Safes?search=SomeSafe"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version 12.0 requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ Get-PASSafe -search SomeSafe } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if version 12.1 requirement not met' {
				$psPASSession.ExternalVersion = '12.0'
				{ Get-PASSafe -search SomeSafe -extendedDetails $false } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}


		}

		Context 'Input - Gen2-byName ParameterSet' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'Prop1' = 'Val1'
					}

				}

				Get-PASSafe -SafeName SomeSafe -includeAccounts $true

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Safes/SomeSafe?includeAccounts=True"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version 12.2 requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ Get-PASSafe -search SomeSafe } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output - Gen1-byAll ParameterSet' {

			BeforeEach {

				$response = Get-PASSafe -FindAll -UseGen1API
			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe

			}



		}

		Context 'Output - Gen1-byName ParameterSet' {

			BeforeEach {

				$response = Get-PASSafe -SafeName SomeSafe -UseGen1API

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 4

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe

			}



		}

		Context 'Output - Gen1-byQuery ParameterSet' {

			BeforeEach {

				$response = Get-PASSafe -query 'SomeSafe'

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

		Context 'Output - Gen2 ParameterSet' {


			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'Count' = 30
						'Value' = @([pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' })
					}
				}
				$response = Get-PASSafe -search 'SomeSafe'

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 1

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe.Gen2

			}

			It 'outputs object with expected typename' {

				$response = Get-PASSafe -search 'SomeSafe' -extendedDetails $false
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe.Gen2.Name

			}

			It 'processes NextLink' {
				Mock Invoke-PASRestMethod -MockWith {
					if ($script:iteration -lt 9) {
						[pscustomobject]@{
							'Count'    = 30
							'nextLink' = 'SomeLink'
							'Value'    = @([pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' })
						}
						$script:iteration++
					} else {
						[pscustomobject]@{
							'Count' = 30
							'Value' = @([pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' })
						}
					}
				}
				$script:iteration = 1
				Get-PASSafe
				Assert-MockCalled Invoke-PASRestMethod -Times 10 -Exactly -Scope It

			}

		}

		Context 'Output - Gen2-byName ParameterSet' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'Prop1' = 'Val1'
					}

				}

				$response = Get-PASSafe -SafeName SomeSafe

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 1

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe.Gen2

			}



		}

	}

}