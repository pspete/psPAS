function Set-PASDirectoryMapping {
	<#
.SYNOPSIS
Adds a new Directory Mapping for an existing directory

.DESCRIPTION
Adds an LDAP directory to the Vault.
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
The integer flag representation of the security attributes and authorizations that will be applied when an
LDAP User Account is created in the Vault.
To apply specific authorizations to a mapping, the user must have the same authorizations.
Possible authorizations: AddSafes, AuditUsers, AddUpdateUsers, ResetUsersPasswords, ActivateUsers, AddNetworkAreas,
ManageServerFileCategories, BackupAllSafes, RestoreAllSafes.

.PARAMETER AddUpdateUsers
Specify switch to add the AddUpdateUsers authorization to the directory mapping

.PARAMETER AddSafes
Specify switch to add the AddSafes authorization to the directory mapping

.PARAMETER AddNetworkAreas
Specify switch to add the AddNetworkAreas authorization to the directory mapping

.PARAMETER ManageServerFileCategories
Specify switch to add the ManageServerFileCategories authorization to the directory mapping

.PARAMETER AuditUsers
Specify switch to add the AuditUsers authorization to the directory mapping

.PARAMETER BackupAllSafes
Specify switch to add the BackupAllSafes authorization to the directory mapping

.PARAMETER RestoreAllSafes
Specify switch to add the RestoreAllSafes authorization to the directory mapping

.PARAMETER ResetUsersPasswords
Specify switch to add the ResetUsersPasswords authorization to the directory mapping

.PARAMETER ActivateUsers
Specify switch to add the ActivateUsers authorization to the directory mapping

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
$token | New-PASDirectoryMapping -DirectoryName "domain.com" -LDAPBranch "DC=DOMAIN,DC=COM" -DomainGroups ADGroup -MappingName Map3 -RestoreAllSafes -BackupAllSafes

Creates a new  LDAP directory mapping in the Vault with the following authorizations:
BackupAllSafes, RestoreAllSafes

.EXAMPLE
$token | New-PASDirectoryMapping -DirectoryName "domain.com" -LDAPBranch "DC=DOMAIN,DC=COM" -DomainGroups ADGroup -MappingName Map2 -MappingAuthorizations 1536

Creates a new  LDAP directory mapping in the Vault with the following authorizations:
BackupAllSafes, RestoreAllSafes

.EXAMPLE
$token | New-PASDirectoryMapping -DirectoryName "domain.com" -LDAPBranch "DC=DOMAIN,DC=COM" -DomainGroups ADGroup -MappingName Map1 -MappingAuthorizations 1,3,512

Creates a new  LDAP directory mapping in the Vault with the following authorizations:
AddUpdateUsers, AddSafes, BackupAllSafes

.INPUTS
All parameters can be piped to the function by propertyname

.OUTPUTS

.NOTES

.LINK

#>
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "AuthFlags")]
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
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AuthFlags"
		)]
		[int[]]$MappingAuthorizations,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AuthNames"
		)]
		[switch]$AddUpdateUsers,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AuthNames"
		)]
		[switch]$AddSafes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AuthNames"
		)]
		[switch]$AddNetworkAreas,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AuthNames"
		)]
		[switch]$ManageServerFileCategories,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AuthNames"
		)]
		[switch]$AuditUsers,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AuthNames"
		)]
		[switch]$BackupAllSafes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AuthNames"
		)]

		[switch]$RestoreAllSafes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AuthNames"
		)]
		[switch]$ResetUsersPasswords,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AuthNames"
		)]
		[switch]$ActivateUsers,

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
		$MinimumVersion = [System.Version]"10.7"

		#Enum Flag values for Mapping Authorizations
		[Flags()]enum Authorizations{
			AddUpdateUsers = 1
			AddSafes = 2
			AddNetworkAreas = 4
			ManageServerFileCategories = 16
			AuditUsers = 32
			BackupAllSafes = 512
			RestoreAllSafes = 1024
			ResetUsersPasswords = 8388608
			ActivateUsers = 16777216
		}

	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/api/Configuration/LDAP/Directories/$DirectoryName/Mappings/$MappingID"

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove DirectoryName, MappingID,
		AddUpdateUsers, AddSafes, AddNetworkAreas, ManageServerFileCategories, AuditUsers, BackupAllSafes,
		RestoreAllSafes, ResetUsersPasswords, ActivateUsers

		#If individual authorisations have been specified
		if($PSCmdlet.ParameterSetName -eq "AuthNames") {

			[array]$Authorizations = @()

			#For each bound parameter
			$PSBoundParameters.keys | ForEach-Object {

				#where parameter name is defined in the Authorizations Enum
				if([enum]::IsDefined([Authorizations], "$_")) {

					#Add enum name to array
					$Authorizations = $Authorizations + $_

				}
			}

			#Add enum integer flag as array to MappingAuthorizations request parameter
			$boundParameters["MappingAuthorizations"] = [array][int][Authorizations]$Authorizations

		}

		$body = $boundParameters | ConvertTo-Json

		if($PSCmdlet.ShouldProcess($MappingID, "Update Directory Mapping")) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -Headers $sessionToken -WebSession $WebSession

			If($result) {

				#Return Results
				$result |

				Add-ObjectDetail -typename psPAS.CyberArk.Vault.Directory.Mapping -PropertyToAdd @{

					"sessionToken"    = $sessionToken
					"WebSession"      = $WebSession
					"BaseURI"         = $BaseURI
					"PVWAAppName"     = $PVWAAppName
					"ExternalVersion" = $ExternalVersion

				}

			}

		}

	}#process

	END {}#end
}