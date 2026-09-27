function Get-PASLogonRequest {
	<#
	.SYNOPSIS
	Returns the logon request parameters for New-PASSession

	.DESCRIPTION
	psPAS helper function.
	Returns a hashtable of Invoke-PASRestMethod parameters for the logon endpoint and request body
	applicable to the New-PASSession parameter set in use.

	.PARAMETER ParameterSetName
	The New-PASSession parameter set in use.

	.PARAMETER Uri
	The PAS URL (including the PVWA application name).

	.PARAMETER IdentityTenantURL
	The Identity tenant URL for Privilege Cloud Shared Services logon.

	.PARAMETER BoundParameters
	The parameters bound to New-PASSession.

	.EXAMPLE
	Get-PASLogonRequest -ParameterSetName Gen2 -Uri https://pvwa.somedomain.com/PasswordVault -BoundParameters $PSBoundParameters
	#>
	[CmdletBinding()]
	[OutputType('System.Collections.Hashtable')]
	param(
		[parameter(
			Mandatory = $true
		)]
		[string]$ParameterSetName,

		[parameter(
			Mandatory = $false
		)]
		[string]$Uri,

		[parameter(
			Mandatory = $false
		)]
		[string]$IdentityTenantURL,

		[parameter(
			Mandatory = $true
		)]
		[hashtable]$BoundParameters
	)

	process {

		$LogonRequest = @{ }

		$LogonRequest['Method'] = 'POST'
		$LogonRequest['SessionVariable'] = 'PASSession'
		$LogonRequest['UseDefaultCredentials'] = [bool]$BoundParameters['UseDefaultCredentials']
		$LogonRequest['SkipCertificateCheck'] = [bool]$BoundParameters['SkipCertificateCheck']

		if ($BoundParameters['type'] -eq 'Windows') {

			$LogonRequest['Credential'] = $BoundParameters['Credential']

		}

		if ($BoundParameters['CertificateThumbprint']) {

			$LogonRequest['CertificateThumbprint'] = $BoundParameters['CertificateThumbprint']

		}

		if ($BoundParameters['Certificate']) {

			$LogonRequest['Certificate'] = $BoundParameters['Certificate']

		}

		switch ($ParameterSetName) {

			( { $PSItem -match '^ISPSS-.*-.*User$' } ) {

				#IdentityUser/ServiceUser LogonRequest for New-IDSession/New-IDPlatformToken
				$LogonRequest['Uri'] = $IdentityTenantURL
				$LogonRequest['Credential'] = $BoundParameters['Credential']
				break

			}

			( { $PSItem -match '^ISPSS-.*-SAML$' } ) {

				#SAMLAuth for New-IDSession
				$LogonRequest['Uri'] = $IdentityTenantURL
				$LogonRequest['SAMLResponse'] = $BoundParameters['SAMLResponse']
				break

			}

			'integrated' {

				$LogonRequest['Uri'] = "$Uri/api/Auth/Windows/Logon"  #hardcode Windows for integrated auth

				#The only expected parameter should be concurrentSessions
				$LogonRequest['Body'] = $BoundParameters | Get-PASParameter -ParametersToKeep concurrentSession | ConvertTo-Json
				break

			}

			'shared' {

				$LogonRequest['Uri'] = "$Uri/WebServices/auth/Shared/RestfulAuthenticationService.svc/Logon"
				break

			}

			'Gen1SAML' {

				$LogonRequest['Uri'] = "$Uri/WebServices/auth/SAML/SAMLAuthenticationService.svc/Logon"

				#add token to header
				$LogonRequest['Headers'] = @{'Authorization' = $BoundParameters['SAMLResponse'] }
				break

			}

			'Gen2SAML' {

				#The only expected parameter should be concurrentSession & SAMLResponse
				$Body = $BoundParameters | Get-PASParameter -ParametersToKeep concurrentSession, SAMLResponse
				$Body.Add('apiUse', $true)

				if ( -not ($BoundParameters.ContainsKey('SAMLResponse'))) {

					#Get SAML Response from IdP
					#*https://gist.github.com/infamousjoeg/b44faa299ec3de65bdd1d3b8474b0649
					$Body.Add('SAMLResponse', $(Get-PASSAMLResponse -URL $Uri))

				}

				$LogonRequest['Body'] = $Body
				$LogonRequest['ContentType'] = 'application/x-www-form-urlencoded'
				$LogonRequest['Uri'] = "$Uri/api/auth/SAML/Logon"
				break

			}

			'OAuth' {

				if ($Uri -match 'cyberark.cloud') {
					throw 'New-PASSession (using ParameterSet: OAuth) is only applicable for Self-Hosted Implementations'
				}

				$LogonRequest['Uri'] = $Uri
				break

			}

			( { $PSItem -match '^Gen' } ) {

				if ($BoundParameters.ContainsKey('type')) {
					$type = $BoundParameters['type']
				} else { $type = 'CyberArk' }

				if ($PSItem -match '^Gen2') {
					$LogonRequest['Uri'] = "$Uri/api/Auth/$type/Logon"
				} else {
					$LogonRequest['Uri'] = "$Uri/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logon"
				}

				$Body = $BoundParameters | Get-PASParameter -ParametersToRemove Credential, SkipVersionCheck, SkipCertificateCheck,
				UseDefaultCredentials, CertificateThumbprint, BaseURI, PVWAAppName, OTP, type, OTPMode, OTPDelimiter, RadiusChallenge, Certificate

				if ($BoundParameters.ContainsKey('newPassword')) {

					#Include decoded password in request
					$Body['newPassword'] = $(ConvertTo-InsecureString -SecureString $BoundParameters['newPassword'])

				}

				if ($type -ne 'PKIPN') {

					if ($BoundParameters.ContainsKey('Credential')) {
						$Body['username'] = $($BoundParameters['Credential'].UserName)
						$Body['password'] = $($BoundParameters['Credential'].GetNetworkCredential().Password)
					}

					if ($ParameterSetName -match 'Radius$') {
						$RadiusParameters = $BoundParameters | Get-PASParameter -ParametersToKeep Credential, OTP, OTPMode, OTPDelimiter, RadiusChallenge
						$Body['password'] = (Get-PASRadiusCredential @RadiusParameters).Password
					}

				} else {
					#PKIPN Auth
					$Body['secureMode'] = $true
					$Body['type'] = 'pkipn'
				}

				#Send as raw UTF8 bytes rather than a String so ParameterBinding/module logging of this
				#call records a non-revealing type name instead of the literal request content.
				$LogonRequest['Body'] = [System.Text.Encoding]::UTF8.GetBytes($($Body | ConvertTo-Json))
				break

			}

		}

		$LogonRequest

	}

}
