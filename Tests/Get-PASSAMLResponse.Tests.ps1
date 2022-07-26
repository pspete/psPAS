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

	}


	AfterAll {

		$Script:RequestBody = $null

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		BeforeEach {

			Mock Invoke-WebRequest -MockWith {

				[pscustomobject]@{

					'Links'       = [pscustomobject]@{

						'href' = 'https://SomeLink/'

					}

					'InputFields' = @(

						[pscustomobject]@{

							'Name'  = 'SAMLResponse'
							'Value' = 'IamSAMLiAM'

						}

					)

				}

			}

			$response = Get-PASSAMLResponse -URL 'https://pvwa.somecompany.com/PasswordVault'

		}

		Context 'Standard Operation' {

			It 'sends expected requests' {

				Assert-MockCalled Invoke-WebRequest -Times 2 -Exactly -Scope It

			}

			It 'returns expected response' {

				$response | Should -Be 'IamSAMLiAM'

			}

			It 'throws expected error' {

				Mock Invoke-WebRequest -MockWith {

					Throw 'Some Error'

				}

				{ Get-PASSAMLResponse -URL 'https://pvwa.somecompany.com/PasswordVault' } | Should -Throw 'Failed to get SAMLResponse'

			}

		}

	}

}