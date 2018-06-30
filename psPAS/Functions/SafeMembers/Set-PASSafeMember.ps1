function Set-PASSafeMember {
	<#
.SYNOPSIS
Updates a Safe Member

.DESCRIPTION
Updates an existing Safe Member's permissions on a safe.
Manage Safe Members permission is required.

.PARAMETER SafeName
The name of the safe to which the safe member belong

.PARAMETER MemberName
Vault or Domain User, or Group, safe member to update.

.PARAMETER MembershipExpirationDate
Defines when the member's Safe membership expires.

.PARAMETER UseAccounts
Boolean value defining if UseAccounts permission will be granted to
safe member on safe.

.PARAMETER RetrieveAccounts
Boolean value defining if RetrieveAccounts permission will be granted
to safe member on safe.

.PARAMETER ListAccounts
Boolean value defining if ListAccounts permission will be granted to
safe member on safe.

.PARAMETER AddAccounts
Boolean value defining if permission will be granted to safe member
on safe.
Includes UpdateAccountProperties (when adding or removing permission).

.PARAMETER UpdateAccountContent
Boolean value defining if AddAccounts permission will be granted to safe
member on safe.

.PARAMETER UpdateAccountProperties
Boolean value defining if UpdateAccountProperties permission will be granted
to safe member on safe.

.PARAMETER InitiateCPMAccountManagementOperations
Boolean value defining if InitiateCPMAccountManagementOperations permission
will be granted to safe member on safe.

.PARAMETER SpecifyNextAccountContent
Boolean value defining if SpecifyNextAccountContent permission will be granted
to safe member on safe.

.PARAMETER RenameAccounts
Boolean value defining if RenameAccounts permission will be granted to safe
member on safe.

.PARAMETER DeleteAccounts
Boolean value defining if DeleteAccounts permission will be granted to safe
member on safe.

.PARAMETER UnlockAccounts
Boolean value defining if UnlockAccounts permission will be granted to safe
member on safe.

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

.PARAMETER ViewSafeMembers
Boolean value defining if ViewSafeMembers permission will be granted to safe member
on safe.

.PARAMETER RequestsAuthorizationLevel
Integer value defining level assigned to RequestsAuthorizationLevel for safe member.
Valid Values: 0, 1 or 2

.PARAMETER AccessWithoutConfirmation
Boolean value defining if AccessWithoutConfirmation permission will be granted to
safe member on safe.

.PARAMETER CreateFolders
Boolean value defining if CreateFolders permission will be granted to safe member
on safe.

.PARAMETER DeleteFolders
Boolean value defining if DeleteFolders permission will be granted to safe member
on safe.

.PARAMETER MoveAccountsAndFolders
Boolean value defining if MoveAccountsAndFolders permission will be granted to safe
member on safe.

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

.EXAMPLE
$Token | Set-PASSafeMember -SafeName TargetSafe -MemberName TargetUser -AddAccounts $true

Updates TargetUser's permissions as safe member on TargetSafe to include "Add Accounts"

.INPUTS
MemberName, Session Token, SafeName, WebSession & BaseURI can be
piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Safe.Member
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK
#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'keysToRemove', Justification = "False Positive")]
	[CmdletBinding(SupportsShouldProcess)]
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
		[string]$MemberName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$MembershipExpirationDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$UseAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$RetrieveAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$ListAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$AddAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$UpdateAccountContent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
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
		[boolean]$RenameAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$DeleteAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
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
		[boolean]$ViewAuditLog,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
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
		[boolean]$MoveAccountsAndFolders,

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

		#define base parameters that exist at top level of required JSON structure.
		$baseParameters = @("MemberName", "MembershipExpirationDate", "SafeName")

		#create hashtable to hold safe member permission information
		$permissions = @{}

		#Create array of keys to remove from top level of required JSON structure.
		[array]$keysToRemove += "SafeName", "MemberName"

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Safes/$($SafeName |

            Get-EscapedString)/Members/$($MemberName |

                Get-EscapedString)"

		#Get passed parameters to include in request body
		$boundParameters = $PSBoundParameters | Get-PASParameter

		If($PSBoundParameters.ContainsKey("MembershipExpirationDate")) {

			#Convert ExpiryDate to string in Required format
			$Date = (Get-Date $MembershipExpirationDate -Format MM/dd/yyyy).ToString()

			#Include date string in request
			$boundParameters["MembershipExpirationDate"] = $Date

		}

		#For each "Non-Base"/"Permission" parameters
		$boundParameters.keys | Where-Object {$baseParameters -notcontains $_} | ForEach-Object {

			#Add to hash table in key/value pair
			$permissions[$_] = $boundParameters[$_]

			#non-base parameter name
			$keysToRemove += $_

		}

		#Add Permission parameters as value of "Permissions" property
		$boundParameters["Permissions"] = @($permissions.getenumerator() | ForEach-Object {$_})

		#Create JSON for body of request
		$body = @{

			"member" = $boundParameters |

			Get-PASParameter -ParametersToRemove $keysToRemove

			#Ensure all levels of object are output
		} | ConvertTo-Json -Depth 3

		if($PSCmdlet.ShouldProcess($SafeName, "Update Safe Permissions for '$MemberName'")) {

			#Send request to webservice
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -Headers $sessionToken -WebSession $WebSession

			if($result) {

				#format output
				$result.member | Select-Object MembershipExpirationDate,

				@{Name = "Permissions"; "Expression" = {

						$_.Permissions | Where-Object {$_.value} | Select-Object -ExpandProperty key}

				}  | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe.Member -PropertyToAdd @{

					"UserName"        = $MemberName
					"SafeName"        = $SafeName
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
