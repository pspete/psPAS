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

.EXAMPLE
Get-PASGroup

Returns all existing groups

.EXAMPLE
Get-PASGroup -filter 'groupType eq Directory'

Returns all existing Directory groups

.EXAMPLE
Get-PASGroup -filter 'groupType eq Vault'

Returns all existing Vault groups

.EXAMPLE
Get-PASGroup -search "Vault Admins"

Returns all groups matching all search terms

.EXAMPLE
Get-PASGroup -search "Vault Admins" -filter 'groupType eq Directory'

Returns all existing Directory groups matching all search terms

.INPUTS
All parameters can be piped by property name

.OUTPUTS
psPAS.CyberArk.Vault.Group Object

.NOTES
Minimum Version 10.5

.LINK
https://pspas.pspete.dev/commands/Get-PASGroup
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
		[string]$search
	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.5"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/API/UserGroups"

		#Get Parameters to include in request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#Create Query String, escaped for inclusion in request URL
		$queryString = $boundParameters | ConvertTo-QueryString

		if ($queryString) {

			#Build URL from base URL
			$URI = "$URI`?$queryString"

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		if ($result) {

			$result.value | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Group

		}

	}#process

	END { }#end

}