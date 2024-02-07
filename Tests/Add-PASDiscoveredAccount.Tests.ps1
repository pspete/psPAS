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

			$Parameters = @{Parameter = 'UserName' },
			@{Parameter = 'Address' },
			@{Parameter = 'discoveryDate' },
			@{Parameter = 'AccountEnabled' },
			@{Parameter = 'fingerprint' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASDiscoveredAccount ).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Input' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					'UserName'       = 'SomeUser'
					'Address'        = 'SomeDomain'
					'discoveryDate'  = "$(Get-Date 1/1/1971)"
					'AccountEnabled' = $true

				}

			}

			It 'sends request' {
				$InputObj | Add-PASDiscoveredAccount
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {
				$InputObj | Add-PASDiscoveredAccount
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/DiscoveredAccounts"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {
				$InputObj | Add-PASDiscoveredAccount
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {
				$InputObj | Add-PASDiscoveredAccount
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					($Body) -ne $null
				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {
				$InputObj | Add-PASDiscoveredAccount
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | Get-Member -MemberType NoteProperty).length -eq 4

				} -Times 1 -Exactly -Scope It
			}

			It 'converts date to expected UNIX time' {
				$InputObj | Add-PASDiscoveredAccount
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).discoveryDate -eq 31536000

				} -Times 1 -Exactly -Scope It
			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.2'

				{ $InputObj | Add-PASDiscoveredAccount } | Should -Throw

				$psPASSession.ExternalVersion = '0.0'

			}

			It 'has a request body with expected platformTypeAccountProperties property for Windows' {
				$InputObj | Add-PASDiscoveredAccount -SID 1234
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).platformTypeAccountProperties.SID -eq '1234'

				} -Times 1 -Exactly -Scope It
			}

			It 'has a request body with expected platformTypeAccountProperties property for UNIX' {
				$InputObj | Add-PASDiscoveredAccount -uid 1234 -gid 1
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).platformTypeAccountProperties.UID -eq '1234'
					($Body | ConvertFrom-Json).platformTypeAccountProperties.GID -eq '1'

				} -Times 1 -Exactly -Scope It
			}

			It 'has a request body with expected platformTypeAccountProperties property for UNIXSSHKey' {
				$InputObj | Add-PASDiscoveredAccount -uid 1234 -gid 1 -fingerprint 'SomePrint' -path 'SomePath' -format 'SomeFormat'
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).platformTypeAccountProperties.UID -eq '1234'
					($Body | ConvertFrom-Json).platformTypeAccountProperties.GID -eq '1'
					($Body | ConvertFrom-Json).platformTypeAccountProperties.fingerprint -eq 'SomePrint'
					($Body | ConvertFrom-Json).platformTypeAccountProperties.Path -eq 'SomePath'
					($Body | ConvertFrom-Json).platformTypeAccountProperties.format -eq 'SomeFormat'

				} -Times 1 -Exactly -Scope It
			}

			It 'has a request body with expected platformTypeAccountProperties property for AWS' {
				$InputObj | Add-PASDiscoveredAccount -awsAccountID 123456777889 -awsAccessKeyID SomeAccessKey
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).platformTypeAccountProperties.awsAccountID -eq '123456777889'
					($Body | ConvertFrom-Json).platformTypeAccountProperties.awsAccessKeyID -eq 'SomeAccessKey'

				} -Times 1 -Exactly -Scope It
			}

		}

		Context 'Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					[pscustomobject]@{
						'id'     = 'Value1'
						'status' = 'Value2'
					}



				}


				$InputObj = [pscustomobject]@{
					'UserName'       = 'SomeUser'
					'Address'        = 'SomeDomain'
					'discoveryDate'  = "$(Get-Date 1/1/1971)"
					'AccountEnabled' = $true

				}

			}

			It 'provides output' {
				$response = $InputObj | Add-PASDiscoveredAccount
				$response | Should -Not -BeNullOrEmpty

			}



		}

	}

}