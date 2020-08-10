function Set-PASDirectoryMappingOrder {
	<#
.SYNOPSIS
Changes the order of directory mappings for a directory

.DESCRIPTION
Updates the order of all a directories mappings.

Requires membership of Vault Admins group  & "Audit users", "Add/Update users" & "Manage Directory mappings" authorizations.
Minimum version 10.10

.PARAMETER DirectoryName
The name of the directory

.PARAMETER MappingsOrder
The MappingID of each directory mapping, in the order they should be applied.

.EXAMPLE
Set-PASDirectoryMappingOrder -DirectoryName "DOMAIN.COM" -MappingsOrder 39,43,41,669,668,667

Sets the order of the directory mappings for directory "DOMAIN.COM"

.LINK
https://pspas.pspete.dev/commands/Set-PASDirectoryMappingOrder
#>

	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$DirectoryName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int[]]$MappingsOrder
	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 10.10

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/LDAP/Directories/$DirectoryName/Mappings/Reorder"

		#Get request parameters
		$body = $($PSBoundParameters | Get-PASParameter -ParametersToRemove DirectoryName) | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($DirectoryName, "Update Directory Mapping Order")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}