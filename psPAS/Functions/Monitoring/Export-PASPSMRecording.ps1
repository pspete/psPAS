function Export-PASPSMRecording {
	<#
.SYNOPSIS
Saves a PSM Recording

.DESCRIPTION
Saves a specific recorded session to a file

.PARAMETER RecordingID
Unique ID of the recorded PSM session

.PARAMETER Path
The folder to export the PSM recording to.

.EXAMPLE
Export-PASPSMRecording -RecordingID 123_45 -path C:\PSMRecording.avi

Saves PSM Recording with Id 123_45 to C:\PSMRecording.avi

.NOTES
Minimum CyberArk Version 10.6

.LINK
https://pspas.pspete.dev/commands/Export-PASPSMRecording
#>
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
		$MinimumVersion = [System.Version]"10.6"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$Script:BaseURI/API/Recordings/$($RecordingID | Get-EscapedString)/Play"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

		#if we get a byte array
		if ($result) {

			Out-PASFile -InputObject $result -Path $path

		}

	} #process

	END { }#end

}