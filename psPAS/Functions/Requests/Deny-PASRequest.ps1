function Deny-PASRequest {
	<#
.SYNOPSIS
Reject a single request

.DESCRIPTION
Enables a request confirmer to reject a single request, identified by its requestID.

.PARAMETER RequestId
The ID of the request to confirm

.PARAMETER reason
The reason why the request is approved

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
$token | Deny-PASRequest -RequestID <ID> - Reason "<Reason>"

Denies request <ID>

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None

.NOTES
Minimum CyberArk Version 9.10

.LINK

#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$RequestId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Reason,

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
		$URI = "$baseURI/$PVWAAppName/API/IncomingRequests/$($RequestID)/Reject"

		#Create body of request
		$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove RequestId | ConvertTo-Json

		if($PSCmdlet.ShouldProcess($RequestId, "Reject Request for Account Access")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

		}

	}#process

	END {}#end

}