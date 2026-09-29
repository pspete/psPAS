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
			$Uri = 'https://SomeURL/PasswordVault'

		}

		Context 'Common' {

			It 'returns expected request parameters' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2 -Uri $Uri -BoundParameters @{ Credential = $Credentials; SkipCertificateCheck = [switch]$true }
				$result['Method'] | Should -Be 'POST'
				$result['SessionVariable'] | Should -Be 'PASSession'
				$result['UseDefaultCredentials'] | Should -BeFalse
				$result['SkipCertificateCheck'] | Should -BeTrue
			}

			It 'includes credential for Windows authentication' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2 -Uri $Uri -BoundParameters @{ Credential = $Credentials; type = 'Windows' }
				$result['Credential'] | Should -Be $Credentials
			}

			It 'does not include credential for non-Windows authentication' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2 -Uri $Uri -BoundParameters @{ Credential = $Credentials; type = 'LDAP' }
				$result.ContainsKey('Credential') | Should -BeFalse
			}

			It 'includes CertificateThumbprint' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2 -Uri $Uri -BoundParameters @{ Credential = $Credentials; CertificateThumbprint = 'SomeThumbprint' }
				$result['CertificateThumbprint'] | Should -Be 'SomeThumbprint'
			}

		}

		Context 'Gen2' {

			It 'uses CyberArk authentication endpoint by default' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2 -Uri $Uri -BoundParameters @{ Credential = $Credentials }
				$result['Uri'] | Should -Be 'https://SomeURL/PasswordVault/api/Auth/CyberArk/Logon'
			}

			It 'uses specified authentication type endpoint' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2 -Uri $Uri -BoundParameters @{ Credential = $Credentials; type = 'LDAP' }
				$result['Uri'] | Should -Be 'https://SomeURL/PasswordVault/api/Auth/LDAP/Logon'
			}

			It 'sends body as UTF8 bytes' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2 -Uri $Uri -BoundParameters @{ Credential = $Credentials }
				, $result['Body'] | Should -BeOfType [byte[]]
			}

			It 'includes expected body values' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2 -Uri $Uri -BoundParameters @{
					Credential        = $Credentials
					type              = 'LDAP'
					BaseURI           = 'https://SomeURL'
					concurrentSession = $true
				}
				$Body = [System.Text.Encoding]::UTF8.GetString($result['Body']) | ConvertFrom-Json
				$Properties = ($Body | Get-Member -MemberType NoteProperty).Name
				$Body.username | Should -Be 'SomeUser'
				$Body.password | Should -Be 'SomePassword'
				$Body.concurrentSession | Should -BeTrue
				$Properties | Should -Not -Contain 'BaseURI'
				$Properties | Should -Not -Contain 'Credential'
				$Properties | Should -Not -Contain 'type'
			}

			It 'includes decoded newPassword' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2 -Uri $Uri -BoundParameters @{
					Credential  = $Credentials
					newPassword = $(ConvertTo-SecureString 'SomeNewPassword' -AsPlainText -Force)
				}
				$Body = [System.Text.Encoding]::UTF8.GetString($result['Body']) | ConvertFrom-Json
				$Body.newPassword | Should -Be 'SomeNewPassword'
			}

			It 'sends expected PKIPN body' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2 -Uri $Uri -BoundParameters @{ type = 'PKIPN' }
				$Body = [System.Text.Encoding]::UTF8.GetString($result['Body']) | ConvertFrom-Json
				$Body.secureMode | Should -BeTrue
				$Body.type | Should -Be 'pkipn'
				$Body.username | Should -BeNullOrEmpty
			}

			It 'sends RADIUS password value' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2Radius -Uri $Uri -BoundParameters @{ Credential = $Credentials; type = 'RADIUS'; OTP = '123456'; OTPMode = 'Append' }
				$Body = [System.Text.Encoding]::UTF8.GetString($result['Body']) | ConvertFrom-Json
				$Body.password | Should -Be 'SomePassword,123456'
			}

			It 'sends RADIUS OTP value for Password challenge' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2Radius -Uri $Uri -BoundParameters @{ Credential = $Credentials; type = 'RADIUS'; OTP = '123456'; OTPMode = 'Challenge'; RadiusChallenge = 'Password' }
				$Body = [System.Text.Encoding]::UTF8.GetString($result['Body']) | ConvertFrom-Json
				$Body.password | Should -Be '123456'
			}

		}

		Context 'Gen1' {

			It 'uses expected endpoint' {
				$result = Get-PASLogonRequest -ParameterSetName Gen1 -Uri $Uri -BoundParameters @{ Credential = $Credentials }
				$result['Uri'] | Should -Be 'https://SomeURL/PasswordVault/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logon'
			}

			It 'includes connectionNumber in body' {
				$result = Get-PASLogonRequest -ParameterSetName Gen1 -Uri $Uri -BoundParameters @{ Credential = $Credentials; connectionNumber = 9 }
				$Body = [System.Text.Encoding]::UTF8.GetString($result['Body']) | ConvertFrom-Json
				$Body.connectionNumber | Should -Be 9
			}

		}

		Context 'integrated' {

			It 'uses expected endpoint and body' {
				$result = Get-PASLogonRequest -ParameterSetName integrated -Uri $Uri -BoundParameters @{ UseDefaultCredentials = [switch]$true; concurrentSession = $true }
				$result['Uri'] | Should -Be 'https://SomeURL/PasswordVault/api/Auth/Windows/Logon'
				$result['UseDefaultCredentials'] | Should -BeTrue
				($result['Body'] | ConvertFrom-Json).concurrentSession | Should -BeTrue
			}

		}

		Context 'shared' {

			It 'uses expected endpoint' {
				$result = Get-PASLogonRequest -ParameterSetName shared -Uri $Uri -BoundParameters @{ UseSharedAuthentication = [switch]$true }
				$result['Uri'] | Should -Be 'https://SomeURL/PasswordVault/WebServices/auth/Shared/RestfulAuthenticationService.svc/Logon'
			}

		}

		Context 'SAML' {

			BeforeEach {
				Mock Get-PASSAMLResponse -MockWith { 'ThisIsTheSAMLResponse' }
			}

			It 'adds Gen1 SAML response to Authorization header' {
				$result = Get-PASLogonRequest -ParameterSetName Gen1SAML -Uri $Uri -BoundParameters @{ SAMLResponse = 'SomeSAMLResponse' }
				$result['Uri'] | Should -Be 'https://SomeURL/PasswordVault/WebServices/auth/SAML/SAMLAuthenticationService.svc/Logon'
				$result['Headers']['Authorization'] | Should -Be 'SomeSAMLResponse'
			}

			It 'sends expected Gen2 SAML request' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2SAML -Uri $Uri -BoundParameters @{ SAMLResponse = 'SomeSAMLResponse' }
				$result['Uri'] | Should -Be 'https://SomeURL/PasswordVault/api/auth/SAML/Logon'
				$result['ContentType'] | Should -Be 'application/x-www-form-urlencoded'
				$result['Body']['apiUse'] | Should -BeTrue
				$result['Body']['SAMLResponse'] | Should -Be 'SomeSAMLResponse'
				Assert-MockCalled Get-PASSAMLResponse -Times 0 -Exactly -Scope It
			}

			It 'gets IdP SAML response if not provided' {
				$result = Get-PASLogonRequest -ParameterSetName Gen2SAML -Uri $Uri -BoundParameters @{ }
				$result['Body']['SAMLResponse'] | Should -Be 'ThisIsTheSAMLResponse'
				Assert-MockCalled Get-PASSAMLResponse -ParameterFilter { $URL -eq 'https://SomeURL/PasswordVault' } -Times 1 -Exactly -Scope It
			}

		}

		Context 'OAuth' {

			It 'uses Uri' {
				$result = Get-PASLogonRequest -ParameterSetName OAuth -Uri $Uri -BoundParameters @{ }
				$result['Uri'] | Should -Be $Uri
			}

			It 'throws for Privilege Cloud' {
				{ Get-PASLogonRequest -ParameterSetName OAuth -Uri 'https://SomeTenant.privilegecloud.cyberark.cloud/PasswordVault' -BoundParameters @{ } } |
					Should -Throw 'New-PASSession (using ParameterSet: OAuth) is only applicable for Self-Hosted Implementations'
			}

		}

		Context 'ISPSS' {

			It 'returns Identity User request' {
				$result = Get-PASLogonRequest -ParameterSetName ISPSS-URL-IdentityUser -IdentityTenantURL 'https://Some.Identity.Portal' -BoundParameters @{ Credential = $Credentials }
				$result['Uri'] | Should -Be 'https://Some.Identity.Portal'
				$result['Credential'] | Should -Be $Credentials
			}

			It 'returns Service User request' {
				$result = Get-PASLogonRequest -ParameterSetName ISPSS-Subdomain-ServiceUser -IdentityTenantURL 'https://Some.Identity.Portal' -BoundParameters @{ Credential = $Credentials }
				$result['Uri'] | Should -Be 'https://Some.Identity.Portal'
				$result['Credential'] | Should -Be $Credentials
			}

			It 'returns SAML request' {
				$result = Get-PASLogonRequest -ParameterSetName ISPSS-URL-SAML -IdentityTenantURL 'https://Some.Identity.Portal' -BoundParameters @{ SAMLResponse = 'SomeSAMLResponse' }
				$result['Uri'] | Should -Be 'https://Some.Identity.Portal'
				$result['SAMLResponse'] | Should -Be 'SomeSAMLResponse'
			}

		}

	}

}
