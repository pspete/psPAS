function New-PASDirectoryMapping {
	<#
.SYNOPSIS
Adds a new Directory Mapping for an existing directory

.DESCRIPTION
Adds a directory mapping.
Membership of the Vault Admins group required.

.PARAMETER DirectoryName
The name of the directory the mapping is for.

.PARAMETER MappingName
The name of the PAS role that will be created.

.PARAMETER LDAPBranch
The LDAP branch that will be used for external directory queries

.PARAMETER DomainGroups
Users who belong to these LDAP groups will be automatically assigned to the relevant roles in the PAS system.

.PARAMETER VaultGroups
A list of Vault groups that a mapped user will be added to.
Requires CyberArk version 10.7+

.PARAMETER Location
The path of the Vault location that mapped users are added under.
This value cannot be updated.
Requires CyberArk version 10.7+

.PARAMETER LDAPQuery
Match LDAP query results to mapping
Requires CyberArk version 10.7+

.PARAMETER MappingAuthorizations
Specify authorizations that will be applied when an LDAP User Account is created in the Vault.
To apply specific authorizations to a mapping, the user must have the same authorizations.
Possible authorizations: AddSafes, AuditUsers, AddUpdateUsers, ResetUsersPasswords, ActivateUsers,
AddNetworkAreas, ManageServerFileCategories, BackupAllSafes, RestoreAllSafes.

.PARAMETER UserActivityLogPeriod
Retention period in days for user activity logs
Requires CyberArk version 10.10+

.EXAMPLE
New-PASDirectoryMapping -DirectoryName "domain.com" -LDAPBranch "DC=DOMAIN,DC=COM" -DomainGroups ADGroup -MappingName Map3 -MappingAuthorizations RestoreAllSafes, BackupAllSafes

Creates a new  LDAP directory mapping in the Vault with the following authorizations:
BackupAllSafes, RestoreAllSafes

.EXAMPLE
New-PASDirectoryMapping -DirectoryName "domain.com" -LDAPBranch "DC=DOMAIN,DC=COM" -DomainGroups ADGroup -MappingName Map2 -MappingAuthorizations BackupAllSafes, RestoreAllSafes

Creates a new  LDAP directory mapping in the Vault with the following authorizations:
BackupAllSafes, RestoreAllSafes

.EXAMPLE
New-PASDirectoryMapping -DirectoryName "domain.com" -LDAPBranch "DC=DOMAIN,DC=COM" -DomainGroups ADGroup -MappingName Map1 -MappingAuthorizations AddUpdateUsers, AddSafes, BackupAllSafes

Creates a new  LDAP directory mapping in the Vault with the following authorizations:
AddUpdateUsers, AddSafes, BackupAllSafes

.INPUTS
All parameters can be piped to the function by propertyname


.LINK
https://pspas.pspete.dev/commands/New-PASDirectoryMapping
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
		[string]$MappingName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$LDAPBranch,

		[parameter(
			Mandatory = $true,
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
			ValueFromPipelinebyPropertyName = $true
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

	}#begin

	PROCESS {

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove DirectoryName, MappingAuthorizations

		#Ensure minimum required version is being used.
		switch ($PSBoundParameters.Keys) {

			'MappingAuthorizations' {

				#Transform MappingAuthorizations
				$boundParameters.Add("MappingAuthorizations", [array][int]$MappingAuthorizations)
				Continue

			}

			'UserActivityLogPeriod' {

				#v10.10
				Assert-VersionRequirement -RequiredVersion 10.10
				Continue

			}

			{ $_ -match "VaultGroups|Location|LDAPQuery" } {

				#v10.7
				Assert-VersionRequirement -RequiredVersion 10.7
				Continue

			}

			Default {

				#v10.4
				Assert-VersionRequirement -RequiredVersion 10.4

			}

		}

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/LDAP/Directories/$DirectoryName/Mappings"

		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($MappingName, "Create Directory Mapping")) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

			If ($null -ne $result) {

				#Return Results
				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Directory.Mapping

			}

		}

	}#process

	END { }#end

}