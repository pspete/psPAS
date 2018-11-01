function Get-PASGroup {
	<#
.SYNOPSIS
List groups from the vault

.DESCRIPTION
Returns a list of all existing user groups.

The user performing this task:
- Must have Audit users permissions in the Vault.
- Can see groups either only on the same level, or lower in the Vault hierarchy.

.PARAMETER filter
Filter according to REST standard.

.PARAMETER search
Search will match when ALL search terms appear in the group name.

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
$token | Get-PASGroup

Returns all existing groups

.EXAMPLE
$token | Get-PASGroup -filter 'groupType eq Directory'

Returns all existing Directory groups

.EXAMPLE
$token | Get-PASGroup -filter 'groupType eq Vault'

Returns all existing Vault groups

.EXAMPLE
$token | Get-PASGroup -search "Vault Admins"

Returns all groups matching all search terms

.EXAMPLE
$token | Get-PASGroup -search "Vault Admins" -filter 'groupType eq Directory'

Returns all existing Directory groups matching all search terms

.INPUTS
All parameters can be piped by property name

.OUTPUTS
psPAS.CyberArk.Vault.Group Object

.NOTES
Minimum Version 10.5

.LINK

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("groupType eq Directory", "groupType eq Vault")]
		[string]$filter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$search,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$sessionToken,

		[parameter(
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
		$MinimumVersion = [System.Version]"10.5"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/API/UserGroups"

		#Get Parameters to include in request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#Create Query String, escaped for inclusion in request URL
		$queryString = ($boundParameters.keys | ForEach-Object {

				"$_=$($boundParameters[$_] | Get-EscapedString)"

			}) -join '&'

		#Build URL from base URL
		$URI = "$URI`?$queryString"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

		if($result) {

			$result.value | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Group -PropertyToAdd @{

				"sessionToken"    = $sessionToken
				"WebSession"      = $WebSession
				"BaseURI"         = $BaseURI
				"PVWAAppName"     = $PVWAAppName
				"ExternalVersion" = $ExternalVersion

			}

		}

	}#process

	END {}#end

}