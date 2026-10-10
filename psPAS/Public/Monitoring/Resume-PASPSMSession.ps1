# .ExternalHelp psPAS-help.xml
function Resume-PASPSMSession {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('SessionGuid')]
		[string]$LiveSessionId
	)

	begin {
		Assert-VersionRequirement -RequiredVersion 10.2
	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/api/LiveSessions/$($LiveSessionId | Get-EscapedString)/Resume"

		if ($PSCmdlet.ShouldProcess($LiveSessionId, 'Resume PSM Session')) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST

		}

	} #process

	end { }#end

}