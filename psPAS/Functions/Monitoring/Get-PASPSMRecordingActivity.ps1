function Get-PASPSMRecordingActivity {
	<#
.SYNOPSIS
Get activity details of PSM Recordings

.DESCRIPTION
Returns activity details of a PSM recording.

.PARAMETER RecordingID
Unique ID of the recorded PSM session

.EXAMPLE
Get-PASPSMRecordingActivity -RecordingID 123_45

Returns details of activities in PSM Recording with Id 123_45

.INPUTS
All parameters can be piped by property name

.OUTPUTS
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Minimum CyberArk Version 10.6

.LINK

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
		$URI = "$Script:BaseURI/$Script:PVWAAppName/API/Recordings/$($RecordingID | Get-EscapedString)/activities"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $WebSession

		If($result) {

			#Return Results
			$result.Activities |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Recording.Activity

		} #process

	}

	END {}#end

}