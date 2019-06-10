Function Get-PASComponentSummary {
	<#
.SYNOPSIS
Returns consolidated information about CyberArk Components.

.DESCRIPTION
Returns consolidated information about the Vault, PVWA, CPM, PSM/PSMP and AIM.
Includes all clients that are relevant to each specific component.

.EXAMPLE
Get-PASComponentSummary

Displays CyberArk Component information

.INPUTS
All parameters can be piped to the function by propertyname

.OUTPUTS

.NOTES
Requires minimum version of CyberArk 10.1.

.LINK

#>
	[CmdletBinding()]
	param(

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.1"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/api/ComponentsMonitoringSummary"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $WebSession

		if($result) {

			$result | Select-Object -ExpandProperty Components

			$result | Select-Object -ExpandProperty Vaults | Add-ObjectDetail -PropertyToAdd @{
				"ComponentID"   = "EPV"
				"ComponentName" = "EPV"
			} | Select-Object ComponentID, ComponentName, Role, IP, IsLoggedOn

		}

	}#process

	END {}#end
}