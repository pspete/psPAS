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

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf) {

		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'taskId' }

			It 'specifies parameter <Parameter> as mandatory for byID parameter set' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASDiscoveryScan).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Input - byQuery' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith { }

				$psPASSession.ExternalVersion = '0.0'
				$response = Get-PASDiscoveryScan

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/DiscoveryScans"

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
				{ Get-PASDiscoveryScan } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Input - byID' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					'taskId' = 123
				}

				$psPASSession.ExternalVersion = '0.0'
				$response = $InputObj | Get-PASDiscoveryScan

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/DiscoveryScans/123"

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
				{ $InputObj | Get-PASDiscoveryScan } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Input - Alias' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					'id' = 123
				}

				$psPASSession.ExternalVersion = '0.0'
				$response = $InputObj | Get-PASDiscoveryScan

			}

			It 'accepts pipeline input via alias id' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/DiscoveryScans/123"

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						taskId          = 1
						discoveryType   = 'ActiveDirectory'
						creationDate    = 639211957350000000
						createdBy       = 'administrator'
						discoveryName   = 'Test'
						managingScanner = 'PasswordManager'
						runningMode     = 'Recurring'
						nextScanTime    = 639211968000000000
						scanStatus      = 'Pending'
						scheduleInformation = [pscustomobject]@{
							daysOfWeek = @('Saturday')
							time       = '18:00:00'
						}
						totalMachines   = 0
						scannedMachines = 0
						scanProperties  = [pscustomobject]@{
							Domain            = 'www.yourdomain.com'
							UseSecureProtocol = 'False'
							OU                = 'All OUs'
						}
					}
				}

				$psPASSession.ExternalVersion = '0.0'
				$response = Get-PASDiscoveryScan -taskId 1

			}

			It 'returns expected object type' {

				$response | Should -BeOfType [pscustomobject]

			}

			It 'returns object with expected type name' {

				$response.PSObject.TypeNames[0] | Should -Be 'psPAS.CyberArk.Vault.DiscoveryScan'

			}

		}

		Context 'Output - byQuery Raw Array' {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					@(
						[pscustomobject]@{ taskId = 1; discoveryName = 'Test1'; discoveryType = 'ActiveDirectory'; scanStatus = 'Pending'; runningMode = 'Recurring' },
						[pscustomobject]@{ taskId = 2; discoveryName = 'Test2'; discoveryType = 'CsvFile'; scanStatus = 'Pending'; runningMode = 'Recurring' }
					)
				}

				$psPASSession.ExternalVersion = '0.0'
				$response = Get-PASDiscoveryScan

			}

			It 'returns all objects from raw array response' {

				$response.Count | Should -Be 2

			}

			It 'decorates each object with expected type name' {

				$response | ForEach-Object { $_.PSObject.TypeNames[0] | Should -Be 'psPAS.CyberArk.Vault.DiscoveryScan' }

			}

		}

	}

}
