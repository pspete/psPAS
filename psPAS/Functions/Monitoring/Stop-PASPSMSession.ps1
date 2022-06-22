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
		$URI = "$Script:BaseURI/api/LiveSessions/$($LiveSessionId | Get-EscapedString)/Terminate"

		if ($PSCmdlet.ShouldProcess($LiveSessionId, 'Terminate PSM Session')) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

		}

	} #process

	END { }#end

}