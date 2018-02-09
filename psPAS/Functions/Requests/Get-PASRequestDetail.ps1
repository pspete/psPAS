function Get-PASRequestDetail {
	<#
.SYNOPSIS
Gets requests

.DESCRIPTION
Gets Requests

.PARAMETER RequestType
Specify whether outgoing or incoming requests will be searched for

.PARAMETER RequestID
The request's uniqueID, composed of the Safe Name and internal RequestID.

.PARAMETER OnlyWaiting
Only requests waiting for approval will be listed

.PARAMETER Expired
Expired requests will be included in the list

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
Get-PASRequestDetail -RequestType IncomingRequests -RequestID $ID -sessionToken $token.sessiontoken -BaseURI $Url

Gets details of request with ID held in $ID

.INPUTS
All parameters can be piped by property name

.OUTPUTS
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Minimum CyberArk Version 9.10

.LINK

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateSet("MyRequests", "IncomingRequests")]
		[string]$RequestType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$RequestID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$sessionToken,

		[parameter(
			ValueFromPipelinebyPropertyName = $true
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = "PasswordVault"
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$baseURI/$PVWAAppName/API/$($RequestType)/$($RequestID)"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

		If($result) {

			#Return Results
			$result |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request.Extended -PropertyToAdd @{

				"sessionToken" = $sessionToken
				"WebSession"   = $WebSession
				"BaseURI"      = $BaseURI
				"PVWAAppName"  = $PVWAAppName

			}

		}

	}#process

	END {}#end

}