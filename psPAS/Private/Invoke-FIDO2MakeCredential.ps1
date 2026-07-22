function Invoke-FIDO2MakeCredential {
	<#
	.SYNOPSIS
	Performs a FIDO2 MakeCredential ceremony via the Windows WebAuthn API.

	.DESCRIPTION
	Wraps the webauthn.dll WebAuthNAuthenticatorMakeCredential P/Invoke call.
	Given the createCredentialOptions returned by the CyberArk
	"Start FIDO2 registration" endpoint, prompts the user to interact with their
	FIDO2 authenticator and returns the resulting attestation as base64url-encoded
	values ready to submit to the "Register FIDO2 device" endpoint.

	.PARAMETER Options
	The createCredentialOptions object returned by the
	/api/fido2/registrationOptions endpoint.

	.NOTES
	Requires Windows 10 1903+ (ships webauthn.dll).
	#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', 'CreateCredentialOptions', Justification = 'Parameter does not hold a password or credential')]
	[CmdletBinding()]
	[OutputType([hashtable])]
	param(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[object]$Options
	)

	begin {

		if ((Test-IsCoreCLR) -and -not $IsWindows) {
			throw 'FIDO2 device registration is only supported on Windows platforms'
		}

		#Compile P/Invoke wrapper for Windows webauthn.dll on first use.
		#A separate type is used for registration so that this helper is self-contained.
		if (-not ('psPAS.WebAuthnReg.Native' -as [type])) {

			Add-Type -ErrorAction Stop -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

namespace psPAS.WebAuthnReg {

	[StructLayout(LayoutKind.Sequential)]
	public struct WEBAUTHN_RP_ENTITY_INFORMATION {
		public uint dwVersion;
		[MarshalAs(UnmanagedType.LPWStr)] public string pwszId;
		[MarshalAs(UnmanagedType.LPWStr)] public string pwszName;
		[MarshalAs(UnmanagedType.LPWStr)] public string pwszIcon;
	}

	[StructLayout(LayoutKind.Sequential)]
	public struct WEBAUTHN_USER_ENTITY_INFORMATION {
		public uint dwVersion;
		public uint cbId;
		public IntPtr pbId;
		[MarshalAs(UnmanagedType.LPWStr)] public string pwszName;
		[MarshalAs(UnmanagedType.LPWStr)] public string pwszIcon;
		[MarshalAs(UnmanagedType.LPWStr)] public string pwszDisplayName;
	}

	[StructLayout(LayoutKind.Sequential)]
	public struct WEBAUTHN_COSE_CREDENTIAL_PARAMETER {
		public uint dwVersion;
		[MarshalAs(UnmanagedType.LPWStr)] public string pwszCredentialType;
		public int lAlg;
	}

	[StructLayout(LayoutKind.Sequential)]
	public struct WEBAUTHN_COSE_CREDENTIAL_PARAMETERS {
		public uint cCredentialParameters;
		public IntPtr pCredentialParameters;
	}

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
	public struct WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS {
		public uint dwVersion;
		public uint dwTimeoutMilliseconds;
		public WEBAUTHN_CREDENTIALS CredentialList;
		public WEBAUTHN_EXTENSIONS Extensions;
		public uint dwAuthenticatorAttachment;
		[MarshalAs(UnmanagedType.Bool)] public bool bRequireResidentKey;
		public uint dwUserVerificationRequirement;
		public uint dwAttestationConveyancePreference;
		public uint dwFlags;
	}

	[StructLayout(LayoutKind.Sequential)]
	public struct WEBAUTHN_CREDENTIAL_ATTESTATION {
		public uint dwVersion;
		[MarshalAs(UnmanagedType.LPWStr)] public string pwszFormatType;
		public uint cbAuthenticatorData;
		public IntPtr pbAuthenticatorData;
		public uint cbAttestation;
		public IntPtr pbAttestation;
		public uint dwAttestationDecodeType;
		public IntPtr pvAttestationDecode;
		public uint cbAttestationObject;
		public IntPtr pbAttestationObject;
		public uint cbCredentialId;
		public IntPtr pbCredentialId;
	}

	public static class Native {

		[DllImport("webauthn.dll", CharSet = CharSet.Unicode)]
		public static extern int WebAuthNAuthenticatorMakeCredential(
			IntPtr hWnd,
			ref WEBAUTHN_RP_ENTITY_INFORMATION pRpInformation,
			ref WEBAUTHN_USER_ENTITY_INFORMATION pUserInformation,
			ref WEBAUTHN_COSE_CREDENTIAL_PARAMETERS pPubKeyCredParams,
			ref WEBAUTHN_CLIENT_DATA pWebAuthNClientData,
			ref WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS pWebAuthNMakeCredentialOptions,
			out IntPtr ppWebAuthNCredentialAttestation);

		[DllImport("webauthn.dll")]
		public static extern void WebAuthNFreeCredentialAttestation(IntPtr pWebAuthNCredentialAttestation);

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

		#Build clientDataJSON for the create ceremony
		$clientDataJson = '{"type":"webauthn.create","challenge":"' + $Options.challenge +
		'","origin":"https://' + $Options.rp.id + '","crossOrigin":false}'
		$clientDataBytes = [System.Text.Encoding]::UTF8.GetBytes($clientDataJson)

		#User handle is supplied as a base64url string in the registration options
		$userIdBytes = ConvertFrom-Base64UrlString -InputString $Options.user.id

		$allocations = New-Object System.Collections.Generic.List[IntPtr]
		$pAttestation = [IntPtr]::Zero

		try {

			#Marshal clientData
			$pClientDataJson = [Runtime.InteropServices.Marshal]::AllocHGlobal($clientDataBytes.Length)
			$allocations.Add($pClientDataJson)
			[Runtime.InteropServices.Marshal]::Copy($clientDataBytes, 0, $pClientDataJson, $clientDataBytes.Length)

			$clientData = New-Object psPAS.WebAuthnReg.WEBAUTHN_CLIENT_DATA
			$clientData.dwVersion = 1
			$clientData.cbClientDataJSON = $clientDataBytes.Length
			$clientData.pbClientDataJSON = $pClientDataJson
			$clientData.pwszHashAlgId = 'SHA-256'

			#Marshal user id
			$pUserId = [Runtime.InteropServices.Marshal]::AllocHGlobal($userIdBytes.Length)
			$allocations.Add($pUserId)
			[Runtime.InteropServices.Marshal]::Copy($userIdBytes, 0, $pUserId, $userIdBytes.Length)

			$rp = New-Object psPAS.WebAuthnReg.WEBAUTHN_RP_ENTITY_INFORMATION
			$rp.dwVersion = 1
			$rp.pwszId = $Options.rp.id
			$rp.pwszName = $Options.rp.name

			$user = New-Object psPAS.WebAuthnReg.WEBAUTHN_USER_ENTITY_INFORMATION
			$user.dwVersion = 1
			$user.cbId = $userIdBytes.Length
			$user.pbId = $pUserId
			$user.pwszName = $Options.user.name
			$user.pwszDisplayName = $Options.user.displayName

			#Marshal pubKeyCredParams array
			$paramStructs = @()
			foreach ($p in $Options.pubKeyCredParams) {
				$cp = New-Object psPAS.WebAuthnReg.WEBAUTHN_COSE_CREDENTIAL_PARAMETER
				$cp.dwVersion = 1
				$cp.pwszCredentialType = $p.type
				$cp.lAlg = [int]$p.alg
				$paramStructs += $cp
			}

			$pParamArray = [IntPtr]::Zero
			if ($paramStructs.Count -gt 0) {
				$paramSize = [Runtime.InteropServices.Marshal]::SizeOf([type][psPAS.WebAuthnReg.WEBAUTHN_COSE_CREDENTIAL_PARAMETER])
				$pParamArray = [Runtime.InteropServices.Marshal]::AllocHGlobal($paramSize * $paramStructs.Count)
				$allocations.Add($pParamArray)
				for ($i = 0; $i -lt $paramStructs.Count; $i++) {
					$target = [IntPtr]::new($pParamArray.ToInt64() + ($i * $paramSize))
					[Runtime.InteropServices.Marshal]::StructureToPtr($paramStructs[$i], $target, $false)
				}
			}

			$pubKeyCredParams = New-Object psPAS.WebAuthnReg.WEBAUTHN_COSE_CREDENTIAL_PARAMETERS
			$pubKeyCredParams.cCredentialParameters = $paramStructs.Count
			$pubKeyCredParams.pCredentialParameters = $pParamArray

			#Marshal excludeCredentials
			$excludeStructs = @()
			if ($Options.excludeCredentials) {
				foreach ($cred in $Options.excludeCredentials) {
					$credIdBytes = ConvertFrom-Base64UrlString -InputString $cred.id
					$pCredId = [Runtime.InteropServices.Marshal]::AllocHGlobal($credIdBytes.Length)
					$allocations.Add($pCredId)
					[Runtime.InteropServices.Marshal]::Copy($credIdBytes, 0, $pCredId, $credIdBytes.Length)

					$wCred = New-Object psPAS.WebAuthnReg.WEBAUTHN_CREDENTIAL
					$wCred.dwVersion = 1
					$wCred.cbId = $credIdBytes.Length
					$wCred.pbId = $pCredId
					$wCred.pwszCredentialType = 'public-key'
					$excludeStructs += $wCred
				}
			}

			$pExcludeArray = [IntPtr]::Zero
			if ($excludeStructs.Count -gt 0) {
				$credSize = [Runtime.InteropServices.Marshal]::SizeOf([type][psPAS.WebAuthnReg.WEBAUTHN_CREDENTIAL])
				$pExcludeArray = [Runtime.InteropServices.Marshal]::AllocHGlobal($credSize * $excludeStructs.Count)
				$allocations.Add($pExcludeArray)
				for ($i = 0; $i -lt $excludeStructs.Count; $i++) {
					$target = [IntPtr]::new($pExcludeArray.ToInt64() + ($i * $credSize))
					[Runtime.InteropServices.Marshal]::StructureToPtr($excludeStructs[$i], $target, $false)
				}
			}

			$excludeList = New-Object psPAS.WebAuthnReg.WEBAUTHN_CREDENTIALS
			$excludeList.cCredentials = $excludeStructs.Count
			$excludeList.pCredentials = $pExcludeArray

			#Map authenticatorSelection / attestation values
			$uvRequirement = 0
			switch ($Options.authenticatorSelection.userVerification) {
				'required'    { $uvRequirement = 1 }
				'preferred'   { $uvRequirement = 2 }
				'discouraged' { $uvRequirement = 3 }
			}

			$attachment = 0
			switch ($Options.authenticatorSelection.authenticatorAttachment) {
				'platform'       { $attachment = 1 }
				'cross-platform' { $attachment = 2 }
			}

			$attestationPref = 0
			switch ($Options.attestation) {
				'none'       { $attestationPref = 1 }
				'indirect'   { $attestationPref = 2 }
				'direct'     { $attestationPref = 3 }
				'enterprise' { $attestationPref = 4 }
			}

			$options = New-Object psPAS.WebAuthnReg.WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS
			#dwVersion=1: struct layout matches the fields declared above (up to dwFlags).
			#Higher versions (2+) require additional fields (pCancellationId, pExcludeCredentialList, ...);
			#using a higher version with a smaller struct causes webauthn.dll to read past the
			#end of the struct and access-violate.
			$options.dwVersion = 1
			$options.dwTimeoutMilliseconds = if ($Options.timeout) { [uint32]$Options.timeout } else { 60000 }
			#At V1, CredentialList is the (deprecated) exclude credentials list
			$options.CredentialList = $excludeList
			$options.dwAuthenticatorAttachment = $attachment
			$options.bRequireResidentKey = [bool]$Options.authenticatorSelection.requireResidentKey
			$options.dwUserVerificationRequirement = $uvRequirement
			$options.dwAttestationConveyancePreference = $attestationPref

			#Invoke Windows WebAuthn API
			$hr = [psPAS.WebAuthnReg.Native]::WebAuthNAuthenticatorMakeCredential(
				[psPAS.WebAuthnReg.Native]::GetForegroundWindow(),
				[ref]$rp,
				[ref]$user,
				[ref]$pubKeyCredParams,
				[ref]$clientData,
				[ref]$options,
				[ref]$pAttestation
			)

			if ($hr -ne 0) {
				$errorNamePtr = [psPAS.WebAuthnReg.Native]::WebAuthNGetErrorName($hr)
				$errorName = if ($errorNamePtr -ne [IntPtr]::Zero) { [Runtime.InteropServices.Marshal]::PtrToStringUni($errorNamePtr) } else { "Unknown error (0x{0:X})" -f $hr }
				throw "WebAuthNAuthenticatorMakeCredential failed: $errorName"
			}

			$attestation = [Runtime.InteropServices.Marshal]::PtrToStructure(
				$pAttestation, [type][psPAS.WebAuthnReg.WEBAUTHN_CREDENTIAL_ATTESTATION]
			)

			$credentialId = New-Object byte[] $attestation.cbCredentialId
			[Runtime.InteropServices.Marshal]::Copy($attestation.pbCredentialId, $credentialId, 0, $attestation.cbCredentialId)

			$attestationObject = New-Object byte[] $attestation.cbAttestationObject
			[Runtime.InteropServices.Marshal]::Copy($attestation.pbAttestationObject, $attestationObject, 0, $attestation.cbAttestationObject)

		} finally {

			if ($pAttestation -ne [IntPtr]::Zero) {
				[psPAS.WebAuthnReg.Native]::WebAuthNFreeCredentialAttestation($pAttestation)
			}
			foreach ($ptr in $allocations) {
				[Runtime.InteropServices.Marshal]::FreeHGlobal($ptr)
			}

		}

		#Return base64url-encoded values for the registration submission
		@{
			CredentialId      = & $toB64Url $credentialId
			AttestationObject = & $toB64Url $attestationObject
			ClientDataJson    = & $toB64Url $clientDataBytes
		}

	}

}
