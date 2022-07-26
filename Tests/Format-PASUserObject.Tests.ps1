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

				$InputObj = @{
					'UserName'   = 'SomeUser'
					'FirstName'  = 'Some'
					'LastName'   = 'User'
					'ExpiryDate' = '10/31/2018'
					'workStreet' = 'SomeStreet'
					'homePage'   = 'www.geocities.com'
					'faxNumber'  = '1979'
					'city'       = 'Tombouctou'
				}

			}

			It 'does not throw' {

				{ $InputObj | Format-PASUserObject } | Should -Not -Throw

			}

			It 'outputs expected object type' {
				$InputObj | Format-PASUserObject | Should -BeOfType Hashtable
			}

			It 'has output with expected number of keys' {
				$result = $InputObj | Format-PASUserObject
				$result.keys.count | Should -Be 6
			}

			It 'has expected value for remoteMachinesAccess' {
				$result = $InputObj | Format-PASUserObject
				$result['personalDetails'].keys | Should -Contain FirstName
				$result['personalDetails'].keys | Should -Contain LastName
				$result['personalDetails'].keys | Should -Contain city
			}

			It 'has expected value for businessAddress' {
				$result = $InputObj | Format-PASUserObject
				$result['businessAddress'].keys | Should -Contain workStreet
			}

			It 'has expected value for phones' {
				$result = $InputObj | Format-PASUserObject
				$result['phones'].keys | Should -Contain faxNumber
			}

			It 'has expected value for internet' {
				$result = $InputObj | Format-PASUserObject
				$result['internet'].keys | Should -Contain homePage
			}

			It 'has expected value for ExpiryDate' {
				$result = $InputObj | Format-PASUserObject
				$result['ExpiryDate'] | Should -Be '1540944000'
			}

			It 'does not include unexpected keys in result' {
				$result = $InputObj | Format-PASUserObject
				$result.keys | Should -Not -Contain FirstName
				$result.keys | Should -Not -Contain LastName
				$result.keys | Should -Not -Contain city
				$result.keys | Should -Not -Contain workStreet
				$result.keys | Should -Not -Contain faxNumber
				$result.keys | Should -Not -Contain homePage
			}

		}

	}

}