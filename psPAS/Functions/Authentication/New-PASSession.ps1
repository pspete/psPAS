﻿function New-PASSession {
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
	If a One Time Passcode is provided against this parameter, New-PASSession will append it to the
	password value sent with the logon request, separated by a comma. (password_value,otp_value).

	.PARAMETER ChallengeAuth
	When using the version 10 API endpoint and type is set to RADIUS, specify the RADIUS challenge authentication.
	Valid values are Password or OTP.
	If Password is specified the first authentication attempt will use the OTP, then during RADIUS challenge the
	password will be used.
	If OTP is specified the first authentication attempt will use the password, then during RADIUS challenge the
	OTP will be used.

	.PARAMETER ChallengeMessage
	When using the version 10 API endpoint and type is set to RADIUS, specify the RADIUS challenge reply-message.
	Valid values are dependent on the reply-message sent by the RADIUS server when in challenge mode.
	See https://tools.ietf.org/html/rfc2865#section-5.18 for more information.

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
		[ValidateSet("Password", "OTP")]
		[string]$ChallengeAuth,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10"
		)]
		[string]$ChallengeMessage,

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
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove Credential, SkipVersionCheck, UseDefaultCredentials, CertificateThumbprint

		If (($PSCmdlet.ParameterSetName -eq "v9") -or ($PSCmdlet.ParameterSetName -eq "v10") ) {

			If ($PSBoundParameters.ContainsKey("Credential")) {

				#Add user name from credential object
				$boundParameters["username"] = $($Credential.UserName)
				#Add decoded password value from credential object
				$boundParameters["password"] = $($Credential.GetNetworkCredential().Password)

				If (($PSBoundParameters.ContainsKey("useRadiusAuthentication")) -or ($type -eq "RADIUS")) {

					If ($PSBoundParameters.ContainsKey("OTP")) {

						If (-not($ChallengeAuth)) {

							$boundParameters["password"] = "$($boundParameters["password"]),$OTP"

						}

						#RADIUS challenge auth
						If ($ChallengeAuth -eq "Password") {
						
							#First authentication will use OTP for request
							$boundParameters["password"] = $OTP

						}

						If ($ChallengeMessage) {

							$LogonRequest["RadiusReplyMessage"] = $ChallengeMessage

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
			$LogonRequest["Body"] = $boundParameters | Get-PASParameter -ParametersToRemove BaseURI, PVWAAppName, OTP, type, ChallengeMessage, ChallengeAuth | ConvertTo-Json

		} Elseif ($PSCmdlet.ParameterSetName -eq "saml") {

			#add token to header
			$LogonRequest["Headers"] = @{"Authorization" = $SAMLToken }

		}

		if ($PSCmdlet.ShouldProcess("$BaseURI/$PVWAAppName", "Logon")) {

			#Send Logon Request
			$PASSession = Invoke-PASRestMethod @LogonRequest

			#If Logon Result
			If ($PASSession) {

				#Version 10
				If ($PASSession.length -ge 180) {

					#V10 Auth Token.

					$CyberArkLogonResult = $PASSession

				}

				#RADIUS challenge auth
				ElseIf ($ChallengeAuth) {

					#Clean up LogonRequest keys for second call of Invoke-PASRestMethod
					If ($LogonRequest.ContainsKey('SessionVariable')) {
						
						$LogonRequest.Remove('SessionVariable')
					
					}

					If ($LogonRequest.ContainsKey('RadiusReplyMessage')) {
						
						$LogonRequest.Remove('RadiusReplyMessage')
					
					}

					#Set password in body of request to challenge auth
					If ($ChallengeAuth -eq "Password") {
						
						$body = $LogonRequest["Body"] | ConvertFrom-Json
						$body.password = $($Credential.GetNetworkCredential().Password)
						$LogonRequest["Body"] = $body | ConvertTo-Json

					}

					ElseIf ($ChallengeAuth -eq "OTP") {

						$body = $LogonRequest["Body"] | ConvertFrom-Json
						$body.password = $OTP
						$LogonRequest["Body"] = $body | ConvertTo-Json

					}

					#Pass original session variable back to Invoke-PASRestMethod
					$LogonRequest["WebSession"] = $Script:WebSession

					#Run Invoke-PASRestMethod again with alternate auth cred
					$PASSession = Invoke-PASRestMethod @LogonRequest

					#If Logon Result
					If ($PASSession) {

						#Version 10
						If ($PASSession.length -ge 180) {

							#V10 Auth Token.

							$CyberArkLogonResult = $PASSession

						}

					}

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
