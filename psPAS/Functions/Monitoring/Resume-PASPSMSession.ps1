# .ExternalHelp psPAS-help.xml
function Resume-PASPSMSession {
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
		$URI = "$Script:BaseURI/api/LiveSessions/$($LiveSessionId | Get-EscapedString)/Resume"

		if ($PSCmdlet.ShouldProcess($LiveSessionId, "Resume PSM Session")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

		}

	} #process

	END { }#end

}