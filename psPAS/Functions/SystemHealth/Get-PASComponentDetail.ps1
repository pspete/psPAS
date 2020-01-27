Function Get-PASComponentDetail {
	<#
.SYNOPSIS
Returns details & health information about CyberArk component instances.

.DESCRIPTION
Returns details about specific components and all their installed instances,
as well as system health information for each one.

.PARAMETER ComponentID
Specify component type to return information on (PVWA, SessionManagement, CPM or AIM)

.EXAMPLE
Get-PASComponentDetail -ComponentID CPM

Displays CPM Component information

.EXAMPLE
Get-PASComponentDetail -ComponentID PVWA

Displays PVWA Component information

.EXAMPLE
Get-PASComponentDetail -ComponentID SessionManagement

Displays PSM Component information

.INPUTS
All parameters can be piped to the function by propertyname

.OUTPUTS

.NOTES
Requires minimum version of CyberArk 10.1.

.LINK
https://pspas.pspete.dev/commands/Get-PASComponentDetail
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateSet("PVWA", "SessionManagement", "CPM", "AIM")]
		[string]$ComponentID

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.1"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/api/ComponentsMonitoringDetails/$ComponentID"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		if ($result) {

			#output returned data
			$result | Select-Object -ExpandProperty ComponentsDetails

		}

	}#process

	END { }#end
}