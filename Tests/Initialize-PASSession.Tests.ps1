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

		BeforeEach {

			$Credentials = New-Object System.Management.Automation.PSCredential ('SomeUser', $(ConvertTo-SecureString 'SomePassword' -AsPlainText -Force))

			$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			$psPASSession.ExternalVersion = '0.0'
			$psPASSession.User = $null
			$psPASSession.IdleTimeout = $null

			Mock Get-PASLoggedOnUser -MockWith { [PSCustomObject]@{ UserName = 'LoggedOnUser' } }
			Mock Get-PASSessionTimeout -MockWith { [PSCustomObject]@{ Timeout = 20 } }

		}

		Context 'Session values' {

			It 'sets ExternalVersion' {
				Initialize-PASSession -ExternalVersion '14.2'
				$psPASSession.ExternalVersion | Should -Be '14.2'
			}

			It 'sets User from authenticated user' {
				Initialize-PASSession -ExternalVersion '14.2' -Credential $Credentials
				$psPASSession.User | Should -Be 'LoggedOnUser'
			}

			It 'sets IdleTimeout' {
				Initialize-PASSession -ExternalVersion '14.2'
				$psPASSession.IdleTimeout | Should -Be 20
			}

			It 'sets IdleTimeout to null on error' {
				Mock Get-PASSessionTimeout -MockWith { throw 'Some Error' }
				Initialize-PASSession -ExternalVersion '14.2'
				$psPASSession.IdleTimeout | Should -BeNullOrEmpty
			}

		}

		Context 'User lookup failure' {

			BeforeEach {
				Mock Get-PASLoggedOnUser -MockWith { throw 'Some Error' }
			}

			It 'sets User from Credential' {
				Initialize-PASSession -ExternalVersion '14.2' -Credential $Credentials
				$psPASSession.User | Should -Be 'SomeUser'
			}

			It 'sets User to null without Credential' {
				Initialize-PASSession -ExternalVersion '14.2'
				$psPASSession.User | Should -BeNullOrEmpty
			}

			It 'throws if RequireUser specified' {
				{ Initialize-PASSession -ExternalVersion '14.2' -Credential $Credentials -RequireUser } |
					Should -Throw 'Some Error'
			}

		}

	}

}
