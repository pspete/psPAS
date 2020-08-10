function Suspend-PASPSMSession {
	<#
.SYNOPSIS
Suspends a Live PSM Session.

.DESCRIPTION
Suspends a Live PSM session, identified by the unique ID of the PSM Session,
preventing further  interaction in the session until it is resumed by Resume-PASPSMSession.

.PARAMETER LiveSessionId
The unique ID/SessionGuid of a Live PSM Session.

.EXAMPLE
Suspend-PASPSMSession -LiveSessionId $SessionUUID

Terminates Live PSM Session identified by the session UUID.

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None

.NOTES
Minimum CyberArk Version 10.2

.LINK
https://pspas.pspete.dev/commands/Suspend-PASPSMSession
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("SessionGuid")]
		[string]$LiveSessionId
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.2
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$Script:BaseURI/api/LiveSessions/$($LiveSessionId | Get-EscapedString)/Suspend"

		if ($PSCmdlet.ShouldProcess($LiveSessionId, "Suspend PSM Session")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

		}

	} #process

	END { }#end

}