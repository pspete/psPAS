function Get-PASRequestDetail {
	<#
.SYNOPSIS
Gets requests

.DESCRIPTION
Gets Requests
Officially supported from version 9.10. Reports received that function works in 9.9 also.

.PARAMETER RequestType
Specify whether outgoing or incoming requests will be searched for

.PARAMETER RequestID
The request's uniqueID, composed of the Safe Name and internal RequestID.

.PARAMETER OnlyWaiting
Only requests waiting for approval will be listed

.PARAMETER Expired
Expired requests will be included in the list

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
		[string]$RequestID
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.10"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$Script:BaseURI/API/$($RequestType)/$($RequestID)"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If($result) {

			#Return Results
			$result |

				Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request.Extended

		}

	}#process

	END { }#end

}