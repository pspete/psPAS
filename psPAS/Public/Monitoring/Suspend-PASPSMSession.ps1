# .ExternalHelp psPAS-help.xml
function Suspend-PASPSMSession {
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
		$URI = "$($psPASSession.BaseURI)/api/LiveSessions/$($LiveSessionId | Get-EscapedString)/Suspend"

		if ($PSCmdlet.ShouldProcess($LiveSessionId, 'Suspend PSM Session')) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST

		}

	} #process

	end { }#end

}