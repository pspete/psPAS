function Set-PASDirectoryMapping {
	<#
.SYNOPSIS
Updates an existing Directory Mapping for a directory

.DESCRIPTION
Updates a  directory mapping.
Membership of the Vault Admins group required.

.PARAMETER DirectoryName
The name of the directory the mapping is for.

.PARAMETER MappingID
The ID of the Directory Mapping to Update

.PARAMETER MappingName
The name of the PAS role that will be created.

.PARAMETER LDAPBranch
The LDAP branch that will be used for external directory queries

.PARAMETER DomainGroups
Users who belong to these LDAP groups will be automatically assigned to the relevant roles in the PAS system.

.PARAMETER VaultGroups
A list of Vault groups that a mapped user will be added to.

.PARAMETER Location
The path of the Vault location that mapped users are added under.
This value cannot be updated.

.PARAMETER LDAPQuery
Match LDAP query results to mapping

.PARAMETER MappingAuthorizations
Specify authorizations that will be applied when an LDAP User Account is created in the Vault.
To apply specific authorizations to a mapping, the user must have the same authorizations.
Possible authorizations: AddSafes, AuditUsers, AddUpdateUsers, ResetUsersPasswords, ActivateUsers,
AddNetworkAreas, ManageServerFileCategories, BackupAllSafes, RestoreAllSafes.

.PARAMETER UserActivityLogPeriod
Retention period in days for user activity logs
Requires CyberArk version 10.10+

.EXAMPLE
Get-PASDirectoryMapping -DirectoryName $Directory -MappingID $ID |
Set-PASDirectoryMapping -DirectoryName $Directory -MappingAuthorizations AddUpdateUsers, AuditUsers

Configures the AddUpdateUsers & AuditUsers authorisations on the mapping.

.EXAMPLE
Set-PASDirectoryMapping -DirectoryName $DirectoryName -MappingID $MappingID -MappingName $MappingName -LDAPBranch $LDAPBranch `
-MappingAuthorizations AddUpdateUsers, ActivateUsers & ResetUsersPasswords

Sets AddUpdateUsers, ActivateUsers & ResetUsersPasswords authorisations on the directory mapping

.EXAMPLE
Set-PASDirectoryMapping -DirectoryName $DirectoryName -MappingID $MappingID -MappingName $MappingName -LDAPBranch $LDAPBranch `
-UserActivityLogPeriod 365

Sets UserActivityLogPeriod for the mapping to 365

.INPUTS
All parameters can be piped to the function by propertyname

.LINK
https://pspas.pspete.dev/commands/Set-PASDirectoryMapping
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
		[ValidateLength(1, 28)]
		[string]$MappingID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$MappingName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$LDAPBranch,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string[]]$DomainGroups,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string[]]$VaultGroups,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Location,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$LDAPQuery,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[Authorizations]$MappingAuthorizations,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateRange(1, 3650)]
		[int]$UserActivityLogPeriod

	)

	BEGIN {

		$MinimumVersion = [System.Version]"10.7"
		$RequiredVersion = [System.Version]"10.10"

	}#begin

	PROCESS {

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove DirectoryName, MappingID, MappingAuthorizations

		#Ensure minimum required version is being used.
		switch ($PSBoundParameters.Keys) {

			'MappingAuthorizations' {

				#Transform MappingAuthorizations
				$boundParameters.Add("MappingAuthorizations", [array][int]$MappingAuthorizations)
				Continue

			}

			'UserActivityLogPeriod' {

				#v10.10
				Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $RequiredVersion
				Continue

			}

			Default {

				#10.7 functionality
				Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

			}

		}

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/LDAP/Directories/$DirectoryName/Mappings/$MappingID"

		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($MappingID, "Update Directory Mapping")) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -WebSession $Script:WebSession

			If ($null -ne $result) {

				#Return Results
				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Directory.Mapping

			}

		}

	}#process

	END { }#end
}