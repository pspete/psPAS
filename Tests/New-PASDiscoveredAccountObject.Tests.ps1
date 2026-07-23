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

		Context 'General' {

			BeforeEach {

				$InputObj = [PSCustomObject]@{
					'type'       = 'windows'
					'subType'    = 'loosely'
					'address'    = 'win-computer.cyber-ark.com'
					'username'   = 'admin'
					'externalId' = 'user_account_5924'
				}

			}

			It 'does not throw' {

				{ $InputObj | New-PASDiscoveredAccountObject } | Should -Not -Throw

			}

			It 'outputs expected object type' {
				$InputObj | New-PASDiscoveredAccountObject | Should -BeOfType Hashtable
			}

			It 'has output with expected number of keys' {
				$result = $InputObj | New-PASDiscoveredAccountObject
				$result.keys.count | Should -Be 4
			}

			It 'has expected value for type' {
				$result = $InputObj | New-PASDiscoveredAccountObject
				$result['type'] | Should -Be 'windows'
			}

			It 'has expected value for subType' {
				$result = $InputObj | New-PASDiscoveredAccountObject
				$result['subType'] | Should -Be 'loosely'
			}

			It 'has expected value for externalId' {
				$result = $InputObj | New-PASDiscoveredAccountObject
				$result['externalId'] | Should -Be 'user_account_5924'
			}

			It 'has expected value for identifiers' {
				$result = $InputObj | New-PASDiscoveredAccountObject
				$result['identifiers'].keys | Should -Contain address
				$result['identifiers'].keys | Should -Contain username
			}

			It 'has expected value for identifiers.address' {
				$result = $InputObj | New-PASDiscoveredAccountObject
				$result['identifiers']['address'] | Should -Be 'win-computer.cyber-ark.com'
			}

			It 'has expected value for identifiers.username' {
				$result = $InputObj | New-PASDiscoveredAccountObject
				$result['identifiers']['username'] | Should -Be 'admin'
			}

		}

	}

}
