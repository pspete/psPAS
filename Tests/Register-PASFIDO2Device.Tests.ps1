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

		Context 'Parameter Sets' {

			It 'has expected parameter sets' {

				$ParameterSets = (Get-Command Register-PASFIDO2Device).ParameterSets

				$ParameterSets.Name | Should -Contain 'Default'
				$ParameterSets.Name | Should -Contain 'OwnDevice'

			}

			It 'declares Default as the default parameter set' {

				(Get-Command Register-PASFIDO2Device).DefaultParameterSet | Should -Be 'Default'

			}

			It 'specifies OwnDevice as a mandatory switch in OwnDevice set' {

				$param = (Get-Command Register-PASFIDO2Device).Parameters['OwnDevice']
				$attr = $param.Attributes | Where-Object { $_.ParameterSetName -eq 'OwnDevice' }
				$attr.Mandatory | Should -Be $true

			}

		}

		Context 'Input - Admin Registration with UserId' {

			BeforeEach {
				$psPASSession.ExternalVersion = '14.6'
				$Script:CapturedRequests = New-Object System.Collections.Generic.List[hashtable]

				Mock Invoke-PASRestMethod -MockWith {
					$Script:CapturedRequests.Add(@{ URI = $URI; Method = $Method; Body = $Body })
					return [pscustomobject]@{
						createCredentialOptions = [pscustomobject]@{
							rp        = [pscustomobject]@{ id = 'pvwa.example.com'; name = 'PVWA' }
							user      = [pscustomobject]@{ id = 'abc'; name = 'u'; displayName = 'U' }
							challenge = 'chal'
						}
					}
				}

				Mock Invoke-FIDO2MakeCredential -MockWith {
					return @{
						CredentialId      = 'cred-id-b64'
						AttestationObject = 'att-obj-b64'
						ClientDataJson    = 'cdj-b64'
					}
				}

				Register-PASFIDO2Device -UserId 57

			}

			It 'sends two REST calls (options + register)' {

				Assert-MockCalled Invoke-PASRestMethod -Times 2 -Exactly -Scope It

			}

			It 'sends options request to expected endpoint' {

				$optionsCall = $Script:CapturedRequests[0]
				$optionsCall.URI | Should -Be "$($Script:psPASSession.BaseURI)/api/fido2/registrationOptions"

			}

			It 'sends options request with UserId in body' {

				$optionsCall = $Script:CapturedRequests[0]
				($optionsCall.Body | ConvertFrom-Json).UserId | Should -Be 57

			}

			It 'sends register request to expected endpoint' {

				$registerCall = $Script:CapturedRequests[1]
				$registerCall.URI | Should -Be "$($Script:psPASSession.BaseURI)/api/fido2/registration"

			}

			It 'sends register request using POST' {

				$registerCall = $Script:CapturedRequests[1]
				$registerCall.Method | Should -Be 'POST'

			}

			It 'sends register body matching documented attestation shape' {

				$parsed = $Script:CapturedRequests[1].Body | ConvertFrom-Json
				$parsed.Attestation.Id | Should -Be 'cred-id-b64'
				$parsed.Attestation.Type | Should -Be 'public-key'
				$parsed.Attestation.Response.AttestationObject | Should -Be 'att-obj-b64'
				$parsed.Attestation.Response.ClientDataJson | Should -Be 'cdj-b64'
				$parsed.UserId | Should -Be 57

			}

			It 'invokes the WebAuthn MakeCredential ceremony once' {

				Assert-MockCalled Invoke-FIDO2MakeCredential -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '14.5'
				{ Register-PASFIDO2Device -UserId 57 } | Should -Throw
				$psPASSession.ExternalVersion = '14.6'
			}

		}

		Context 'Input - Admin Registration without UserId' {

			BeforeEach {
				$psPASSession.ExternalVersion = '14.6'
				$Script:CapturedRequests = New-Object System.Collections.Generic.List[hashtable]

				Mock Invoke-PASRestMethod -MockWith {
					$Script:CapturedRequests.Add(@{ URI = $URI; Method = $Method; Body = $Body })
					return [pscustomobject]@{
						createCredentialOptions = [pscustomobject]@{
							rp = [pscustomobject]@{ id = 'pvwa.example.com'; name = 'PVWA' }
						}
					}
				}

				Mock Invoke-FIDO2MakeCredential -MockWith {
					return @{
						CredentialId      = 'cred-id-b64'
						AttestationObject = 'att-obj-b64'
						ClientDataJson    = 'cdj-b64'
					}
				}

				Register-PASFIDO2Device

			}

			It 'sends options request with empty body when no UserId supplied' {

				$optionsCall = $Script:CapturedRequests[0]
				$optionsCall.URI | Should -Match 'registrationOptions$'
				$optionsCall.Body | Should -Be '{}'

			}

			It 'omits UserId from register body when not supplied' {

				$parsed = $Script:CapturedRequests[1].Body | ConvertFrom-Json
				$parsed.PSObject.Properties.Name | Should -Not -Contain 'UserId'

			}

		}

		Context 'Input - Self Registration (-OwnDevice)' {

			BeforeEach {
				$psPASSession.ExternalVersion = '14.6'
				$Script:CapturedRequests = New-Object System.Collections.Generic.List[hashtable]

				Mock Invoke-PASRestMethod -MockWith {
					$Script:CapturedRequests.Add(@{ URI = $URI; Method = $Method; Body = $Body })
					return [pscustomobject]@{
						createCredentialOptions = [pscustomobject]@{
							rp = [pscustomobject]@{ id = 'pvwa.example.com'; name = 'PVWA' }
						}
					}
				}

				Mock Invoke-FIDO2MakeCredential -MockWith {
					return @{
						CredentialId      = 'self-cred-id'
						AttestationObject = 'self-att-obj'
						ClientDataJson    = 'self-cdj'
					}
				}

				Register-PASFIDO2Device -OwnDevice

			}

			It 'sends self-options request to selfRegistrationOptions endpoint' {

				$optionsCall = $Script:CapturedRequests[0]
				$optionsCall.URI | Should -Be "$($Script:psPASSession.BaseURI)/api/fido2/selfRegistrationOptions"

			}

			It 'sends self-options request with empty JSON object body' {

				$optionsCall = $Script:CapturedRequests[0]
				$optionsCall.Body | Should -Be '{}'

			}

			It 'sends self-register request to selfRegistration endpoint' {

				$registerCall = $Script:CapturedRequests[1]
				$registerCall.URI | Should -Be "$($Script:psPASSession.BaseURI)/api/fido2/selfRegistration"

			}

			It 'self-register body does not include UserId' {

				$parsed = $Script:CapturedRequests[1].Body | ConvertFrom-Json
				$parsed.PSObject.Properties.Name | Should -Not -Contain 'UserId'

			}

			It 'self-register body still includes attestation in documented shape' {

				$parsed = $Script:CapturedRequests[1].Body | ConvertFrom-Json
				$parsed.Attestation.Id | Should -Be 'self-cred-id'
				$parsed.Attestation.Response.AttestationObject | Should -Be 'self-att-obj'
				$parsed.Attestation.Response.ClientDataJson | Should -Be 'self-cdj'

			}

		}

		Context 'Error Handling' {

			BeforeEach {
				$psPASSession.ExternalVersion = '14.6'
			}

			It 'throws if registrationOptions response is missing createCredentialOptions' {

				Mock Invoke-PASRestMethod -MockWith { return [pscustomobject]@{ } }
				Mock Invoke-FIDO2MakeCredential -MockWith { @{ } }

				{ Register-PASFIDO2Device -UserId 57 } | Should -Throw

			}

			It 'does not call MakeCredential when options request returns nothing useful' {

				Mock Invoke-PASRestMethod -MockWith { return [pscustomobject]@{ } }
				Mock Invoke-FIDO2MakeCredential -MockWith { @{ } }

				{ Register-PASFIDO2Device -UserId 57 } | Should -Throw
				Assert-MockCalled Invoke-FIDO2MakeCredential -Times 0 -Exactly -Scope It

			}

		}

	}

}
