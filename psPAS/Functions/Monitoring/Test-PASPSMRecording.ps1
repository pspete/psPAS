function Test-PASPSMRecording {
	<#
.SYNOPSIS
Determine if a PSM Session / Recording is valid

.DESCRIPTION
Determines if a provided PSM Session / Recording is valid.
Returns $True if valid.

.PARAMETER SessionID
Unique ID of the recorded PSM session

.EXAMPLE
Test-PASPSMRecording -SessionID 334_3

Tests validity of recorded PSM Session File

.NOTES
Minimum CyberArk Version 11.2

.LINK
https://pspas.pspete.dev/commands/Test-PASPSMRecording
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$SessionID
	)

	BEGIN {
		$MinimumVersion = [System.Version]"11.2"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$Script:BaseURI/API/Recordings/$SessionID/valid"

		#send request to PAS web service
		Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

	} #process

	END { }#end

}