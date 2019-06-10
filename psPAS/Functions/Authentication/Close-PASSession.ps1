function Close-PASSession {
	<#
.SYNOPSIS
Logoff from CyberArk Vault.

.DESCRIPTION
Performs Logoff and removes the Vault session.

.PARAMETER UseV9API
Specify the UseV9API switch to send the authentication request via the v9 API endpoint.

.EXAMPLE
Close-PASSession

Logs off from the session related to the authorisation token.

.EXAMPLE
Close-PASSession -UseV9API

Logs off from the session related to the authorisation token using the v9 API endpoint.

.INPUTS
All Parameters accept piped values by propertyname

.OUTPUTS
None

.NOTES

.LINK
#>
	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[switch]$UseV9API

	)

	BEGIN {}#begin

	PROCESS {

		If($UseV9API) {

			#Construct URL for request
			$URI = "$Script:BaseURI/$Script:PVWAAppName/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logoff"

		}

		Else {

			#Construct URL for request
			$URI = "$Script:BaseURI/$Script:PVWAAppName/API/Auth/Logoff"

		}

		#Send Logoff Request
		Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $WebSession | Out-Null

	}#process

	END {}#end
}