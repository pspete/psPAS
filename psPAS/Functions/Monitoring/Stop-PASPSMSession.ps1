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

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.1
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/api/LiveSessions/$($LiveSessionId | Get-EscapedString)/Terminate"

		if ($PSCmdlet.ShouldProcess($LiveSessionId, 'Terminate PSM Session')) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST

		}

	} #process

	END { }#end

}