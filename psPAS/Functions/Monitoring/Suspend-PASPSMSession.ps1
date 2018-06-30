function Suspend-PASPSMSession {
	<#
.SYNOPSIS
Suspends a Live PSM Session.

.DESCRIPTION
Suspends a Live PSM session, identified by the unique ID of the PSM Session,
preventing further  interaction in the session until it is resumed by Resume-PASPSMSession.

.PARAMETER LiveSessionId
The unique ID/SessionGuid of a Live PSM Session.

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

.PARAMETER ExternalVersion
The External CyberArk Version, returned automatically from the New-PASSession function from version 9.7 onwards.
If the minimum version requirement of this function is not satisfied, execution will be halted.
Omitting a value for this parameter, or supplying a version of "0.0" will skip the version check.

.EXAMPLE
$token | Suspend-PASPSMSession -LiveSessionId $SessionUUID

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
		[string]$PVWAAppName = "PasswordVault",

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[System.Version]$ExternalVersion = "0.0"

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.2"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$baseURI/$PVWAAppName/api/LiveSessions/$($LiveSessionId | Get-EscapedString)/Suspend"

		if($PSCmdlet.ShouldProcess($LiveSessionId, "Suspend PSM Session")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Headers $sessionToken -WebSession $WebSession

		}

	} #process

	END {}#end

}