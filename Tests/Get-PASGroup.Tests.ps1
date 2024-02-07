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

				Mock Invoke-PASRestMethod -MockWith { }

			}

			It 'sends request' {
				Get-PASGroup
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {
				Get-PASGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/UserGroups"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {
				Get-PASGroup -id 666
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/UserGroups/666/"

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected query - groupType ParameterSet' {
				Get-PASGroup -groupType Vault -search 'Search Term'
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($URI -eq "$($Script:psPASSession.BaseURI)/API/UserGroups?search=Search%20Term&filter=groupType%20eq%20Vault") -or ($URI -eq "$($Script:psPASSession.BaseURI)/API/UserGroups?filter=groupType%20eq%20Vault&search=Search%20Term")

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {
				Get-PASGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {
				Get-PASGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.2'

				{ Get-PASGroup } | Should -Throw

				$psPASSession.ExternalVersion = '0.0'

			}

		}

		Context 'Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'value' = [pscustomobject]@{
							'Prop1' = 'Value1'
							'Prop2' = 'Value2'
							'Prop3' = 'Value3'
							'Prop4' = 'Value4'
						}
					}
				}

			}

			It 'provides output' {
				$response = Get-PASGroup
				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {
				$response = Get-PASGroup
				($response | Get-Member -MemberType NoteProperty).length | Should -Be 4

			}



		}

	}

}