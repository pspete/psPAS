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

			$Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
			$psPASSession.ExternalVersion = '0.0'
			$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
				}

				Find-PASSafe

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Safes?limit=25"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected query' {

				Find-PASSafe -search SomeQuery

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Safes?limit=25&search=SomeQuery"

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
				{ Find-PASSafe } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if version exceeds 11.7' {
				$psPASSession.ExternalVersion = '11.8'
				{ Find-PASSafe } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'sends expected number of requests' {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'Total' = 100
						'Safes' = @(
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
						)
					}
				}

				Find-PASSafe

				Assert-MockCalled Invoke-PASRestMethod -Times 5 -Exactly -Scope It

			}



		}

		Context 'Response Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'Total' = 20
						'Safes' = @(
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
						)
					}
				}

				$response = Find-PASSafe

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It 'returns expected number of results' {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{
						'Total' = 100
						'Safes' = @(
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' },
							[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
						)
					}
				}

				$response = Find-PASSafe

				$response.count | Should -Be 20

			}

		}

	}

}