function Invoke-FIDO2Authentication {
	<#
	.SYNOPSIS
	Performs FIDO2 authentication using DSInternals.Win32.WebAuthn

	.DESCRIPTION
	Handles the two-step FIDO2 authentication flow:
	1. Request assertion options from CyberArk API
	2. Use FIDO2 device to generate assertion
	3. Submit assertion back to CyberArk API

	.PARAMETER BaseURI
	The base URI for the CyberArk PVWA

	.PARAMETER UserName
	The username for FIDO2 authentication

	.PARAMETER LogonRequest
	Hashtable containing the logon request parameters

	.EXAMPLE
	Invoke-FIDO2Authentication -BaseURI 'https://pvwa.example.com/PasswordVault' -UserName 'administrator' -LogonRequest $request

	.NOTES
	Requires Windows 10 1903+ and the DSInternals.Win32.WebAuthn assembly
	#>
	[CmdletBinding()]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'LogonRequest', Justification = 'LogonRequest is used within scriptblock via closure')]
	param(
		[Parameter(Mandatory = $true)]
		[string]$BaseURI,

		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UserName,

		[Parameter(Mandatory = $false)]
		[hashtable]$LogonRequest
	)

	begin {
		# FIDO2 requires Windows 10+
		if ((Test-IsCoreCLR) -and -not $IsWindows) {
			throw 'FIDO2 authentication is only supported on Windows platforms'
		}

		# Load DSInternals.Win32.WebAuthn
		try {
			$assemblyPath = Join-Path $Script:ModuleRoot 'lib\DSInternals.Win32.WebAuthn.dll'

			if (Test-Path $assemblyPath) {
				Add-Type -Path $assemblyPath -ErrorAction Stop
			} else {
				throw "DSInternals.Win32.WebAuthn assembly not found at: $assemblyPath"
			}
		} catch {
			throw "Failed to load WebAuthn Interop Assembly: $($_.Exception.Message)"
		}
	}

	process {
		try {
			# Helper to add LogonRequest parameters to API call parameters
			$addLogonParams = {
				param($Target)
				'UseDefaultCredentials', 'SkipCertificateCheck', 'Certificate', 'CertificateThumbprint' | ForEach-Object {
					if ($LogonRequest.ContainsKey($_)) { $Target[$_] = $LogonRequest[$_] }
				}
			}

			$challengeParams = @{
				Uri    = "$BaseURI/api/auth/fido/logon"
				Method = 'POST'
				Body   = (@{ username = $UserName; type = 'fido' } | ConvertTo-Json)
			}
			& $addLogonParams $challengeParams

			$challengeResponse = Invoke-PASRestMethod @challengeParams

			$assertionOptions = $challengeResponse.assertionOptions

            # Use FIDO2 device to generate assertion
			$webAuthnApi = New-Object DSInternals.Win32.WebAuthn.WebAuthnApi
			$challengeBytes = ConvertFrom-Base64UrlString -InputString $assertionOptions.challenge

			# Build allowed credentials list
			$allowCredentials = New-Object 'System.Collections.Generic.List[DSInternals.Win32.WebAuthn.PublicKeyCredentialDescriptor]'
			if ($assertionOptions.allowCredentials) {
				$assertionOptions.allowCredentials | ForEach-Object {
					$credId = ConvertFrom-Base64UrlString -InputString $_.id
					$allowCredentials.Add((New-Object DSInternals.Win32.WebAuthn.PublicKeyCredentialDescriptor -ArgumentList @(
								$credId,
								[DSInternals.Win32.WebAuthn.AuthenticatorTransport]::NoRestrictions,
								'public-key'
							)))
				}
			}

			# Set user verification to required
			$userVerification = [DSInternals.Win32.WebAuthn.UserVerificationRequirement]::Required

			# Create CollectedClientData with correct origin (bypasses DSInternals' UriBuilder :80/ issue)
			$clientData = New-Object DSInternals.Win32.WebAuthn.FIDO.CollectedClientData
			$clientData.Type = 'webauthn.get'
			$clientData.Challenge = $challengeBytes
			$clientData.Origin = "https://$($assertionOptions.rpId)"
			$clientData.CrossOrigin = $false

			$assertion = $webAuthnApi.AuthenticatorGetAssertion(
				$assertionOptions.rpId, $clientData, $userVerification,
				[DSInternals.Win32.WebAuthn.AuthenticatorAttachment]::Any, 60000, $allowCredentials
			)

			# Build the response payload
			$credentialIdBytes = $allowCredentials[0].Id

			$assertionResponse = [ordered]@{
				Id         = [Convert]::ToBase64String($credentialIdBytes).Replace('+', '-').Replace('/', '_').TrimEnd('=')
				RawId      = [Convert]::ToBase64String($credentialIdBytes).Replace('+', '-').Replace('/', '_').TrimEnd('=')
				Type       = 'public-key'
				Extensions = @{}
				Response   = [ordered]@{
					AuthenticatorData = [Convert]::ToBase64String($assertion.AuthenticatorData).Replace('+', '-').Replace('/', '_').TrimEnd('=')
					ClientDataJson    = [Convert]::ToBase64String($assertion.ClientDataJson).Replace('+', '-').Replace('/', '_').TrimEnd('=')
					Signature         = [Convert]::ToBase64String($assertion.Signature).Replace('+', '-').Replace('/', '_').TrimEnd('=')
					UserHandle        = $null
				}
			}

			if ($assertion.UserHandle -and $assertion.UserHandle.Length -gt 0) {
				$assertionResponse.Response.UserHandle = [Convert]::ToBase64String($assertion.UserHandle).Replace('+', '-').Replace('/', '_').TrimEnd('=')
			}

			$additionalInfo = $assertionResponse | ConvertTo-Json -Depth 10 -Compress
			$additionalInfoBase64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($additionalInfo)).Replace('+', '-').Replace('/', '_').TrimEnd('=')

			# Submit assertion to CyberArk API
			$authParams = @{
				Uri             = "$BaseURI/api/auth/fido/logon"
				Method          = 'POST'
				Body            = (@{ userName = $UserName; AdditionalInfo = $additionalInfoBase64 } | ConvertTo-Json)
				SessionVariable = 'FIDOSession'
			}
			& $addLogonParams $authParams

			$authResponse = Invoke-PASRestMethod @authParams

			return $authResponse

		} catch {
			throw "FIDO2 authentication failed: $($_.Exception.Message)"
		}
	}

	end {}
}
