# .ExternalHelp psPAS-help.xml
function Export-PASPSMRecording {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$RecordingID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { Test-Path -Path $_ -IsValid })]
		[string]$path
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.6
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/Recordings/$($RecordingID | Get-EscapedString)/Play"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST

		#if we get a byte array
		If ($null -ne $result) {

			Out-PASFile -InputObject $result -Path $path

		}

	} #process

	END { }#end

}