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
		[string]$PVWAAppName = "PasswordVault"
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/api/ComponentsMonitoringDetails/$ComponentID"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

		#output returned data
		$result | Select-Object -ExpandProperty ComponentsDetails

	}#process

	END {}#end
}