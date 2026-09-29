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

		Context 'BaseURI' {

			It 'returns expected Uri' {
				$result = Resolve-PASLogonTarget -BaseURI 'https://SomeURL'
				$result.Uri | Should -Be 'https://SomeURL/PasswordVault'
			}

			It 'removes trailing slash and PasswordVault from BaseURI' {
				$result = Resolve-PASLogonTarget -BaseURI 'https://SomeURL/PasswordVault/'
				$result.Uri | Should -Be 'https://SomeURL/PasswordVault'
			}

			It 'uses specified PVWAAppName' {
				$result = Resolve-PASLogonTarget -BaseURI 'https://SomeURL/' -PVWAAppName 'SomeApp'
				$result.Uri | Should -Be 'https://SomeURL/SomeApp'
			}

			It 'returns null ApiURI' {
				$result = Resolve-PASLogonTarget -BaseURI 'https://SomeURL'
				$result.ApiURI | Should -BeNullOrEmpty
			}

		}

		Context 'URL' {

			BeforeEach {
				$result = Resolve-PASLogonTarget -IdentityTenantURL 'https://Some.Identity.Portal/' -PrivilegeCloudURL 'https://Some.PCloud.Portal/PasswordVault/'
			}

			It 'returns expected Uri' {
				$result.Uri | Should -Be 'https://Some.PCloud.Portal/PasswordVault'
			}

			It 'returns expected ApiURI' {
				$result.ApiURI | Should -Be 'https://Some.PCloud.Portal'
			}

			It 'returns expected IdentityTenantURL' {
				$result.IdentityTenantURL | Should -Be 'https://Some.Identity.Portal'
			}

		}

		Context 'SubDomain' {

			BeforeEach {

				Mock Find-SharedServicesURL -MockWith {
					[PSCustomObject]@{
						identity_user_portal = [PSCustomObject]@{ api = 'https://Some.Identity.Portal/' }
						pcloud               = [PSCustomObject]@{ api = 'https://Some.PCloud.Portal/' }
					}
				}

				$result = Resolve-PASLogonTarget -TenantSubdomain 'SomeTenant'

			}

			It 'discovers URLs for subdomain' {
				Assert-MockCalled Find-SharedServicesURL -ParameterFilter { $subdomain -eq 'SomeTenant' } -Times 1 -Exactly -Scope It
			}

			It 'returns expected Uri' {
				$result.Uri | Should -Be 'https://Some.PCloud.Portal/PasswordVault'
			}

			It 'returns expected ApiURI' {
				$result.ApiURI | Should -Be 'https://Some.PCloud.Portal'
			}

			It 'returns expected IdentityTenantURL' {
				$result.IdentityTenantURL | Should -Be 'https://Some.Identity.Portal'
			}

		}

	}

}
