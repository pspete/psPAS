function Resume-PASPSMSession {
	<#
.SYNOPSIS
Resumes a Suspended PSM Session.

.DESCRIPTION
Resumes a Suspended PSM Session identified by the unique ID of the PSM Session.

.PARAMETER LiveSessionId
The unique ID/SessionGuid of a Suspended PSM Session.

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
$token | Resume-PASPSMSession -LiveSessionId $SessionUUID

Terminates Live PSM Session identified by the session UUID.

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None

.NOTES
Minimum CyberArk Version 10.2

.LINK

#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("SessionGuid")]
		[string]$LiveSessionId,

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
		$URI = "$baseURI/$PVWAAppName/api/LiveSessions/$($LiveSessionId | Get-EscapedString)/Resume"

		if($PSCmdlet.ShouldProcess($LiveSessionId, "Resume PSM Session")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Headers $sessionToken -WebSession $WebSession

		}

	} #process

	END {}#end

}