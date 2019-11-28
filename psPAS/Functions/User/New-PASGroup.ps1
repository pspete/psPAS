function New-PASGroup {
	<#
.SYNOPSIS
Creates a vault group.

.DESCRIPTION
Adds a new Vault group.

Requires the following permissions:
- Add Users
- Update Users

.PARAMETER groupName
The name of the group to create

.PARAMETER description
A description for the group

.PARAMETER location
The vault location to create the group in.
Preceeded by "\"

.EXAMPLE
New-PASGroup -groupName SomeNewGroup -description "Some Description" -location \PSP\CyberArk\Groups

Creates SomeNewGroup in the \PSP\CyberArk\Groups vault location

.EXAMPLE
New-PASGroup -groupName VaultGroup -description "Some Description" -location \

Creates VaultGroup in the root vault location
.INPUTS
All parameters can be piped by property name

.OUTPUTS
psPAS.CyberArk.Vault.Group Object

.NOTES
Minimum Version 11.1
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$groupName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$location
	)

	BEGIN {
		$MinimumVersion = [System.Version]"11.1"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/API/UserGroups"

		#Construct Request Body
		$Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		if ($result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Group

		}

	}#process

	END { }#end

}