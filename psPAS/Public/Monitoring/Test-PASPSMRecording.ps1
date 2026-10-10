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

	begin {
		Assert-VersionRequirement -RequiredVersion 11.2
	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/Recordings/$SessionID/valid"

		#send request to PAS web service
		Invoke-PASRestMethod -Uri $URI -Method GET

	} #process

	end { }#end

}