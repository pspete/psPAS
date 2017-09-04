function Add-PASSafeMember {
	<#
.SYNOPSIS
Adds a Safe Member to safe

.DESCRIPTION
Adds an existing user as a Safe member.
"Manage Safe Members" permission is required by the authenticated user account sending request.

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.PARAMETER SafeName
The name of the safe to add the member to

.PARAMETER MemberName
Vault or Domain User, or Group, to add as member.

.PARAMETER SearchIn
The Vault or Domain, defined in the vault,
in which to search for the member to add to the safe.

.PARAMETER MembershipExpirationDate
Defines when the user’s Safe membership expires.
Specify "" for no expiration date.
Default to no expiration.
Must be in format MM/DD/YY

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

.EXAMPLE
$token | Add-PASSafeMember -SafeName Windows_Safe -MemberName winUser -SearchIn Vault -UseAccounts $true `
-RetrieveAccounts $true -ListAccounts $true

Adds winUser to Windows_Safe with Use, Retrieve & List permissions

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.SafeMemberExtended
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK
#>
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
		[ValidateScript( {$_ -notmatch ".*(\?).*"})]
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
		[ValidateScript( {if($_ -match '^(0[1-9]|1[0-2])[\/](0[1-9]|[12]\d|3[01])[\/]\d{2}$') {
					$true
				} Else {Throw "$_ must match pattern MM/DD/YY"}})]
		[string]$MembershipExpirationDate,

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
		[string]$PVWAAppName = "PasswordVault"
	)

	BEGIN {

		#Set base Parameters the exist at the top level of required JSON object
		$baseParameters = @("MemberName", "SearchIn", "MembershipExpirationDate", "SafeName")

		#Create empty hashtable to hold permission related parameters
		$permissions = @{}

		#array for parameter names which will do not appear in the top-tier of the JSON object
		[array]$keysToRemove += "SafeName"

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Safes/$($SafeName |

            Get-EscapedString)/Members"

		#Get Parameters for request body
		$boundParameters = $PSBoundParameters | Get-PASParameters

		#For every passed permission ("Non-Base") parameter
		$boundParameters.keys | Where-Object {$baseParameters -notcontains $_} | ForEach-Object {

			#Add Key=Value pair to permissions hashtable
			$permissions[$_] = $boundParameters[$_]

			#Add parameter name to array
			$keysToRemove += $_

		}

		#add all required permissions  as value to "Permissions" key
		$boundParameters["Permissions"] = @($permissions.getenumerator() | ForEach-Object {$_})

		#Create required request object
		$body = @{
			"member" = $boundParameters |

			Get-PASParameters -ParametersToRemove $keysToRemove

			#Ensure all required JSON levels are output
		} | ConvertTo-Json -Depth 3

		#Send request to Web Service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

	}#process

	END {

		#format output
		$result.member | Select-Object MemberName, MembershipExpirationDate, SearchIn,

		@{Name = "Permissions"; "Expression" = {

				$_.Permissions | Where-Object {$_.value} | Select-Object -ExpandProperty key}

		} | Add-ObjectDetail -typename psPAS.CyberArk.Vault.SafeMemberExtended -PropertyToAdd @{

			"SafeName"     = $SafeName
			"sessionToken" = $sessionToken
			"WebSession"   = $WebSession
			"BaseURI"      = $BaseURI
			"PVWAAppName"  = $PVWAAppName

		}

	}#end

}