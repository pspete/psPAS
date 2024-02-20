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

				$props = @{'SomeProp' = 'SomeValue' }
				$InputObj = [PSCustomObject]@{
					'address'                          = 'someaddress'
					'SafeName'                         = 'SomeSafe'
					'PlatformID'                       = 'SomePlatform'
					'userName'                         = 'SomeUser'
					'secret'                           = $('P_Password' | ConvertTo-SecureString -AsPlainText -Force)
					'automaticManagementEnabled'       = $true
					'remoteMachines'                   = 'someMachine'
					'accessRestrictedToRemoteMachines' = $false
					'platformAccountProperties'        = $props
				}
				Mock Invoke-PASRestMethod -MockWith {  }


			}

			It 'does not throw' {

				{ $InputObj | New-PASAccountObject } | Should -Not -Throw

			}

			It 'outputs expected object type' {
				$InputObj | New-PASAccountObject | Should -BeOfType Hashtable
			}

			It 'has output with expected number of keys' {
				$result = $InputObj | New-PASAccountObject
				$result.keys.count | Should -Be 8
			}

			It 'has expected value for remoteMachinesAccess' {
				$result = $InputObj | New-PASAccountObject
				$result['remoteMachinesAccess'].keys | Should -Contain remoteMachines
				$result['remoteMachinesAccess'].keys | Should -Contain accessRestrictedToRemoteMachines
			}

			It 'has expected value for secretManagement' {
				$result = $InputObj | New-PASAccountObject
				$result['secretManagement'].keys | Should -Contain automaticManagementEnabled
			}

			It 'has expected value for platformAccountProperties' {
				$result = $InputObj | New-PASAccountObject
				$result['platformAccountProperties'].keys | Should -Contain SomeProp
			}

			It 'has expected value for secret' {
				$result = $InputObj | New-PASAccountObject
				$result['secret'] | Should -Be 'P_Password'
			}

		}

	}

}