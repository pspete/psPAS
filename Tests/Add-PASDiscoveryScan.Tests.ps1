Describe $($PSCommandPath -Replace '.Tests.ps1') {

	BeforeAll {
		$Here = Split-Path -Parent $PSCommandPath
		$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf
		$ModulePath = Resolve-Path "$Here\..\$ModuleName"
		$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

		if (-not (Get-Module -Name $ModuleName -All)) {
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
			$Parameters = @(
				@{ Parameter = 'scanType' },
				@{ Parameter = 'scanCredentials' },
				@{ Parameter = 'managingScanner' }
			)

			It 'specifies <Parameter> as mandatory' -TestCases $Parameters {
				param($Parameter)
				(Get-Command Add-PASDiscoveryScan).Parameters[$Parameter].Attributes.Mandatory | Should -Be $true
			}
		}

		Context 'Input - ActiveDirectory' {
			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					scanType            = 'ActiveDirectory'
					scanCredentials     = @([pscustomobject]@{ scanAccountId = '538_3' })
					discoveryName       = 'Windows discovery'
					managingScanner     = 'PasswordManager'
					scheduleInformation = @{ daysOfWeek = @('Sunday'); time = '18:00:00' }
					scanProperties      = @{ domainName = 'contoso.com'; OU = 'All OUs'; useSecureProtocol = $true }
				}

				$response = $InputObj | Add-PASDiscoveryScan -Confirm:$false
			}

			It 'sends request' {
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It
			}

			It 'does not send an additional request when WhatIf is used' {
				$InputObj | Add-PASDiscoveryScan -WhatIf
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It
			}

			It 'sends request to expected endpoint' {
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					$URI -eq "$($Script:psPASSession.BaseURI)/api/DiscoveryScans"
				} -Times 1 -Exactly -Scope It
			}

			It 'uses expected method' {
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It
			}

			It 'sends request with expected body' {
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					$Script:RequestBody = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($Script:RequestBody) -ne $null
				} -Times 1 -Exactly -Scope It
			}

			It 'has a request body with expected number of properties' {
				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 8
			}

			It 'flattens scanProperties into the request body' {
				$Script:RequestBody.domainName | Should -Be 'contoso.com'
				$Script:RequestBody.OU | Should -Be 'All OUs'
				$Script:RequestBody.useSecureProtocol | Should -Be $true
			}

			It 'sends expected scheduleInformation in the request body' {
				$Script:RequestBody.scheduleInformation.daysOfWeek | Should -Contain 'Sunday'
				$Script:RequestBody.scheduleInformation.time | Should -Be '18:00:00'
			}

			It 'throws error if version requirement is not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ $InputObj | Add-PASDiscoveryScan -Confirm:$false } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}
		}

		Context 'Input - CsvFile' {
			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					scanType        = 'CsvFile'
					scanCredentials = @([pscustomobject]@{ scanAccountId = '2' })
					discoveryName   = 'Linux discovery'
					managingScanner = 'PasswordManager'
					csvFile         = 'YWRkcmVzcw=='
					fileName        = 'linux.csv'
				}

				$response = $InputObj | Add-PASDiscoveryScan -Confirm:$false
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
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It
			}

			It 'sends request with expected body' {
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					$Script:RequestBody = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($Script:RequestBody) -ne $null
				} -Times 1 -Exactly -Scope It
			}

			It 'has a request body with expected number of properties' {
				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 6
			}

			It 'accepts pipeline input by property name' {
				$Script:RequestBody.scanType | Should -Be 'CsvFile'
				$Script:RequestBody.discoveryName | Should -Be 'Linux discovery'
				$Script:RequestBody.fileName | Should -Be 'linux.csv'
				$Script:RequestBody.csvFile | Should -Be 'YWRkcmVzcw=='
			}
		}

		Context 'Output' {
			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{ taskId = 1; discoveryName = 'Windows discovery'; discoveryType = 'ActiveDirectory'; scanStatus = 'Pending' }
				}

				$InputObj = [pscustomobject]@{
					scanType        = 'ActiveDirectory'
					scanCredentials = @([pscustomobject]@{ scanAccountId = '538_3' })
					managingScanner = 'PasswordManager'
				}

				$response = $InputObj | Add-PASDiscoveryScan -Confirm:$false
			}

			It 'provides output' {
				$response | Should -Not -BeNullOrEmpty
			}

			It 'has output with expected number of properties' {
				($response | Get-Member -MemberType NoteProperty).length | Should -Be 4
			}

			It 'outputs object with expected typename' {
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be 'psPAS.CyberArk.Vault.DiscoveryScan'
			}
		}
	}
}
