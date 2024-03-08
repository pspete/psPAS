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

			It 'specifies parameter UserName as mandatory for ParameterSet Gen1' {

				(Get-Command Set-PASUser).Parameters['UserName'].ParameterSets['Gen1'].IsMandatory | Should -Be $true

			}

			It 'specifies parameter UserName as mandatory for ParameterSet Gen2' {

				(Get-Command Set-PASUser).Parameters['UserName'].ParameterSets['Gen2'].IsMandatory | Should -Be $true

			}

		}

		Context 'Input - Gen1' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
				}

				$InputObj = [pscustomobject]@{
					'UserName'    = 'SomeUser'
					'NewPassword' = $('P_Password' | ConvertTo-SecureString -AsPlainText -Force)
					'FirstName'   = 'Some'
					'LastName'    = 'User'
					'ExpiryDate'  = '10/31/2018'

				}

				$response = $InputObj | Set-PASUser -NewPassword $('P_Password' | ConvertTo-SecureString -AsPlainText -Force) -ExpiryDate '10/31/2018' -UseClassicAPI

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Users/SomeUser"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Input - Gen2' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
				}

				$InputObj = [pscustomobject]@{
					'id'            = 1234
					'UserName'      = 'SomeUser'
					'NewPassword'   = $('P_Password' | ConvertTo-SecureString -AsPlainText -Force)
					'ExpiryDate'    = '10/31/2018'
					'workStreet'    = 'SomeStreet'
					#'homePage'                     = 'www.geocities.com'
					'faxNumber'     = '1979'
					#'userActivityLogRetentionDays' = 30
					'loginFromHour' = 8
					'loginToHour'   = 18

				}

				Mock Get-PASUser -MockWith {
					[pscustomobject]@{
						'id'                           = 1234
						'UserName'                     = 'SomeUser'
						'FirstName'                    = 'Some'
						'LastName'                     = 'User'
						'ExpiryDate'                   = $null
						'workStreet'                   = $null
						'homePage'                     = 'www.geocities.com'
						'faxNumber'                    = $null
						'userActivityLogRetentionDays' = 30
						'loginFromHour'                = $null
						'loginToHour'                  = $null
					}

				}

				$response = $InputObj | Set-PASUser

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Users/1234"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'gets existing user settings' {
				Assert-MockCalled Get-PASUser -ParameterFilter { $id -eq 1234 } -Times 1 -Exactly -Scope It
			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected existing personal details' {
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody).personalDetails.LastName -eq 'User'

				} -Times 1 -Exactly -Scope It

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody).personalDetails.FirstName -eq 'Some'

				} -Times 1 -Exactly -Scope It
			}

			It 'sends request with expected existing internet details' {
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody).internet.homepage -eq 'www.geocities.com'

				} -Times 1 -Exactly -Scope It
			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'

				{ $InputObj | Set-PASUser } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'

			}


		}

		Context 'Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
				}

				$InputObj = [pscustomobject]@{
					'UserName'    = 'SomeUser'
					'NewPassword' = $('P_Password' | ConvertTo-SecureString -AsPlainText -Force)
					'FirstName'   = 'Some'
					'LastName'    = 'User'
					'ExpiryDate'  = '10/31/2018'

				}

				$response = $InputObj | Set-PASUser -NewPassword $('P_Password' | ConvertTo-SecureString -AsPlainText -Force) -ExpiryDate '10/31/2018' -UseClassicAPI

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.User

			}



		}

	}

}