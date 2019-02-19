function New-PASSession {
	<#
.SYNOPSIS
Authenticates a user to CyberArk Vault.

.DESCRIPTION
Authenticates a user to a CyberArk Vault and returns a token and a webrequest session object
that can be used in subsequent PAS Web Services calls.
In addition, this method allows you to set a new password.
Authenticate using CyberArk, LDAP or RADIUS authentication (From CyberArk version 9.7 up).
For CyberArk version older than 9.7:
    Only CyberArk Authentication method is supported.
    newPassword Parameter is not supported.
    useRadiusAuthentication Parameter is not supported.
	connectionNumber Parameter is not supported.
Additionally, if using CyberArk 9.7+, this function will return version information from PVWA

.PARAMETER Credential
A Valid PSCredential object.

.PARAMETER UseV9API
Specify the UseV9API to send the authentication request via the v9 API endpoint.

.PARAMETER newPassword
Optional parameter, enables you to change a CyberArk users password.
Must be supplied as a SecureString (Not Plain Text).

.PARAMETER useRadiusAuthentication
Whether or not users will be authenticated via a RADIUS server.

.PARAMETER type
When using the version 10 API endpoint, specify the type of authentication to use.
Valid values are CyberArk, LDAP, Windows or RADIUS
Windows is only a valid option for version 10.4 onward.

.PARAMETER AdditionalInfo
The Version 10 API accepts a string value containing Additional Info

.PARAMETER SecureMode
The Version 10 API accepts a boolean value indicating true or false for SecureMode

.PARAMETER connectionNumber
In order to allow more than one connection for the same user simultaneously, each request
should be sent with different 'connectionNumber'.
Valid values: 1-100

.PARAMETER SkipVersionCheck
If the SkipVersionCheck switch is specified, Get-PASServer will not be called after
successfully authenticating. Get-PASServer is not supported before version 9.7.

.PARAMETER SessionVariable
After successful execution of this function, and authentication to the Vault, a WebSession
object, that contains information about the connection and the request, including cookies,
will be created and passed back in the return object.
This can be passed to subsequent requests to ensure websessions are persistant when the
PAS Web Service exists accross PVWA servers behind a load balancer.

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

.EXAMPLE
Logon to Version 10 with LDAP credential and save auth token:

$token = New-PASSession -Credential $cred -BaseURI https://PVWA -type LDAP

.EXAMPLE
Logon to Version 10 with CyberArk credential:

New-PASSession -Credential $cred -BaseURI https://PVWA -type CyberArk

.EXAMPLE
Logon to Version 10 with Windows Integrated Authentication

New-PASSession -BaseURI https://PVWA -UseDefaultCredentials

.EXAMPLE
Logon to Version 9 with credential and save auth token:

$token = New-PASSession -Credential $cred -BaseURI https://PVWA -UseV9API

Request would be sent to PVWA URL https://PVWA/PasswordVault/

.EXAMPLE
Logon to Version 9 where PVWA Virtual Directory has non-default name:

New-PASSession -Credential $cred -BaseURI https://PVWA -PVWAAppName CustomVault -UseV9API

Request would be sent to PVWA URL https://PVWA/CustomVault/

.INPUTS
A PSCredential Object can be piped to this function.

.OUTPUTS
CyberArk Session token; This token identifies the session with the vault, and
is supplied to every other web service request in the same session.
A WebSession object; This contains information about the connection and the request,
including cookies. Can be supplied to other web service requests.
baseURI; this is the URL provided as an input to this function, it can be piped to
other functions from this return object.
ConnectionNumber; the connectionNumber provided to this function.
ExternalVersion; The External Version number retrieved from CyberArk.

Output uses defined default properties.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK
#>
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "v10")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
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
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v9"
		)]
		[switch]$UseV9API,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ParameterSetName = "v10"
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ParameterSetName = "v9"
		)]
		[SecureString]$newPassword,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ParameterSetName = "v9"
		)]
		[bool]$useRadiusAuthentication,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ParameterSetName = "v10"
		)]
		[ValidateSet("CyberArk", "LDAP", "Windows", "RADIUS")]
		[string]$type = "CyberArk",

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ParameterSetName = "v10"
		)]
		[string]$AdditionalInfo,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ParameterSetName = "v10"
		)]
		[bool]$SecureMode,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ParameterSetName = "v9"
		)]
		[ValidateRange(1, 100)]
		[int]$connectionNumber,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[switch]$SkipVersionCheck,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[string]$SessionVariable = "PASSession",

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[string]$PVWAAppName = "PasswordVault",

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ParameterSetName = "integrated"
		)]
		[switch]$UseDefaultCredentials
	)

	BEGIN {

		#Construct URL for request
		if($($PSCmdlet.ParameterSetName) -eq "v10") {

			$URI = "$baseURI/$PVWAAppName/api/Auth/$type/Logon"

		} elseif($($PSCmdlet.ParameterSetName) -eq "integrated") {

			$URI = "$baseURI/$PVWAAppName/api/Auth/Windows/Logon"  #hardcode Windows for integrated auth

		} elseif($($PSCmdlet.ParameterSetName) -eq "v9") {

			$URI = "$baseURI/$PVWAAppName/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logon"

		}

	}#begin

	PROCESS {

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove Credential, UseV9API, SkipVersionCheck, UseDefaultCredentials

		If($PSBoundParameters.ContainsKey("Credential")) {

			#Add user name from credential object
			$boundParameters["username"] = $($Credential.UserName)
			#Add decoded password value from credential object
			$boundParameters["password"] = $($Credential.GetNetworkCredential().Password)

			$userDisplay = $boundParameters["username"]

		} ElseIf($PSBoundParameters.ContainsKey("UseDefaultCredentials")) {

			$userDisplay = "$env:USERDOMAIN\$env:USERNAME"

		}

		#deal with newPassword SecureString
		If($PSBoundParameters.ContainsKey("newPassword")) {

			#Include decoded password in request
			$boundParameters["newPassword"] = $(ConvertTo-InsecureString -SecureString $newPassword)

		}

		#Construct Request Body
		$body = $boundParameters | ConvertTo-Json

		if($PSCmdlet.ShouldProcess("$baseURI/$PVWAAppName", "Logon with User '$userDisplay'")) {

			#Send Logon Request
			$PASSession = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -SessionVariable $SessionVariable -UseDefaultCredentials:($UseDefaultCredentials.IsPresent)

			#If Logon Result
			If($PASSession) {

				#Format Authentication token
				$SessionToken = @{"Authorization" = [string]$($PASSession.CyberArkLogonResult)}

				#WebSession Object
				$WebSession = $PASSession | Select-Object -ExpandProperty WebSession

				#Initial Value for Version variable
				[System.Version]$Version = "0.0"

				if( -not ($SkipVersionCheck)) {

					Try {

						#Get CyberArk ExternalVersion number, assign to Version variable.
						[System.Version]$Version = Get-PASServer -sessionToken $SessionToken -WebSession $WebSession `
							-BaseURI $BaseURI -PVWAAppName $PVWAAppName -ErrorAction Stop |
							Select-Object -ExpandProperty ExternalVersion

					} Catch {Write-Warning "Could Not Determine CyberArk Version"}

				}

				#Return Object
				[pscustomobject]@{

					#Authentication Token - required for all subsequent Web Service Calls
					"sessionToken"     = $SessionToken

					#WebSession
					"WebSession"       = $WebSession

					#The Web Service URL the request was sent to
					"BaseURI"          = $BaseURI

					#PVWA Application Name/Virtual Directory
					"PVWAAppName"      = $PVWAAppName

					#The Connection Number
					"ConnectionNumber" = $connectionNumber

					#ExternalVersion
					"ExternalVersion"  = $Version

					#Set default properties to display in output
				} | Add-ObjectDetail -DefaultProperties sessionToken, BaseURI

			}

		}

	}#process

	END {}#end

}
