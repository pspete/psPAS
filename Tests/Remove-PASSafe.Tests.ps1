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

				(Get-Command Remove-PASSafe).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should -Be $true

			}

		}



		Context 'Gen1 Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeSafe'

				}

				$response = $InputObj | Remove-PASSafe -UseGen1API

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

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'DELETE' } -Times 1 -Exactly -Scope It

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

		Context 'Gen2 Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeSafe'

				}

				$response = $InputObj | Remove-PASSafe

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/Safes/SomeSafe"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'DELETE' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version 12.1 requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ Get-PASSafe -search SomeSafe } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Gen1 Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeSafe'

				}

				$response = $InputObj | Remove-PASSafe -UseGen1API

			}

			It 'provides no output' {

				$response | Should -BeNullOrEmpty

			}

		}

		Context 'Gen2 Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

				}

				$InputObj = [pscustomobject]@{
					'SafeName' = 'SomeSafe'

				}

				$response = $InputObj | Remove-PASSafe -UseGen1API

			}

			It 'provides no output' {

				$response | Should -BeNullOrEmpty

			}

		}

	}

}