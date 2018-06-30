Function Get-PASComponentSummary {
	<#
.SYNOPSIS
Returns consolidated information about CyberArk Components.

.DESCRIPTION
Returns consolidated information about the Vault, PVWA, CPM, PSM/PSMP and AIM.
Includes all clients that are relevant to each specific component.

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
$token | Get-PASComponentSummary

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
		$URI = "$baseURI/$PVWAAppName/api/ComponentsMonitoringSummary"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

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