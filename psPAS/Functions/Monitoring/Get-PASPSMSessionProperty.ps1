function Get-PASPSMSessionProperty {
	<#
.SYNOPSIS
Get property details of PSM Session

.DESCRIPTION
Returns the property details of an active PSM session.

.PARAMETER liveSessionId
The ID of an active session to get properties of.

.EXAMPLE
Get-PASPSMSessionProperty -liveSessionId 123_45

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
		[string]$liveSessionId
	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.6"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/API/LiveSessions/$($liveSessionId | Get-EscapedString)/properties"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $WebSession

		If($result) {

			#Return Results
			$result |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Session.Property

		} #process

	}

	END {}#end

}