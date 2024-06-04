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

				$InputObj = @{
					'UserName'   = 'SomeUser'
					'FirstName'  = 'Some'
					'LastName'   = 'User'
					'ExpiryDate' = $(Get-Date -Day 31 -Month 10 -Year 2018 -Hour 0 -Minute 0 -Second 0 -Millisecond 0)
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