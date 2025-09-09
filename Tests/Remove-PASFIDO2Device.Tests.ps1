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

			$Parameters = @{Parameter = 'id' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Remove-PASFIDO2Device).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique |Should -Be $true

			}

		}

		Context 'Parameter Sets' {

			It 'has expected parameter sets' {

				$ParameterSets = (Get-Command Remove-PASFIDO2Device).ParameterSets

				$ParameterSets.Name | Should -Contain 'OwnDevice'

			}

		}

		Context 'Input - Remove FIDO2 Device' {

			BeforeEach {
				$psPASSession.ExternalVersion = '0.0'
				Mock Invoke-PASRestMethod -MockWith { }
				Mock Get-EscapedString -MockWith { return 'some-device-id' }

				$InputObj = [pscustomobject]@{
					'id' = 'some-device-id'
				}

				$response = $InputObj | Remove-PASFIDO2Device

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint for user device' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/fido2/keys/some-device-id"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'DELETE' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'calls Get-EscapedString for id parameter' {

				Assert-MockCalled Get-EscapedString -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '14.5'
				{ $InputObj | Remove-PASFIDO2Device } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Input - Remove Own FIDO2 Device' {

			BeforeEach {
				$psPASSession.ExternalVersion = '0.0'
				Mock Invoke-PASRestMethod -MockWith { }
				Mock Get-EscapedString -MockWith { return 'own-device-id' }

				$InputObj = [pscustomobject]@{
					'id' = 'own-device-id'
				}

				$response = $InputObj | Remove-PASFIDO2Device -OwnDevice

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint for own device' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/fido2/selfKeys/own-device-id"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'DELETE' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'calls Get-EscapedString for id parameter' {

				Assert-MockCalled Get-EscapedString -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '14.5'
				{ $InputObj | Remove-PASFIDO2Device -OwnDevice } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output' {

			BeforeEach {
				$psPASSession.ExternalVersion = '0.0'
				Mock Invoke-PASRestMethod -MockWith { }
				Mock Get-EscapedString -MockWith { return 'some-device-id' }

			}

			It 'provides no output for user device removal' {

				$InputObj = [pscustomobject]@{
					'id' = 'some-device-id'
				}

				$response = $InputObj | Remove-PASFIDO2Device

				$response | Should -BeNullOrEmpty

			}

			It 'provides no output for own device removal' {

				$InputObj = [pscustomobject]@{
					'id' = 'own-device-id'
				}

				$response = $InputObj | Remove-PASFIDO2Device -OwnDevice

				$response | Should -BeNullOrEmpty

			}

		}

	}

}
