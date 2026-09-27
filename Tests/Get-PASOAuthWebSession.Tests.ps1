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

			Mock Skip-CertificateCheck -MockWith { }
			$Token = ConvertTo-SecureString 'SomeToken' -AsPlainText -Force

		}

		AfterEach {

			$Script:SkipCertificateCheck = $false

		}

		Context 'Headers' {

			It 'returns a WebRequestSession' {
				$result = Get-PASOAuthWebSession -AccessToken $Token
				$result | Should -BeOfType [Microsoft.PowerShell.Commands.WebRequestSession]
			}

			It 'sets Bearer Authorization header' {
				$result = Get-PASOAuthWebSession -AccessToken $Token
				$result.Headers['Authorization'] | Should -Be 'Bearer SomeToken'
			}

			It 'removes existing Bearer prefix' {
				$result = Get-PASOAuthWebSession -AccessToken $(ConvertTo-SecureString 'Bearer SomeToken' -AsPlainText -Force)
				$result.Headers['Authorization'] | Should -Be 'Bearer SomeToken'
			}

			It 'sets X-CA-Authentication-Type header' {
				$result = Get-PASOAuthWebSession -AccessToken $Token
				$result.Headers['X-CA-Authentication-Type'] | Should -Be 'OAuth'
			}

		}

		Context 'Certificates' {

			BeforeEach {
				$Key = [System.Security.Cryptography.RSA]::Create(2048)
				$Request = [System.Security.Cryptography.X509Certificates.CertificateRequest]::new('CN=psPAS', $Key, [System.Security.Cryptography.HashAlgorithmName]::SHA256, [System.Security.Cryptography.RSASignaturePadding]::Pkcs1)
				$ClientCertificate = $Request.CreateSelfSigned([System.DateTimeOffset]::Now, [System.DateTimeOffset]::Now.AddDays(1))
			}

			It 'adds Certificate to WebSession' {
				$result = Get-PASOAuthWebSession -AccessToken $Token -Certificate $ClientCertificate
				$result.Certificates.Count | Should -Be 1
				$result.Certificates[0].Thumbprint | Should -Be $ClientCertificate.Thumbprint
			}

			It 'adds certificate matching CertificateThumbprint to WebSession' {
				Mock Get-ChildItem -MockWith { $ClientCertificate }
				$result = Get-PASOAuthWebSession -AccessToken $Token -CertificateThumbprint $ClientCertificate.Thumbprint
				$result.Certificates.Count | Should -Be 1
				$result.Certificates[0].Thumbprint | Should -Be $ClientCertificate.Thumbprint
			}

			It 'does not set Certificates if no certificate specified' {
				$result = Get-PASOAuthWebSession -AccessToken $Token
				$result.Certificates | Should -BeNullOrEmpty
			}

			It 'throws if thumbprint not found' {
				Mock Get-ChildItem -MockWith { }
				{ Get-PASOAuthWebSession -AccessToken $Token -CertificateThumbprint 'SomeThumbprint' } |
					Should -Throw 'No certificate with thumbprint SomeThumbprint found in Cert:\CurrentUser\My or Cert:\LocalMachine\My'
			}

		}

		Context 'SkipCertificateCheck' {

			It 'skips certificate validation' {
				Get-PASOAuthWebSession -AccessToken $Token -SkipCertificateCheck
				if (Test-IsCoreCLR) {
					$Script:SkipCertificateCheck | Should -BeTrue
				} else {
					Assert-MockCalled Skip-CertificateCheck -Times 1 -Exactly -Scope It
				}
			}

		}

	}

}
