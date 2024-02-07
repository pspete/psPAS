# .ExternalHelp psPAS-help.xml
function Test-PASPSMRecording {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$SessionID
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 11.2
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/Recordings/$SessionID/valid"

		#send request to PAS web service
		Invoke-PASRestMethod -Uri $URI -Method GET

	} #process

	END { }#end

}