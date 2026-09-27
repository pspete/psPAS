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
