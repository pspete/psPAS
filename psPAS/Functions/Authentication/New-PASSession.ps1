function New-PASSession {
	<#
.SYNOPSIS
Authenticates a user to CyberArk Vault/API.

.DESCRIPTION
Authenticates a user to a CyberArk Vault and stores an authentication token and a webrequest session object
which are used in subsequent calls to the API.
In addition, this method allows you to set a new password.
Will attempt authentication against the V10 API by default.
For older CyberArk versions, specify the -UseClassicAPI switch parameter to force use of the V9 API endpoint.
Windows authentication is only supported (from CyberArk 10.4+).
Authenticate using CyberArk, LDAP, RADIUS, SAML or Shared authentication (From CyberArk version 9.7+),
For CyberArk version older than 9.7:
	Only CyberArk Authentication method is supported.
	newPassword Parameter is not supported.
	useRadiusAuthentication Parameter is not supported.
	connectionNumber Parameter is not supported.

.PARAMETER Credential
A Valid PSCredential object.

.PARAMETER UseClassicAPI
Specify the UseClassicAPI to send the authentication request via the Classic (v9) API endpoint.
Relevant for CyberArk versions earlier than 10.4

.PARAMETER newPassword
Optional parameter, enables you to change a CyberArk users password.
Must be supplied as a SecureString (Not Plain Text).

.PARAMETER SAMLAuth
Supported from 11.4
Specify to authenticate after retrieval of saml token.

.PARAMETER SAMLToken
SAML token that identifies the session, encoded in BASE 64.

.PARAMETER UseSharedAuthentication
Specify the UseSharedAuthentication switch to use the Shared Authentication API endpoint to logon

.PARAMETER useRadiusAuthentication
Whether or not users will be authenticated via a RADIUS server.

.PARAMETER type
When using the version 10 API endpoint, specify the type of authentication to use.
Valid values are CyberArk, LDAP, Windows or RADIUS
Windows is only a valid option for version 10.4 onward.

.PARAMETER OTP
One Time Passcode, if known, for RADIUS authentication.

.PARAMETER OTPMode
Specify if OTP is to be sent in 'Append' (appended to the password) or 'Challenge' mode (sent in response to RADIUS Challenge).

.PARAMETER OTPDelimiter
The character to use as a delimiter when appending the OTP to the password. Defaults to comma ",".

.PARAMETER RadiusChallenge
Specify if Radius challenge is satisfied by 'OTP' or 'Password'.
If "OTP" (Default), Password will be sent first, with OTP as the challenge response.
If "Password", then OTP value will be sent first, and Password will be sent as the challenge response.

.PARAMETER concurrentSession
Enables multiple simultaneous connection sessions as the same user.
Requires 11.3+

.PARAMETER connectionNumber
In order to allow more than one connection for the same user simultaneously, each request
should be sent with different 'connectionNumber'.
Valid values: 1-100

.PARAMETER SkipVersionCheck
If the SkipVersionCheck switch is specified, Get-PASServer will not be called after
successfully authenticating. Get-PASServer is not supported before version 9.7.

.PARAMETER BaseURI
A string containing the base web address to send te request to.
Pass the portion the PVWA HTTP address.
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.PARAMETER UseDefaultCredentials
See Invoke-WebRequest
Uses the credentials of the current user to send the web request

.PARAMETER Certificate
See Invoke-WebRequest
Specifies the client certificate that is used for a secure web request.
Enter a variable that contains a certificate or a command or expression that gets the certificate.

.PARAMETER CertificateThumbprint
See Invoke-WebRequest
The thumbprint of the certificate to use for client certificate authentication.

.PARAMETER SkipCertificateCheck
Skips certificate validation checks.
Using this parameter is not secure and is not recommended.
This switch is only intended to be used against known hosts using a self-signed certificate for testing purposes.
Use at your own risk.

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -type LDAP

Logon to Version 10 with LDAP credential

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -type LDAP -concurrentSession $true

Establish a concurrent session

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -type CyberArk

Logon to Version 10 with CyberArk credential

.EXAMPLE
New-PASSession -BaseURI https://PVWA -UseDefaultCredentials

Logon to Version 10 with Windows Integrated Authentication

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -UseClassicAPI

Logon to Version 9 with credential
Request would be sent to PVWA URL https://PVWA/PasswordVault/

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -PVWAAppName CustomVault -UseClassicAPI

Logon to Version 9 where PVWA Virtual Directory has non-default name
Request would be sent to PVWA URL https://PVWA/CustomVault/

.EXAMPLE
New-PASSession -UseSharedAuthentication -BaseURI https://PVWA.domain.com

Gets authorisation token by authenticating to a CyberArk Vault using shared authentication.

.EXAMPLE
New-PASSession -SAMLToken $SAMLToken -BaseURI https://PVWA.domain.com

Authenticates to a CyberArk Vault using SAML authentication.

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS

Logon to Version 10 using RADIUS

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -useRadiusAuthentication $True

Logon using RADIUS via the Classic API

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS -OTP 123456

Logon to Version 10 using RADIUS (Challenge) & OTP (Response)

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -UseClassicAPI -useRadiusAuthentication $True -OTP 123456 -OTPMode Append

Logon using RADIUS & OTP (Append Mode) via the Classic API

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS -OTP push -OTPMode Append

Logon to Version 10 using RADIUS & Push Authentication (works with DUO 2FA)

.EXAMPLE
New-PASSession -UseSharedAuthentication -BaseURI https://pvwa.some.co -CertificateThumbprint 0e194289c57e666115109d6e2800c24fb7db6edb

If authentication via certificates is configured, provide CertificateThumbprint details.

.EXAMPLE
New-PASSession -Credential $cred -BaseURI $url -SkipCertificateCheck

Skip SSL Certificate validation for the session.

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -type LDAP -Certificate $Certificate

Logon to Version 10 with LDAP credential & Client Certificate

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -type Windows -OTP 123456

Perform initial Windows authentication and satisfy secondary RADIUS challenge

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS -OTP 123456 -RadiusChallenge Password -OTPMode Challenge

For RADIUS, send OTP first and password value as response to challenge.

.EXAMPLE
New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS

Perform initial authentication and supply OTP value for  RADIUS challenge when prompted.

.EXAMPLE
New-PASSession -BaseURI $url -SAMLAuth

Perform saml authentication from version 11.4

.LINK
https://pspas.pspete.dev/commands/New-PASSession
#>
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "v10")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10Radius"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = "v9"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = "v9Radius"
		)]
		[ValidateNotNullOrEmpty()]
		[PSCredential]$Credential,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = "v9Radius"
		)]
		[switch]$UseClassicAPI,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10"
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9"
		)]
		[SecureString]$newPassword,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_3_saml"
		)]
		[switch]$SAMLAuth,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "saml"
		)]
		[String]$SAMLToken,

		[Parameter(
			Mandatory = $True,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "shared"
		)]
		[switch]$UseSharedAuthentication,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9Radius"
		)]
		[bool]$useRadiusAuthentication,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10"
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10Radius"
		)]
		[ValidateSet("CyberArk", "LDAP", "Windows", "RADIUS")]
		[string]$type = "CyberArk",

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10Radius"
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9Radius"
		)]
		[string]$OTP,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10Radius"
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9Radius"
		)]
		[ValidateSet("Append", "Challenge")]
		[string]$OTPMode,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10Radius"
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9Radius"
		)]
		[ValidateLength(1, 1)]
		[string]$OTPDelimiter,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10Radius"
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9Radius"
		)]
		[ValidateSet("Password", "OTP")]
		[string]$RadiusChallenge,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "integrated"
		)]
		[switch]$UseDefaultCredentials,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10Radius"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "integrated"
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_3_saml"
		)]
		[Boolean]$concurrentSession,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9"
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9Radius"
		)]
		[ValidateRange(1, 100)]
		[int]$connectionNumber,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = "PasswordVault",

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[switch]$SkipVersionCheck,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[X509Certificate]$Certificate,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[string]$CertificateThumbprint,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[switch]$SkipCertificateCheck

	)

	BEGIN {

		#Hashtable to hold Logon Request
		$LogonRequest = @{ }

		#Define Logon Request Parameters
		$LogonRequest["Method"] = "POST"
		$LogonRequest["SessionVariable"] = "PASSession"
		$LogonRequest["UseDefaultCredentials"] = $UseDefaultCredentials.IsPresent
		$LogonRequest["SkipCertificateCheck"] = $SkipCertificateCheck.IsPresent

		If ($PSBoundParameters["type"] -eq "Windows") {

			$LogonRequest["Credential"] = $Credential

		}

		If ($CertificateThumbprint) {

			$LogonRequest["CertificateThumbprint"] = $CertificateThumbprint

		}

		If ($Certificate) {

			$LogonRequest["Certificate"] = $Certificate

		}

		Switch -Wildcard ($PSCmdlet.ParameterSetName) {

			"v10*" {

				$LogonRequest["Uri"] = "$baseURI/$PVWAAppName/api/Auth/$type/Logon"
				break

			}

			"11_3_saml" {

				$URI = "$baseURI/$PVWAAppName/api/Auth/SAML/Logon"
				break

			}

			"integrated*" {

				$LogonRequest["Uri"] = "$baseURI/$PVWAAppName/api/Auth/Windows/Logon"  #hardcode Windows for integrated auth
				break

			}

			"v9*" {

				$LogonRequest["Uri"] = "$baseURI/$PVWAAppName/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logon"
				break

			}

			"saml" {

				$LogonRequest["Uri"] = "$baseURI/$PVWAAppName/WebServices/auth/SAML/SAMLAuthenticationService.svc/Logon"
				break

			}

			"shared" {

				$LogonRequest["Uri"] = "$baseURI/$PVWAAppName/WebServices/auth/Shared/RestfulAuthenticationService.svc/Logon"
				break

			}

		}

	}#begin

	PROCESS {

		If (($PSCmdlet.ParameterSetName -match "^v9*") -or ($PSCmdlet.ParameterSetName -match "^v10*") ) {

			#Get request parameters
			$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove Credential, SkipVersionCheck, SkipCertificateCheck,
			UseDefaultCredentials, CertificateThumbprint, BaseURI, PVWAAppName, OTP, type, OTPMode, OTPDelimiter, RadiusChallenge, Certificate

			#Add user name from credential object
			$boundParameters["username"] = $($Credential.UserName)
			#Add decoded password value from credential object
			$boundParameters["password"] = $($Credential.GetNetworkCredential().Password)

			#RADIUS Auth
			If ($PSCmdlet.ParameterSetName -match "Radius$") {

				#OTP in Append Mode
				If (($PSBoundParameters.ContainsKey("OTP")) -and ($PSBoundParameters["OTPMode"] -eq "Append")) {

					If ($PSBoundParameters.ContainsKey("OTPDelimiter")) {

						#Use specified delimiter to append OTP
						$Delimiter = $OTPDelimiter

					}
					Else {

						#delimit with comma by default
						$Delimiter = ","

					}

					#Append OTP to password
					$boundParameters["password"] = "$($boundParameters["password"])$Delimiter$OTP"

				}

				#RADIUS Challenge Mode
				ElseIf (($PSBoundParameters.ContainsKey("OTP")) -and ($PSBoundParameters["OTPMode"] -eq "Challenge")) {

					If ($RadiusChallenge -eq "Password") {

						#Send OTP first + then Password
						$boundParameters["password"] = $OTP
						$OTP = $($Credential.GetNetworkCredential().Password)

					}

				}

			}

			#deal with newPassword SecureString
			If ($PSBoundParameters.ContainsKey("newPassword")) {

				#Include decoded password in request
				$boundParameters["newPassword"] = $(ConvertTo-InsecureString -SecureString $newPassword)

			}

			#Construct Request Body
			$LogonRequest["Body"] = $boundParameters | ConvertTo-Json

		}
		Elseif ($PSCmdlet.ParameterSetName -eq "saml") {

			#add token to header
			$LogonRequest["Headers"] = @{"Authorization" = $SAMLToken }

		}

		if ($PSCmdlet.ShouldProcess("$BaseURI/$PVWAAppName", "Logon")) {

			try {

				If ($PSCmdlet.ParameterSetName -eq "11_3_saml") {

					#The only expected parameter should be concurrentSessions
					$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove SAMLAuth,
					SkipVersionCheck, SkipCertificateCheck, CertificateThumbprint, BaseURI, PVWAAppName, Certificate

					#*For SAML auth:
					#*https://gist.github.com/infamousjoeg/b44faa299ec3de65bdd1d3b8474b0649
					$SAMLResponse = Get-PASSAMLResponse -URL "$baseURI/$PVWAAppName"

					#add required parameters
					$boundParameters.Add("SAMLResponse", $SAMLResponse)
					$boundParameters.Add("apiUse", $true)

					#Create Logon URL
					$LogonString = $boundParameters | ConvertTo-QueryString

					if ($LogonString) {

						#Build URL from base URL
						$URI = "$URI`?$LogonString"

					}

					$LogonRequest["Uri"] = $URI

				}

				#Send Logon Request
				$PASSession = Invoke-PASRestMethod @LogonRequest

				If ($null -ne $PASSession.UserName) {

					#*$PASSession is expected to be a string value
					#*For IIS Windows auth:
					#*An object with a username property can be returned if a secondary authentication is required

					If ($PSCmdlet.ParameterSetName -match "Radius$") {

						#If RADIUS parameters are specified
						#Prepare RADIUS auth request
						$LogonRequest["Uri"] = "$baseURI/$PVWAAppName/api/Auth/RADIUS/Logon"

						#Use WebSession from initial request
						$LogonRequest.Remove("SessionVariable")
						$LogonRequest["WebSession"] = $Script:WebSession

						#Submit initial RADIUS auth request
						$PASSession = Invoke-PASRestMethod @LogonRequest

					}

				}

			}
			catch {

				if ($PSItem.FullyQualifiedErrorId -notmatch "ITATS542I") {

					#Throw all errors not related to ITATS542I
					throw $PSItem

				}
				Else {

					#ITATS542I is expected for RADIUS Challenge

					#OTP value has not yet been provided.
					#Initial RADIUS auth attempt will trigger notification of OTP for user to provide.
					#?"passcode" remains an option for backward compatibility.
					If ((-not ($PSBoundParameters.ContainsKey("OTP"))) -or ($OTP -match "passcode")) {

						#*The message of the exception should contain instructions from the RADIUS server
						#*containing information the expected OTP value to provide or other available options.
						If ($($PSItem.Exception.Message)) {

							$Prompt = $($PSItem.Exception.Message)

						}
						Else {

							#Default value for the Read-Host prompt.
							$Prompt = "Enter OTP"

						}

						#Prompt user for OTP
						$OTP = $(Read-Host -Prompt $Prompt)

					}

					#$OTP as RADIUS response
					#!If $RadiusChallenge = Password, $OTP will be password value
					$boundParameters["password"] = $OTP

					#Construct Request Body
					$LogonRequest["Body"] = $boundParameters | ConvertTo-Json

					#Use WebSession from initial request
					$LogonRequest.Remove("SessionVariable")
					$LogonRequest["WebSession"] = $Script:WebSession

					#Respond to RADIUS challenge
					$PASSession = Invoke-PASRestMethod @LogonRequest

				}

			}
			finally {

				#If Logon Result
				If ($PASSession) {

					If ($null -ne $PASSession.UserName) {

						throw "No Session Token for user $($PASSession.UserName)"

					}

					#Version 10
					If ($PASSession.length -ge 180) {

						#V10 Auth Token.
						$CyberArkLogonResult = $PASSession

					}

					#Shared Auth
					ElseIf ($PASSession.LogonResult) {

						#Shared Auth LogonResult.
						$CyberArkLogonResult = $PASSession.LogonResult


					}

					#Classic
					Else {

						#Classic CyberArkLogonResult
						$CyberArkLogonResult = $PASSession.CyberArkLogonResult

					}

					#?SAML Auth?

					#BaseURI set in Module Scope
					Set-Variable -Name BaseURI -Value "$BaseURI/$PVWAAppName" -Scope Script

					#Auth token added to WebSession
					$Script:WebSession.Headers["Authorization"] = [string]$CyberArkLogonResult

					#Initial Value for Version variable
					[System.Version]$Version = "0.0"

					if ( -not ($SkipVersionCheck)) {

						Try {

							#Get CyberArk ExternalVersion number.
							[System.Version]$Version = Get-PASServer -ErrorAction Stop |
							Select-Object -ExpandProperty ExternalVersion

						}
						Catch { [System.Version]$Version = "0.0" }

					}

					#Version information available in module scope.
					Set-Variable -Name ExternalVersion -Value $Version -Scope Script

				}

			}

		}

	}#process

	END { }#end

}