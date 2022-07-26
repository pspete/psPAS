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
		$Script:BaseURI = 'https://SomeURL/SomeApp'
		$Script:ExternalVersion = '0.0'
		$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

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

					$URI -eq "$($Script:BaseURI)/WebServices/PIMServices.svc/Accounts/11_1"

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

					$URI -eq "$($Script:BaseURI)/api/Accounts/11_1"

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
				$Script:ExternalVersion = '1.0'
				{ $InputObj | Remove-PASAccount } | Should -Throw
				$Script:ExternalVersion = '0.0'
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