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

		Context 'Request Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					Write-Output @{ }
				}

			}

			It 'sends request - v10ByID parameterset' {

				Get-PASAccount -id 'SomeID'

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request - v10ByQuery parameterset' {

				Get-PASAccount -search SearchTerm -searchType contains

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request - legacy parameterset' {

				Get-PASAccount -Keywords SomeValue -Safe SomeSafe

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - v10ByQuery parameterset' {

				Get-PASAccount -search SearchTerm

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts?search=SearchTerm"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends expected filter - v10ByFilter parameterset' {

				Get-PASAccount -safeName SomeSafe

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts?filter=safeName%20eq%20SomeSafe"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends expected unix time - v10ByFilter parameterset' {

				Get-PASAccount -modificationTime $(Get-Date -Month 01 -Day 01 -Year 2020 -Hour 0 -Minute 0 -Second 0 -Millisecond 0)

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts?filter=modificationTime%20gte%201577836800"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends expected filters - v10ByFilter parameterset' {

				Get-PASAccount -modificationTime $(Get-Date -Month 01 -Day 01 -Year 2020 -Hour 0 -Minute 0 -Second 0 -Millisecond 0) -safeName SomeSafe

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts?filter=modificationTime%20gte%201577836800%20AND%20safeName%20eq%20SomeSafe") -or
					($URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts?filter=safeName%20eq%20SomeSafe%20AND%20modificationTime%20gte%201577836800")

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - v10ByID parameterset' {

				Get-PASAccount -id 'SomeID'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					$URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/SomeID"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - legacy parameterset' {

				Get-PASAccount -Keywords SomeValue -Safe SomeSafe

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					(($URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Accounts?Keywords=SomeValue&Safe=SomeSafe") -or
						($URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Accounts?Safe=SomeSafe&Keywords=SomeValue"))

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request using expected method' {

				Get-PASAccount -Keywords SomeValue -Safe SomeSafe

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Get-PASAccount -Keywords SomeValue -Safe SomeSafe

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {

				$psPASSession.ExternalVersion = '1.0'
				{ Get-PASAccount -id 'SomeID' } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'

			}

		}

		Context 'Response Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					$result = [pscustomobject]@{
						'Count'    = 30
						'Accounts' = [pscustomobject]@{
							'AccountID'          = '66_6'
							'Properties'         = @(
								[pscustomobject]@{
									'Key'   = 'Safe'
									'Value' = 'zzTestSafe1'
								},
								[pscustomobject]@{
									'Key'   = 'Folder'
									'Value' = 'Root'
								},
								[pscustomobject]@{
									'Key'   = 'Name'
									'Value' = 'Operating System-_Test_WinDomain-VIRTUALREAL.IT-user01'
								},
								[pscustomobject]@{
									'Key'   = 'UserName'
									'Value' = 'user01'
								},
								[pscustomobject]@{
									'Key'   = 'PolicyID'
									'Value' = '_Test_WinDomain'
								},
								[pscustomobject]@{
									'Key'   = 'LogonDomain'
									'Value' = 'VIRTUALREAL'
								},
								[pscustomobject]@{
									'Key'   = 'LastSuccessVerification'
									'Value' = '1511973510'
								},
								[pscustomobject]@{
									'Key'   = 'Address'
									'Value' = 'VIRTUALREAL.IT'
								},
								[pscustomobject]@{
									'Key'   = 'DeviceType'
									'Value' = 'Operating System'
								}
							)
							'InternalProperties' = @(
								[pscustomobject]@{
									'Key'   = 'CPMStatus'
									'Value' = 'success'
								},
								[pscustomobject]@{
									'Key'   = 'SequenceID'
									'Value' = '1'
								},
								[pscustomobject]@{
									'Key'   = 'CreationMethod'
									'Value' = 'PVWA'
								},
								[pscustomobject]@{
									'Key'   = 'RetriesCount'
									'Value' = '-1'
								},
								[pscustomobject]@{
									'Key'   = 'LastSuccessChange'
									'Value' = '1516127648'
								},
								[pscustomobject]@{
									'Key'   = 'LastTask'
									'Value' = 'ChangeTask'
								}
							)
						}
					}
					return $result

				}


			}

			It 'provides output - legacy parameterset' {
				$response = Get-PASAccount -Keywords SomeValue -Safe SomeSafe -WarningAction SilentlyContinue
				$response | Should -Not -Be Null

			}

			It 'provides output - V10ByID parameterset' {
				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'Count' = 30
						'Value' = [pscustomobject]@{'Prop1' = 'Val1' }
					}
				}
				$response = Get-PASAccount -id 'SomeID'
				$response | Should -Not -Be null

			}

			It 'provides output - V10ByQuery parameterset' {
				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'Count' = 30
						'Value' = @([pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' })
					}
				}
				$response = Get-PASAccount -search SomeSearchTerm
				$response | Should -Not -Be null

			}

			It 'processes NextLink' {
				Mock Invoke-PASRestMethod -MockWith {
					if ($script:iteration -lt 10) {
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
				Get-PASAccount
				Assert-MockCalled Invoke-PASRestMethod -Times 10 -Exactly -Scope It

			}

			It 'has output with expected number of properties - legacy parameterset' {
				$response = Get-PASAccount -Keywords SomeValue -Safe SomeSafe -WarningAction SilentlyContinue
				($response | Get-Member -MemberType NoteProperty).length | Should -Be 11

			}

			It 'outputs object with expected typename - legacy parameterset' {
				$response = Get-PASAccount -Keywords SomeValue -Safe SomeSafe -WarningAction SilentlyContinue
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Account

			}

			It 'outputs object with expected typename - v10 parameterset' {
				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'Count' = 30
						'Value' = @([pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' }, [pscustomobject]@{'Prop1' = 'Val1' })
					}
				}
				$response = Get-PASAccount -search SomeSearch
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Account.V10

			}

			It 'writes warning that more than 1 account returned from the search - legacy parameterset' {
				$response = Get-PASAccount -Keywords SomeValue -Safe SomeSafe -WarningVariable warning -WarningAction SilentlyContinue
				$warning | Should -Be '30 matching accounts found. Only the first result will be returned'

			}



		}

	}

}