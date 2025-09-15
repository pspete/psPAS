# .ExternalHelp psPAS-help.xml
function Stop-PASPSMSession {
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
		Assert-VersionRequirement -RequiredVersion 10.1
	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/api/LiveSessions/$($LiveSessionId | Get-EscapedString)/Terminate"

		if ($PSCmdlet.ShouldProcess($LiveSessionId, 'Terminate PSM Session')) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST

		}

	} #process

	end { }#end

}