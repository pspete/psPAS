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

		Context 'General' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { 'Data' }
				Mock Get-NextLink -MockWith {  }


			}

			It 'does not throw' {

				{ Get-PASDiscoveredAccount } | Should -Not -Throw

			}

			It 'sends request' {
				Get-PASDiscoveredAccount
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It
			}

			It 'sends request to expected endpoint' {
				Get-PASDiscoveredAccount
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/api/DiscoveredAccounts"

				} -Times 1 -Exactly -Scope It
			}

			It 'sends request to expected endpoint - byID' {
				Get-PASDiscoveredAccount -id 456
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/api/DiscoveredAccounts/456"

				} -Times 1 -Exactly -Scope It
			}

			It 'sends expected filter' {
				Get-PASDiscoveredAccount -privileged $true -AccountEnabled $true
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					($URI -eq "$($Script:BaseURI)/api/DiscoveredAccounts?filter=privileged%20eq%20True%20AND%20AccountEnabled%20eq%20True" -or
					$URI -eq "$($Script:BaseURI)/api/DiscoveredAccounts?filter=AccountEnabled%20eq%20True%20AND%20privileged%20eq%20True")

				} -Times 1 -Exactly -Scope It
			}

			It 'sends expected query' {
				Get-PASDiscoveredAccount -search something -searchType startswith
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					($URI -eq "$($Script:BaseURI)/api/DiscoveredAccounts?search=something&searchType=startswith" -or
					$URI -eq "$($Script:BaseURI)/api/DiscoveredAccounts?searchType=startswith&search=something")

				} -Times 1 -Exactly -Scope It
			}

			It 'sends expected query & filter' {
				Get-PASDiscoveredAccount -search something -privileged $true
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					($URI -eq "$($Script:BaseURI)/api/DiscoveredAccounts?search=something&filter=privileged%20eq%20True" -or
					$URI -eq "$($Script:BaseURI)/api/DiscoveredAccounts?filter=privileged%20eq%20True&search=something")

				} -Times 1 -Exactly -Scope It
			}

			It 'uses expected method' {
				Get-PASDiscoveredAccount
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It
			}

			It 'invokes Get-NextLink' {
				Get-PASDiscoveredAccount
				Assert-MockCalled Get-NextLink -Times 1 -Exactly -Scope It
			}

			It 'throws error if version requirement not met' {
				$Script:ExternalVersion = '11.5'

				{ Get-PASDiscoveredAccount } | Should -Throw
				$Script:ExternalVersion = '0.0'
			}

		}

	}

}