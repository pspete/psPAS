function Resume-PASPSMSession {
	<#
.SYNOPSIS
Resumes a Suspended PSM Session.

.DESCRIPTION
Resumes a suspended, active PSM session, identified by the unique ID of the PSM Session,
allowing a privileged user to continue working.

.PARAMETER LiveSessionId
The unique ID/SessionGuid of a Suspended PSM Session.

.EXAMPLE
Resume-PASPSMSession -LiveSessionId $SessionUUID

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
		[string]$LiveSessionId
	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.2"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$Script:BaseURI/api/LiveSessions/$($LiveSessionId | Get-EscapedString)/Resume"

		if($PSCmdlet.ShouldProcess($LiveSessionId, "Resume PSM Session")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

		}

	} #process

	END {}#end

}