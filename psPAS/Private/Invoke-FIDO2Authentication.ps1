function Invoke-FIDO2Authentication {
	<#
	.SYNOPSIS
	Performs FIDO2 authentication via the Windows WebAuthn API

	.DESCRIPTION
	Handles the FIDO2 authentication flow:
	1. Requests assertion options from the CyberArk API.
	2. Uses a FIDO2 device (via webauthn.dll) to generate an assertion.
	3. Submits the assertion back to the CyberArk API.

	.PARAMETER BaseURI
	The base URI for the CyberArk PVWA

	.PARAMETER UserName
	The username for FIDO2 authentication

	.PARAMETER LogonRequest
	Hashtable containing the logon request parameters

	.EXAMPLE
	Invoke-FIDO2Authentication -BaseURI 'https://pvwa.example.com/PasswordVault' -UserName 'myuser' -LogonRequest $request

	.NOTES
	Requires Windows 10 1903+ (ships webauthn.dll). No third-party assemblies required.
	#>
	[CmdletBinding()]
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

		if ((Test-IsCoreCLR) -and -not $IsWindows) {
			throw 'FIDO2 authentication is only supported on Windows platforms'
		}

		#Compile P/Invoke wrapper for Windows webauthn.dll on first use
		if (-not ('psPAS.WebAuthn.Native' -as [type])) {

			Add-Type -ErrorAction Stop -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

namespace psPAS.WebAuthn {

	[StructLayout(LayoutKind.Sequential)]
	public struct WEBAUTHN_CLIENT_DATA {
		public uint dwVersion;
		public uint cbClientDataJSON;
		public IntPtr pbClientDataJSON;
		[MarshalAs(UnmanagedType.LPWStr)] public string pwszHashAlgId;
	}

	[StructLayout(LayoutKind.Sequential)]
	public struct WEBAUTHN_CREDENTIAL {
		public uint dwVersion;
		public uint cbId;
		public IntPtr pbId;
		[MarshalAs(UnmanagedType.LPWStr)] public string pwszCredentialType;
	}

	[StructLayout(LayoutKind.Sequential)]
	public struct WEBAUTHN_CREDENTIALS {
		public uint cCredentials;
		public IntPtr pCredentials;
	}

	[StructLayout(LayoutKind.Sequential)]
	public struct WEBAUTHN_EXTENSIONS {
		public uint cExtensions;
		public IntPtr pExtensions;
	}

	[StructLayout(LayoutKind.Sequential)]
	public struct WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS {
		public uint dwVersion;
		public uint dwTimeoutMilliseconds;
		public WEBAUTHN_CREDENTIALS CredentialList;
		public WEBAUTHN_EXTENSIONS Extensions;
		public uint dwAuthenticatorAttachment;
		public uint dwUserVerificationRequirement;
		public uint dwFlags;
	}

	[StructLayout(LayoutKind.Sequential)]
	public struct WEBAUTHN_ASSERTION {
		public uint dwVersion;
		public uint cbAuthenticatorData;
		public IntPtr pbAuthenticatorData;
		public uint cbSignature;
		public IntPtr pbSignature;
		public WEBAUTHN_CREDENTIAL Credential;
		public uint cbUserId;
		public IntPtr pbUserId;
	}

	public static class Native {

		[DllImport("webauthn.dll", CharSet = CharSet.Unicode)]
		public static extern int WebAuthNAuthenticatorGetAssertion(
			IntPtr hWnd,
			[MarshalAs(UnmanagedType.LPWStr)] string pwszRpId,
			ref WEBAUTHN_CLIENT_DATA pWebAuthNClientData,
			ref WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS pWebAuthNGetAssertionOptions,
			out IntPtr ppWebAuthNAssertion);

		[DllImport("webauthn.dll")]
		public static extern void WebAuthNFreeAssertion(IntPtr pWebAuthNAssertion);

		[DllImport("webauthn.dll", CharSet = CharSet.Unicode)]
		public static extern IntPtr WebAuthNGetErrorName(int hr);

		[DllImport("user32.dll")]
		public static extern IntPtr GetForegroundWindow();
	}
}
'@

		}

		#Base64Url encode a byte array
		$toB64Url = { param([byte[]]$Bytes) [Convert]::ToBase64String($Bytes).Replace('+', '-').Replace('/', '_').TrimEnd('=') }

	}

	process {

		#Passthrough parameters shared with each API call
		$commonParams = @{}
		foreach ($key in 'UseDefaultCredentials', 'SkipCertificateCheck', 'Certificate', 'CertificateThumbprint') {
			if ($LogonRequest -and $LogonRequest.ContainsKey($key)) { $commonParams[$key] = $LogonRequest[$key] }
		}

		#Request assertion options
		$assertionOptions = (Invoke-PASRestMethod @commonParams `
				-Uri "$BaseURI/api/auth/fido/logon" -Method POST `
				-Body (@{ username = $UserName; type = 'fido' } | ConvertTo-Json)).assertionOptions

		#Build clientDataJSON (same structure the server verifies against)
		$clientDataJson = '{"type":"webauthn.get","challenge":"' + $assertionOptions.challenge +
		'","origin":"https://' + $assertionOptions.rpId + '","crossOrigin":false}'
		$clientDataBytes = [System.Text.Encoding]::UTF8.GetBytes($clientDataJson)

		$allocations = New-Object System.Collections.Generic.List[IntPtr]
		$pAssertion = [IntPtr]::Zero

		try {

			#Marshal clientData
			$pClientDataJson = [Runtime.InteropServices.Marshal]::AllocHGlobal($clientDataBytes.Length)
			$allocations.Add($pClientDataJson)
			[Runtime.InteropServices.Marshal]::Copy($clientDataBytes, 0, $pClientDataJson, $clientDataBytes.Length)

			$clientData = New-Object psPAS.WebAuthn.WEBAUTHN_CLIENT_DATA
			$clientData.dwVersion = 1
			$clientData.cbClientDataJSON = $clientDataBytes.Length
			$clientData.pbClientDataJSON = $pClientDataJson
			$clientData.pwszHashAlgId = 'SHA-256'

			#Marshal allowed credentials list
			$credStructs = @()
			foreach ($cred in $assertionOptions.allowCredentials) {
				$credIdBytes = ConvertFrom-Base64UrlString -InputString $cred.id
				$pCredId = [Runtime.InteropServices.Marshal]::AllocHGlobal($credIdBytes.Length)
				$allocations.Add($pCredId)
				[Runtime.InteropServices.Marshal]::Copy($credIdBytes, 0, $pCredId, $credIdBytes.Length)

				$wCred = New-Object psPAS.WebAuthn.WEBAUTHN_CREDENTIAL
				$wCred.dwVersion = 1
				$wCred.cbId = $credIdBytes.Length
				$wCred.pbId = $pCredId
				$wCred.pwszCredentialType = 'public-key'
				$credStructs += $wCred
			}

			$pCredArray = [IntPtr]::Zero
			if ($credStructs.Count -gt 0) {
				$credSize = [Runtime.InteropServices.Marshal]::SizeOf([type][psPAS.WebAuthn.WEBAUTHN_CREDENTIAL])
				$pCredArray = [Runtime.InteropServices.Marshal]::AllocHGlobal($credSize * $credStructs.Count)
				$allocations.Add($pCredArray)
				for ($i = 0; $i -lt $credStructs.Count; $i++) {
					$target = [IntPtr]::new($pCredArray.ToInt64() + ($i * $credSize))
					[Runtime.InteropServices.Marshal]::StructureToPtr($credStructs[$i], $target, $false)
				}
			}

			#Nested value-type fields must be assigned whole
			#(PowerShell mutates a COPY when setting a nested struct's fields)
			$credList = New-Object psPAS.WebAuthn.WEBAUTHN_CREDENTIALS
			$credList.cCredentials = $credStructs.Count
			$credList.pCredentials = $pCredArray

			$options = New-Object psPAS.WebAuthn.WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS
			$options.dwVersion = 1
			$options.dwTimeoutMilliseconds = 60000
			$options.CredentialList = $credList
			$options.dwUserVerificationRequirement = 1  #Required

			#Invoke Windows WebAuthn API
			$hr = [psPAS.WebAuthn.Native]::WebAuthNAuthenticatorGetAssertion(
				[psPAS.WebAuthn.Native]::GetForegroundWindow(),
				$assertionOptions.rpId,
				[ref]$clientData,
				[ref]$options,
				[ref]$pAssertion
			)

			if ($hr -ne 0) {
				$errorNamePtr = [psPAS.WebAuthn.Native]::WebAuthNGetErrorName($hr)
				$errorName = if ($errorNamePtr -ne [IntPtr]::Zero) { [Runtime.InteropServices.Marshal]::PtrToStringUni($errorNamePtr) } else { "Unknown error (0x{0:X})" -f $hr }
				throw "WebAuthNAuthenticatorGetAssertion failed: $errorName"
			}

			$assertion = [Runtime.InteropServices.Marshal]::PtrToStructure(
				$pAssertion, [type][psPAS.WebAuthn.WEBAUTHN_ASSERTION]
			)

			$authenticatorData = New-Object byte[] $assertion.cbAuthenticatorData
			[Runtime.InteropServices.Marshal]::Copy($assertion.pbAuthenticatorData, $authenticatorData, 0, $assertion.cbAuthenticatorData)

			$signature = New-Object byte[] $assertion.cbSignature
			[Runtime.InteropServices.Marshal]::Copy($assertion.pbSignature, $signature, 0, $assertion.cbSignature)

			$credentialId = New-Object byte[] $assertion.Credential.cbId
			[Runtime.InteropServices.Marshal]::Copy($assertion.Credential.pbId, $credentialId, 0, $assertion.Credential.cbId)

			$userHandle = $null
			if ($assertion.cbUserId -gt 0) {
				$userHandle = New-Object byte[] $assertion.cbUserId
				[Runtime.InteropServices.Marshal]::Copy($assertion.pbUserId, $userHandle, 0, $assertion.cbUserId)
			}

		} finally {

			if ($pAssertion -ne [IntPtr]::Zero) {
				[psPAS.WebAuthn.Native]::WebAuthNFreeAssertion($pAssertion)
			}
			foreach ($ptr in $allocations) {
				[Runtime.InteropServices.Marshal]::FreeHGlobal($ptr)
			}

		}

		#Build response payload
		$credIdB64 = & $toB64Url $credentialId
		$assertionResponse = [ordered]@{
			Id         = $credIdB64
			RawId      = $credIdB64
			Type       = 'public-key'
			Extensions = @{}
			Response   = [ordered]@{
				AuthenticatorData = & $toB64Url $authenticatorData
				ClientDataJson    = & $toB64Url $clientDataBytes
				Signature         = & $toB64Url $signature
				UserHandle        = if ($userHandle) { & $toB64Url $userHandle } else { $null }
			}
		}

		$additionalInfo = & $toB64Url ([System.Text.Encoding]::UTF8.GetBytes(($assertionResponse | ConvertTo-Json -Depth 10 -Compress)))

		#Submit assertion
		Invoke-PASRestMethod @commonParams `
			-Uri "$BaseURI/api/auth/fido/logon" -Method POST `
			-Body (@{ userName = $UserName; AdditionalInfo = $additionalInfo } | ConvertTo-Json) `
			-SessionVariable 'FIDOSession'

	}

}
