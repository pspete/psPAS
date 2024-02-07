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
				{ Get-PASUser -id 123 -ExtendedDetails $true } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if version 13.2 requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ Get-PASUser -UserStatus Suspended -source LDAP } | Should -Throw
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

				Mock Invoke-PASRestMethod -MockWith { [PSCustomObject]@{'Users' =
						[PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
					}
				}

				$response = $InputObjV10 | Get-PASUser
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.User.Extended

			}

		}

	}

}