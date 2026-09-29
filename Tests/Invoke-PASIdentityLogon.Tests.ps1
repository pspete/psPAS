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

			function New-IDSession { [CmdletBinding()] param($tenant_url, $Credential, $SAMLResponse) }
			function New-IDPlatformToken { [CmdletBinding()] param($tenant_url, $Credential) }

			Mock New-IDSession -MockWith { [PSCustomObject]@{ Token = 'IdentitySessionToken' } }
			Mock New-IDPlatformToken -MockWith { [PSCustomObject]@{ access_token = 'PlatformToken' } }
			Mock Get-Module -MockWith { $true }
			Mock Import-Module -MockWith { }

		}

		Context 'Identity User' {

			It 'calls New-IDSession with Credential' {
				Invoke-PASIdentityLogon -TenantURL 'https://Some.Identity.Portal' -Credential $Credentials
				Assert-MockCalled New-IDSession -ParameterFilter {
					$tenant_url -eq 'https://Some.Identity.Portal' -and $Credential -eq $Credentials
				} -Times 1 -Exactly -Scope It
				Assert-MockCalled New-IDPlatformToken -Times 0 -Exactly -Scope It
			}

			It 'returns the IdentityCommand session' {
				$result = Invoke-PASIdentityLogon -TenantURL 'https://Some.Identity.Portal' -Credential $Credentials
				$result.Token | Should -Be 'IdentitySessionToken'
			}

			It 'calls New-IDSession with SAMLResponse' {
				Invoke-PASIdentityLogon -TenantURL 'https://Some.Identity.Portal' -SAMLResponse 'SomeSAMLResponse'
				Assert-MockCalled New-IDSession -ParameterFilter {
					$tenant_url -eq 'https://Some.Identity.Portal' -and $SAMLResponse -eq 'SomeSAMLResponse'
				} -Times 1 -Exactly -Scope It
			}

		}

		Context 'Service User' {

			It 'calls New-IDPlatformToken' {
				$result = Invoke-PASIdentityLogon -TenantURL 'https://Some.Identity.Portal' -Credential $Credentials -ServiceUser
				Assert-MockCalled New-IDPlatformToken -ParameterFilter {
					$tenant_url -eq 'https://Some.Identity.Portal' -and $Credential -eq $Credentials
				} -Times 1 -Exactly -Scope It
				Assert-MockCalled New-IDSession -Times 0 -Exactly -Scope It
				$result.access_token | Should -Be 'PlatformToken'
			}

		}

		Context 'IdentityCommand module' {

			It 'does not import IdentityCommand if already loaded' {
				Invoke-PASIdentityLogon -TenantURL 'https://Some.Identity.Portal' -Credential $Credentials
				Assert-MockCalled Import-Module -Times 0 -Exactly -Scope It
			}

			It 'imports IdentityCommand if not loaded' {
				Mock Get-Module -MockWith { }
				Invoke-PASIdentityLogon -TenantURL 'https://Some.Identity.Portal' -Credential $Credentials
				Assert-MockCalled Import-Module -Times 1 -Exactly -Scope It
			}

			It 'throws if IdentityCommand cannot be imported' {
				Mock Get-Module -MockWith { }
				Mock Import-Module -MockWith { throw 'Some Error' }
				{ Invoke-PASIdentityLogon -TenantURL 'https://Some.Identity.Portal' -Credential $Credentials } |
					Should -Throw 'Failed to import IdentityCommand: Install the IdentityCommand Module and try again. Some Error'
			}

		}

	}

}
