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

	.PARAMETER newPassword
	Optional parameter, enables you to change a CyberArk users password.
	Must be supplied as a SecureString (Not Plain Text).

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
	One Time Passcode for RADIUS auth.

	.PARAMETER OTPMode
	Specify if OTP is to be sent in either 'Append' (appended to the password) or 'Challenge' mode (sent in response to RADIUS Challenge).
	New-PASSession will append it to the password value sent with the logon request, separated by a comma/delimiter. (password_value,otp_value).

	.PARAMETER OTPDelimiter
	The character to use as a delimiter when appending the OTP to the password. Defaults to comma ",".

	.PARAMETER RadiusChallenge
	Specify if Radius challenge is satisfied by 'OTP' or 'Password'.
	If "Password", then OTP value will be sent first, and Password will be sent as the challenge response.
	If "OTP" (Default), Password will be sent first, with OTP as the challenge response.

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

	.PARAMETER CertificateThumbprint
	See Invoke-WebRequest
	The thumbprint of the certificate to use for client certificate authentication.

	.EXAMPLE
	Logon to Version 10 with LDAP credential:

	New-PASSession -Credential $cred -BaseURI https://PVWA -type LDAP

	.EXAMPLE
	Logon to Version 10 with CyberArk credential:

	New-PASSession -Credential $cred -BaseURI https://PVWA -type CyberArk

	.EXAMPLE
	Logon to Version 10 with Windows Integrated Authentication

	New-PASSession -BaseURI https://PVWA -UseDefaultCredentials

	.EXAMPLE
	Logon to Version 9 with credential:

	New-PASSession -Credential $cred -BaseURI https://PVWA -UseClassicAPI

	Request would be sent to PVWA URL https://PVWA/PasswordVault/

	.EXAMPLE
	Logon to Version 9 where PVWA Virtual Directory has non-default name:

	New-PASSession -Credential $cred -BaseURI https://PVWA -PVWAAppName CustomVault -UseClassicAPI

	Request would be sent to PVWA URL https://PVWA/CustomVault/

	.EXAMPLE
	New-PASSession -UseSharedAuthentication -BaseURI https://PVWA.domain.com

	Gets authorisation token by authenticating to a CyberArk Vault using shared authentication.

	.EXAMPLE
	New-PASSession -SAMLToken $SAMLToken -BaseURI https://PVWA.domain.com

	Authenticates to a CyberArk Vault using SAML authentication.

	.EXAMPLE
	Logon to Version 10 using RADIUS:

	New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS

	.EXAMPLE
	Logon using RADIUS via the Classic API:

	New-PASSession -Credential $cred -BaseURI https://PVWA -useRadiusAuthentication $True

	.EXAMPLE
	Logon to Version 10 using RADIUS & OTP:

	New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS -OTP 123456

	.EXAMPLE
	Logon using RADIUS & OTP via the Classic API:

	New-PASSession -Credential $cred -BaseURI https://PVWA -useRadiusAuthentication $True -OTP 123456

	.EXAMPLE
	Logon to Version 10 using RADIUS & Push Authentication (works with DUO 2FA):

	New-PASSession -Credential $cred -BaseURI https://PVWA -type RADIUS -OTP push

	.EXAMPLE
	If authentication via certificates is configured, provide CertificateThumbprint details.

	New-PASSession -UseSharedAuthentication -BaseURI https://pvwa.some.co -CertificateThumbprint 0e194289c57e666115109d6e2800c24fb7db6edb
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
			ParameterSetName = "v9"
		)]
		[ValidateNotNullOrEmpty()]
		[PSCredential]$Credential,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9"
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
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9"
		)]
		[bool]$useRadiusAuthentication,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10"
		)]
		[ValidateSet("CyberArk", "LDAP", "Windows", "RADIUS")]
		[string]$type = "CyberArk",

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
		[string]$OTP,

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
		[ValidateSet("Append", "Challenge")]
		[string]$OTPMode,

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
		[ValidateLength(1, 1)]
		[string]$OTPDelimiter,

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
		[ValidateSet("Password", "OTP")]
		[string]$RadiusChallenge,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "integrated"
		)]
		[switch]$UseDefaultCredentials,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9"
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
		[string]$CertificateThumbprint

	)

	BEGIN {

		#Hashtable to hold Logon Request
		$LogonRequest = @{ }

		#Define Logon Request Parameters
		$LogonRequest["Method"] = "POST"
		$LogonRequest["SessionVariable"] = "PASSession"
		$LogonRequest["UseDefaultCredentials"] = $UseDefaultCredentials.IsPresent
		If ($CertificateThumbprint) {
			$LogonRequest["CertificateThumbprint"] = $CertificateThumbprint
		}

		Switch ($PSCmdlet.ParameterSetName) {

			"v10" {

				$LogonRequest["Uri"] = "$baseURI/$PVWAAppName/api/Auth/$type/Logon"
				break

			}

			"integrated" {

				$LogonRequest["Uri"] = "$baseURI/$PVWAAppName/api/Auth/Windows/Logon"  #hardcode Windows for integrated auth
				break

			}

			"v9" {

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

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove Credential, SkipVersionCheck,
		UseDefaultCredentials, CertificateThumbprint, BaseURI, PVWAAppName, OTP, type, OTPMode, OTPDelimiter, RadiusChallenge

		If (($PSCmdlet.ParameterSetName -eq "v9") -or ($PSCmdlet.ParameterSetName -eq "v10") ) {

			If ($PSBoundParameters.ContainsKey("Credential")) {

				#Add user name from credential object
				$boundParameters["username"] = $($Credential.UserName)
				#Add decoded password value from credential object
				$boundParameters["password"] = $($Credential.GetNetworkCredential().Password)

				#RADIUS Auth
				If (($PSBoundParameters.ContainsKey("useRadiusAuthentication")) -or ($type -eq "RADIUS")) {

					#OTP in Append Mode
					If (($PSBoundParameters.ContainsKey("OTP")) -and ($PSBoundParameters["OTPMode"] -eq "Append")) {

						If ($PSBoundParameters.ContainsKey("OTPDelimiter")) {

							#Use specified delimiter to append OTP
							$Delimiter = $OTPDelimiter

						} Else {

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

			}

			#deal with newPassword SecureString
			If ($PSBoundParameters.ContainsKey("newPassword")) {

				#Include decoded password in request
				$boundParameters["newPassword"] = $(ConvertTo-InsecureString -SecureString $newPassword)

			}

			#Construct Request Body
			$LogonRequest["Body"] = $boundParameters | ConvertTo-Json

		} Elseif ($PSCmdlet.ParameterSetName -eq "saml") {

			#add token to header
			$LogonRequest["Headers"] = @{"Authorization" = $SAMLToken }

		}

		if ($PSCmdlet.ShouldProcess("$BaseURI/$PVWAAppName", "Logon")) {

			try {

				#Send Logon Request
				$PASSession = Invoke-PASRestMethod @LogonRequest

			} catch {

				if ($PSItem.FullyQualifiedErrorId -notmatch "ITATS542I") {

					#Throw all errors not related to ITATS542I
					throw $PSItem

				} Else {

					#ITATS542I is expected for RADIUS Challenge
					If ((($PSBoundParameters.ContainsKey("useRadiusAuthentication")) -or ($type -eq "RADIUS")) -and ($PSBoundParameters["OTPMode"] -eq "Challenge")) {

						If ($PSBoundParameters.ContainsKey("OTP")) {

							#$OTP as RADIUS response
							#If $RadiusChallenge = Password, $OTP will be password value
							$boundParameters["password"] = $OTP

							#Construct Request Body
							$LogonRequest["Body"] = $boundParameters | ConvertTo-Json

							#Use WebSession from initial request
							$LogonRequest.Remove("SessionVariable")
							$LogonRequest["WebSession"] = $Script:WebSession

							#Respond to RADIUS challenge
							$PASSession = Invoke-PASRestMethod @LogonRequest

						} Else {

							#Throw error if no OTP provided
							throw $PSItem

						}

					} Else {

						#Throw error if not RADIUS authentication
						throw $PSItem

					}

				}

			}

			#If Logon Result
			If ($PASSession) {

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

					} Catch { [System.Version]$Version = "0.0" }

				}

				#Version information available in module scope.
				Set-Variable -Name ExternalVersion -Value $Version -Scope Script

			}

		}

	}#process

	END { }#end

}
