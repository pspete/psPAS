function Get-PASOAuthWebSession {
	<#
	.SYNOPSIS
	Returns a WebSession configured for OAuth 2.0 Bearer token authentication

	.DESCRIPTION
	psPAS helper function.
	Creates a WebRequestSession with the CyberArk OAuth Authorization and X-CA-Authentication-Type headers set,
	adding any client certificate provided directly or resolved by thumbprint from the certificate store.

	.PARAMETER AccessToken
	The OAuth 2.0 access token. Any 'Bearer ' prefix is removed.

	.PARAMETER Certificate
	A client certificate to add to the WebSession.

	.PARAMETER CertificateThumbprint
	Thumbprint of a client certificate in Cert:\CurrentUser\My or Cert:\LocalMachine\My to add to the WebSession.

	.PARAMETER SkipCertificateCheck
	Skip SSL certificate validation.

	.EXAMPLE
	$psPASSession.WebSession = Get-PASOAuthWebSession -AccessToken $AccessToken
	#>
	[CmdletBinding()]
	[OutputType('Microsoft.PowerShell.Commands.WebRequestSession')]
	param(
		[parameter(
			Mandatory = $true
		)]
		[SecureString]$AccessToken,

		[parameter(
			Mandatory = $false
		)]
		[X509Certificate]$Certificate,

		[parameter(
			Mandatory = $false
		)]
		[string]$CertificateThumbprint,

		[parameter(
			Mandatory = $false
		)]
		[switch]$SkipCertificateCheck
	)

	process {

		if ($SkipCertificateCheck) {
			if (-not (Test-IsCoreCLR)) {
				Skip-CertificateCheck
			} else {
				$Script:SkipCertificateCheck = $true
			}
		}

		$WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

		if ($Certificate) {
			$WebSession.Certificates.Add($Certificate) | Out-Null
		}

		if ($CertificateThumbprint) {
			#Resolve certificate from the store and add to WebSession
			$ClientCertificate = Get-ChildItem -Path 'Cert:\CurrentUser\My', 'Cert:\LocalMachine\My' |
				Where-Object { $PSItem.Thumbprint -eq $CertificateThumbprint } | Select-Object -First 1

			if ($null -ne $ClientCertificate) {
				$WebSession.Certificates.Add($ClientCertificate) | Out-Null
			} else {
				throw "No certificate with thumbprint $CertificateThumbprint found in Cert:\CurrentUser\My or Cert:\LocalMachine\My"
			}
		}

		#Set required CyberArk OAuth headers
		$WebSession.Headers['Authorization'] = "Bearer $((ConvertTo-InsecureString -SecureString $AccessToken) -replace '^Bearer\s+', '')"
		$WebSession.Headers['X-CA-Authentication-Type'] = 'OAuth'

		$WebSession

	}

}
