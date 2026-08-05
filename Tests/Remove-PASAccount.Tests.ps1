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

			$Parameters = @{Parameter = 'AccountID' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Remove-PASAccount).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}



		Context 'Input V9 API' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					Write-Output @{ }
				}

				$InputObj = [pscustomobject]@{

					'AccountID' = '11_1'

				}

				$response = $InputObj | Remove-PASAccount -UseClassicAPI

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Accounts/11_1"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'DELETE' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Input V10 API' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					Write-Output @{ }
				}

				$InputObj = [pscustomobject]@{

					'AccountID' = '11_1'

				}

				$response = $InputObj | Remove-PASAccount

			}

			It 'sends request' {
				#$response = $InputObj | Remove-PASAccount
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {
				#$response = $InputObj | Remove-PASAccount
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/11_1"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {
				#$response = $InputObj | Remove-PASAccount
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'DELETE' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {
				#$response = $InputObj | Remove-PASAccount
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ $InputObj | Remove-PASAccount } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Input - DeleteSSHKey' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					Write-Output @{ }
				}
			}

			It 'cannot be used in conjunction with UseGen1API' {

				{ Remove-PASAccount -AccountID 11_1 -UseGen1API -DeleteSSHKey $true } | Should -Throw

			}

			It 'sends expected query - Self-Hosted' {
				Remove-PASAccount -AccountID 11_1 -DeleteSSHKey $true -Confirm:$false

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/11_1?deleteSshKeyFromVaultAndTarget=True"

				} -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met - Self-Hosted' {
				$psPASSession.ExternalVersion = '15.1'

				{ Remove-PASAccount -AccountID 11_1 -DeleteSSHKey $true -Confirm:$false } | Should -Throw

				$psPASSession.ExternalVersion = '0.0'
			}

			It 'sends expected query - Privilege Cloud' {
				$psPASSession.ApiURI = 'https://SomeSubdomain.cyberark.cloud/SomeApp'

				Remove-PASAccount -AccountID 11_1 -DeleteSSHKey $false -Confirm:$false

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/11_1?deleteOnlyPrivateSshKey=False"

				} -Times 1 -Exactly -Scope It

				$psPASSession.ApiURI = $null
			}

			It 'does not require minimum version 15.2 - Privilege Cloud' {
				$psPASSession.ApiURI = 'https://SomeSubdomain.cyberark.cloud/SomeApp'
				$psPASSession.ExternalVersion = '15.1'

				{ Remove-PASAccount -AccountID 11_1 -DeleteSSHKey $true -Confirm:$false } | Should -Not -Throw

				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.ApiURI = $null
			}

			It 'does not send DeleteSSHKey query string if parameter not specified' {
				Remove-PASAccount -AccountID 11_1 -Confirm:$false

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Accounts/11_1"

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					Write-Output @{ }
				}

				$InputObj = [pscustomobject]@{

					'AccountID' = '11_1'

				}

				$response = $InputObj | Remove-PASAccount -UseClassicAPI

			}

			It 'provides no output' {
				#$response = $InputObj | Remove-PASAccount
				$response | Should -BeNullOrEmpty

			}

		}

	}

}