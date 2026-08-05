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
					[PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
				}

				$InputObj = [pscustomobject]@{
					'UserName' = 'SomeUser'

				}

				$InputObjV10 = [PSCustomObject]@{
					'Search'        = 'SomeUser'
					'ComponentUser' = $true

				}

				$response = $InputObj | Get-PASUser

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				$response = $InputObj | Get-PASUser -UseGen1API

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Users/SomeUser"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - Gen2' {

				$InputObjV10 | Get-PASUser

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					(($URI -eq "$($Script:psPASSession.BaseURI)/api/Users?Search=SomeUser&ComponentUser=True") -or
						($URI -eq "$($Script:psPASSession.BaseURI)/api/Users?ComponentUser=True&Search=SomeUser"))

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint - Gen2ID' {

				Get-PASUser -id 123

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Users/123"

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

				{ $InputObjV10 | Get-PASUser } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'

			}

			It 'throws error if version 10.9 requirement not met' {
				$psPASSession.ExternalVersion = '10.9'

				{ Get-PASUser -id 123 } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'

			}

			It 'throws error if version 12.1 requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ Get-PASUser -ExtendedDetails $true } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if version 13.2 requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ Get-PASUser -UserStatus Suspended -source LDAP } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'sends request to expected endpoint - Safes' {

				$psPASSession.ExternalVersion = '12.2'
				Get-PASUser -id 123 -safes

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Users/123/safes"

				} -Times 1 -Exactly -Scope It

				$psPASSession.ExternalVersion = '0.0'

			}

			It 'throws error if version 12.2 requirement not met for Safes' {
				$psPASSession.ExternalVersion = '1.0'
				{ Get-PASUser -id 123 -safes } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
				}

				$InputObj = [pscustomobject]@{
					'UserName' = 'SomeUser'

				}

				$InputObjV10 = [PSCustomObject]@{
					'Search'        = 'SomeUser'
					'ComponentUser' = $true

				}

				$response = $InputObj | Get-PASUser

			}
			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It 'outputs object with expected typename' {

				$response = $InputObj | Get-PASUser -UseGen1API

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.User

			}

			It 'outputs object with expected typename - Gen2' {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'Total' = 1
						'Users' = [PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
					}
				}

				$response = $InputObjV10 | Get-PASUser
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.User.Extended

			}

			It 'returns the Users property when Total indicates results' {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'Total' = 1
						'Users' = [PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
					}
				}

				$response = $InputObjV10 | Get-PASUser

				$response.Detail1 | Should -Be 'Detail'

			}

			It 'returns null when Total indicates no results' {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'Total' = 0
						'Users' = @()
					}
				}

				$response = $InputObjV10 | Get-PASUser

				$response | Should -BeNullOrEmpty

			}

			It 'outputs object with expected typename - Safes' {

				Mock Invoke-PASRestMethod -MockWith { [PSCustomObject]@{'Safes' =
						[PSCustomObject]@{'SafeName' = 'SomeSafe' }
					}
				}

				$psPASSession.ExternalVersion = '12.2'
				$response = Get-PASUser -id 123 -safes
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.User.Safe
				$psPASSession.ExternalVersion = '0.0'

			}

		}

		Context 'userType ArgumentCompleter' {

			It 'provides ArgumentCompleter for userType parameter' {

				(Get-Command Get-PASUser).Parameters['userType'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Should -Not -BeNullOrEmpty

			}

			It 'returns matching user types from Get-PASUserType' {

				Mock Get-PASUserType -MockWith {
					[pscustomobject]@{UserTypeName = 'EPVUser' },
					[pscustomobject]@{UserTypeName = 'BasicUser' }
				}

				$Completer = (Get-Command Get-PASUser).Parameters['userType'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Select-Object -ExpandProperty ScriptBlock

				$Result = & $Completer -commandName 'Get-PASUser' -parameterName 'userType' -wordToComplete 'Basic' -commandAst $null -fakeBoundParameters @{}

				$Result.CompletionText | Should -Be 'BasicUser'

			}

			It 'returns nothing if Get-PASUserType throws' {

				Mock Get-PASUserType -MockWith { throw 'Some Error' }

				$Completer = (Get-Command Get-PASUser).Parameters['userType'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Select-Object -ExpandProperty ScriptBlock

				{ & $Completer -commandName 'Get-PASUser' -parameterName 'userType' -wordToComplete '' -commandAst $null -fakeBoundParameters @{} } | Should -Not -Throw

			}

		}

	}

}