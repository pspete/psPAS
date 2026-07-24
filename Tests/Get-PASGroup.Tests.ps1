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

			It 'sends request with expected query - limit parameter' {
				Get-PASGroup -limit 500
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/UserGroups?limit=500"

				} -Times 1 -Exactly -Scope It

			}

			It 'throws when limit is out of range' {

				{ Get-PASGroup -limit 20001 } | Should -Throw

			}

			It 'throws error if version requirement not met - limit parameter' {
				$psPASSession.ExternalVersion = '15.1'

				{ Get-PASGroup -limit 500 } | Should -Throw

				$psPASSession.ExternalVersion = '0.0'

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

				Mock Get-NextLink -MockWith { }

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'value'    = @(
							[pscustomobject]@{
								'Prop1' = 'Value1'
								'Prop2' = 'Value2'
								'Prop3' = 'Value3'
								'Prop4' = 'Value4'
							}
						)
						'count'    = 1
						'nextLink' = $null
					}
				}

			}

			It 'invokes Get-NextLink - groupType ParameterSet' {
				Get-PASGroup
				Assert-MockCalled Get-NextLink -Times 1 -Exactly -Scope It

			}

			It 'does not invoke Get-NextLink - byID ParameterSet' {
				Get-PASGroup -id 666
				Assert-MockCalled Get-NextLink -Times 0 -Exactly -Scope It

			}

		}

		Context 'Output - Single Page' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'value'    = @(
							[pscustomobject]@{
								'Prop1' = 'Value1'
								'Prop2' = 'Value2'
								'Prop3' = 'Value3'
								'Prop4' = 'Value4'
							}
						)
						'count'    = 1
						'nextLink' = $null
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

		Context 'Output - Paging' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'value'    = @(
							[pscustomobject]@{'id' = 1 }
						)
						'count'    = 2
						'nextLink' = 'API/UserGroups?offset=1'
					}
				} -ParameterFilter { $URI -eq "$($Script:psPASSession.BaseURI)/API/UserGroups" }

				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						'value'    = @(
							[pscustomobject]@{'id' = 2 }
						)
						'count'    = 2
						'nextLink' = $null
					}
				} -ParameterFilter { $URI -eq "$($Script:psPASSession.BaseURI)/API/UserGroups?offset=1" }

			}

			It 'follows nextLink and returns all pages of results' {
				$response = Get-PASGroup
				$response.Count | Should -Be 2
				$response[0].id | Should -Be 1
				$response[1].id | Should -Be 2

			}

			It 'sends requests to expected endpoints' {
				Get-PASGroup
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/UserGroups"

				} -Times 1 -Exactly -Scope It

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/UserGroups?offset=1"

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}