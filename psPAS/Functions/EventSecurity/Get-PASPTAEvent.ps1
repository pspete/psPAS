Function Get-PASPTAEvent {
	<#
	.SYNOPSIS
	Returns PTA security events

	.DESCRIPTION
	Returns PTA security events

	.PARAMETER lastUpdatedEventDate
	Parameter description

	.EXAMPLE
Get-PASPTAEvent

	Returns all PTA security events

	.NOTES
	Minimum Version CyberArk 10.3
	#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$lastUpdatedEventDate

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.3"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create request URL
		$URI = "$Script:BaseURI/API/pta/API/Events/"

		$ThisSession = $Script:WebSession

		if ($PSBoundParameters.ContainsKey("lastUpdatedEventDate")) {

			#add Unix Time Stamp of lastUpdatedEventDate to header as key=value pair
			$ThisSession.Headers["lastUpdatedEventDate"] = ($(Get-Date $(Get-Date $lastUpdatedEventDate) -UFormat %s))

		}

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $ThisSession

		If ($result) {

			#Return Results
			$result |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Event

		}

	}#process

	END { }#end

}