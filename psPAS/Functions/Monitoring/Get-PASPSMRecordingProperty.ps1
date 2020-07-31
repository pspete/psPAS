function Get-PASPSMRecordingProperty {
	<#
.SYNOPSIS
Get property details of PSM Recordings

.DESCRIPTION
Returns the property details of a recorded session.

.PARAMETER RecordingID
Unique ID of the recorded PSM session

.EXAMPLE
Get-PASPSMRecordingProperty -RecordingID 123_45

Returns details of activities in PSM Recording with Id 123_45

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Minimum CyberArk Version 10.6

.LINK
https://pspas.pspete.dev/commands/Get-PASPSMRecordingProperty
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("SessionID")]
		[string]$RecordingID
	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.6"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$Script:BaseURI/API/Recordings/$($RecordingID | Get-EscapedString)/properties"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Recording.Property

		} #process

	}

	END { }#end

}