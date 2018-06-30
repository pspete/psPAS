Function Get-PASComponentDetail {
	<#
.SYNOPSIS
Returns details & health information about CyberArk component instances.

.DESCRIPTION
Returns details about specific components and all their installed instances,
as well as system health information for each one.

.PARAMETER ComponentID
Specify component type to return information on (PVWA, SessionManagement, CPM or AIM)

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.PARAMETER ExternalVersion
The External CyberArk Version, returned automatically from the New-PASSession function from version 9.7 onwards.
If the minimum version requirement of this function is not satisfied, execution will be halted.
Omitting a value for this parameter, or supplying a version of "0.0" will skip the version check.

.EXAMPLE
$token | Get-PASComponentDetail -ComponentID CPM

Displays CPM Component information

.EXAMPLE
$token | Get-PASComponentDetail -ComponentID PVWA

Displays PVWA Component information

.EXAMPLE
$token | Get-PASComponentDetail -ComponentID SessionManagement

Displays PSM Component information

.INPUTS
All parameters can be piped to the function by propertyname

.OUTPUTS

.NOTES
Requires minimum version of CyberArk 10.1.

.LINK

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateSet("PVWA", "SessionManagement", "CPM", "AIM")]
		[string]$ComponentID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$sessionToken,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = "PasswordVault",

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[System.Version]$ExternalVersion = "0.0"

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.1"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/api/ComponentsMonitoringDetails/$ComponentID"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

		if($result) {

			#output returned data
			$result | Select-Object -ExpandProperty ComponentsDetails

		}

	}#process

	END {}#end
}