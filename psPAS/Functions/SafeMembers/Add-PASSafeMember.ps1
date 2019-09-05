function Add-PASSafeMember {
	<#
.SYNOPSIS
Adds a Safe Member to safe

.DESCRIPTION
Adds an existing user as a Safe member.
"Manage Safe Members" permission is required by the authenticated user account sending request.

Unless otherwise specified, the default permissions applied to a safe member will include:
ListAccounts, RetrieveAccounts, UseAccounts, ViewAuditLog & ViewSafeMembers.
If these permissions should not be granted to the safe member, they must be explicitly set to $false in the request.

.PARAMETER SafeName
The name of the safe to add the member to

.PARAMETER MemberName
Vault or Domain User, or Group, to add as member.
Must not contain '&' (ampersand).

.PARAMETER SearchIn
The Vault or Domain, defined in the vault,
in which to search for the member to add to the safe.

.PARAMETER MembershipExpirationDate
Defines when the user's Safe membership expires.

.PARAMETER UseAccounts
Boolean value defining if UseAccounts permission will be granted to
safe member on safe.
Get-PASSafeMember returns the name of this permission as: RestrictedRetrieve

.PARAMETER RetrieveAccounts
Boolean value defining if RetrieveAccounts permission will be granted
to safe member on safe.
Get-PASSafeMember returns the name of this permission as: Retrieve

.PARAMETER ListAccounts
Boolean value defining if ListAccounts permission will be granted to
safe member on safe.
Get-PASSafeMember returns the name of this permission as: ListContent

.PARAMETER AddAccounts
Boolean value defining if permission will be granted to safe member
on safe.
Includes UpdateAccountProperties (when adding or removing permission).
Get-PASSafeMember returns the name of this permission as: Add

.PARAMETER UpdateAccountContent
Boolean value defining if AddAccounts permission will be granted to safe
member on safe.
Get-PASSafeMember returns the name of this permission as: Update

.PARAMETER UpdateAccountProperties
Boolean value defining if UpdateAccountProperties permission will be granted
to safe member on safe.
Get-PASSafeMember returns the name of this permission as: UpdateMetadata

.PARAMETER InitiateCPMAccountManagementOperations
Boolean value defining if InitiateCPMAccountManagementOperations permission
will be granted to safe member on safe.
Get-PASSafeMember may not return details of this permission

.PARAMETER SpecifyNextAccountContent
Boolean value defining if SpecifyNextAccountContent permission will be granted
to safe member on safe.
Get-PASSafeMember may not return details of this permission

.PARAMETER RenameAccounts
Boolean value defining if RenameAccounts permission will be granted to safe
member on safe.
Get-PASSafeMember returns the name of this permission as: Rename

.PARAMETER DeleteAccounts
Boolean value defining if DeleteAccounts permission will be granted to safe
member on safe.
Get-PASSafeMember returns the name of this permission as: Delete

.PARAMETER UnlockAccounts
Boolean value defining if UnlockAccounts permission will be granted to safe
member on safe.
Get-PASSafeMember returns the name of this permission as: Unlock

.PARAMETER ManageSafe
Boolean value defining if ManageSafe permission will be granted to safe member
on safe.

.PARAMETER ManageSafeMembers
Boolean value defining if ManageSafeMembers permission will be granted to safe
member on safe.

.PARAMETER BackupSafe
Boolean value defining if BackupSafe permission will be granted to safe member
on safe.

.PARAMETER ViewAuditLog
Boolean value defining if ViewAuditLog permission will be granted to safe member
on safe.
Get-PASSafeMember returns the name of this permission as: ViewAudit

.PARAMETER ViewSafeMembers
Boolean value defining if ViewSafeMembers permission will be granted to safe member
on safe.
Get-PASSafeMember returns the name of this permission as: ViewMembers

.PARAMETER RequestsAuthorizationLevel
Integer value defining level assigned to RequestsAuthorizationLevel for safe member.
Valid Values: 0, 1 or 2
Get-PASSafeMember may not return details of this permission

.PARAMETER AccessWithoutConfirmation
Boolean value defining if AccessWithoutConfirmation permission will be granted to
safe member on safe.
Get-PASSafeMember may not return details of this permission

.PARAMETER CreateFolders
Boolean value defining if CreateFolders permission will be granted to safe member
on safe.
Get-PASSafeMember returns the name of this permission as: AddRenameFolder

.PARAMETER DeleteFolders
Boolean value defining if DeleteFolders permission will be granted to safe member
on safe.

.PARAMETER MoveAccountsAndFolders
Boolean value defining if MoveAccountsAndFolders permission will be granted to safe
member on safe.
Get-PASSafeMember returns the name of this permission as: MoveFilesAndFolders

.EXAMPLE
Add-PASSafeMember -SafeName Windows_Safe -MemberName winUser -SearchIn Vault -UseAccounts $true `
-RetrieveAccounts $true -ListAccounts $true

Adds winUser to Windows_Safe with Use, Retrieve & List permissions

.EXAMPLE
$Role = [PSCustomObject]@{
  UseAccounts                            = $true
  ListAccounts                           = $true
  RetrieveAccounts						 = $true
  ViewAuditLog                           = $false
  ViewSafeMembers                        = $false
}

PS > $Role | Add-PASSafeMember -SafeName NewSafe -MemberName User23 -SearchIn Vault

Grant User23 UseAccounts, RetrieveAccounts & ListAccounts only

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Safe.Member.Extended
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *
#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'keysToRemove', Justification = "False Positive")]
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$SafeName,

		[Alias("UserName")]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { $_ -notmatch ".*(\?|\&).*" })]
		[string]$MemberName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$SearchIn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$MembershipExpirationDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("RestrictedRetrieve")]
		[boolean]$UseAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("Retrieve")]
		[boolean]$RetrieveAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("ListContent")]
		[boolean]$ListAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("Add")]
		[boolean]$AddAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("Update")]
		[boolean]$UpdateAccountContent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("UpdateMetadata")]
		[boolean]$UpdateAccountProperties,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "CPM"
		)]
		[boolean]$InitiateCPMAccountManagementOperations,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "CPM"
		)]
		[boolean]$SpecifyNextAccountContent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("Rename")]
		[boolean]$RenameAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("Delete")]
		[boolean]$DeleteAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("Unlock")]
		[boolean]$UnlockAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$ManageSafe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$ManageSafeMembers,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$BackupSafe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("ViewAudit")]
		[boolean]$ViewAuditLog,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("ViewMembers")]
		[boolean]$ViewSafeMembers,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateRange(0, 2)]
		[int]$RequestsAuthorizationLevel,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$AccessWithoutConfirmation,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("AddRenameFolder")]
		[boolean]$CreateFolders,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$DeleteFolders,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("MoveFilesAndFolders")]
		[boolean]$MoveAccountsAndFolders
	)

	BEGIN {

		#Set base Parameters the exist at the top level of required JSON object
		$baseParameters = @("MemberName", "SearchIn", "MembershipExpirationDate", "SafeName")

		#Create empty hashtable to hold permission related parameters
		$permissions = @{ }

		#array for parameter names which will do not appear in the top-tier of the JSON object
		[array]$keysToRemove += "SafeName"

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Safes/$($SafeName |

            Get-EscapedString)/Members"

		#Get Parameters for request body
		$boundParameters = $PSBoundParameters | Get-PASParameter

		If ($PSBoundParameters.ContainsKey("MembershipExpirationDate")) {

			#Convert MembershipExpirationDate to string in Required format
			$Date = (Get-Date $MembershipExpirationDate -Format MM/dd/yyyy).ToString()

			#Include date string in request
			$boundParameters["MembershipExpirationDate"] = $Date

		}

		#For every passed permission ("Non-Base") parameter
		$boundParameters.keys | Where-Object { $baseParameters -notcontains $_ } | ForEach-Object {

			#Add Key=Value pair to permissions hashtable
			$permissions[$_] = $boundParameters[$_]

			#Add parameter name to array
			$keysToRemove += $_

		}

		#add all required permissions  as value to "Permissions" key
		$boundParameters["Permissions"] = @($permissions.getenumerator() | ForEach-Object { $_ })

		#Create required request object
		$body = @{
			"member" = $boundParameters |

			Get-PASParameter -ParametersToRemove $keysToRemove

			#Ensure all required JSON levels are output
		} | ConvertTo-Json -Depth 3

		#Send request to Web Service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession


		if ($result) {

			#format output
			$result.member | Select-Object MemberName, MembershipExpirationDate, SearchIn,

			@{Name = "Permissions"; "Expression" = {

					$_.Permissions | Where-Object { $_.value } | Select-Object -ExpandProperty key }

			} | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe.Member.Extended -PropertyToAdd @{

				"SafeName" = $SafeName

			}

		}

	}#process

	END { }#end

}