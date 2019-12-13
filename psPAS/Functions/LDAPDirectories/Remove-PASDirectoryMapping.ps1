function Remove-PASDirectoryMapping {
	<#
.SYNOPSIS
Removes a configured directory mapping from the Vault

.DESCRIPTION
Removes a directory mapping configuration from the vault.
Membership of the Vault Admins group required.

.PARAMETER DirectoryName
The Name of the directory containing the mapping.

.PARAMETER MappingID
The id of the directory mapping to delete.

.EXAMPLE
Remove-PASDirectoryMapping -DirectoryName SomeDir -MappingID 66

Removes the  directory mapping with id 66 for the SomeDir directory

.INPUTS
WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
LDAP Directory Details
#>
	[CmdletBinding(SupportsShouldProcess = $true)]
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
		[string]$MappingID
	)

	BEGIN {
		$MinimumVersion = [System.Version]"11.1"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/LDAP/Directories/$DirectoryName/Mappings/$MappingID"

		if ($PSCmdlet.ShouldProcess($MappingID, "Delete Directory Mapping")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}