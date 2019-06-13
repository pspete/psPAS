function Get-PASPSMSessionActivity {
	<#
.SYNOPSIS
Get activity details of Live PSM Sessions

.DESCRIPTION
Returns activity details of active PSM sessions.

.PARAMETER liveSessionId
The ID of an active session to get activities from.

.EXAMPLE
Get-PASPSMSessionActivity -liveSessionId 123_45

Returns details of activities in active PSM Session with Id 123_45

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
		[string]$liveSessionId
	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.6"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$Script:BaseURI/API/LiveSessions/$($LiveSessionId | Get-EscapedString)/activities"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If($result) {

			#Return Results
			$result.Activities |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Session.Activity

		} #process

	}

	END {}#end

}