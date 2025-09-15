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

	begin {
		Assert-VersionRequirement -RequiredVersion 10.6
	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/Recordings/$($RecordingID | Get-EscapedString)/Play"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST

		#if we get a byte array
		if ($null -ne $result) {

			Out-PASFile -InputObject $result -Path $path

		}

	} #process

	end { }#end

}