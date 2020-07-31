function Get-PASSafeMember {
	<#
.SYNOPSIS
Lists the members of a Safe

.DESCRIPTION
Lists the members of a Safe.
View Safe Members permission is required.

When querying all members of a safe, the permissions are reported as per the following table:

List accounts							    ListContent
Retrieve accounts							Retrieve
Add accounts (includes update properties)	Add
Update account content						Update
Update account properties					UpdateMetadata
Rename accounts							    Rename
Delete accounts							    Delete
View Audit log							    ViewAudit
View Safe Members							ViewMembers
Use accounts								RestrictedRetrieve
Initiate CPM account management operations	<NOT RETURNED>
Specify next account content			    <NOT RETURNED>
Create folders							    AddRenameFolder
Delete folders							    DeleteFolder
Unlock accounts							    Unlock
Move accounts/folders						MoveFilesAndFolders
Manage Safe								    ManageSafe
Manage Safe Members							ManageSafeMembers
Validate Safe Content						ValidateSafeContent
Backup Safe								    BackupSafe
Access Safe without confirmation			<NOT RETURNED>
Authorize account requests (level1, level2)	<NOT RETURNED>

If a Safe Member Name is provided, the full permissions of the member on the Safe will be returned:

List accounts							    ListAccounts
Retrieve accounts							RetrieveAccounts
Add accounts (includes update properties)	AddAccounts
Update account content						UpdateAccountContent
Update account properties					UpdateAccountProperties
Rename accounts							    RenameAccounts
Delete accounts							    DeleteAccounts
View Audit log							    ViewAuditLog
View Safe Members							ViewSafeMembers
Use accounts							    UseAccounts
Initiate CPM account management operations	InitiateCPMAccountManagementOperations
Specify next account content				SpecifyNextAccountContent
Create folders							    CreateFolders
Delete folders							    DeleteFolder
Unlock accounts							    UnlockAccounts
Move accounts/folders						MoveAccountsAndFolders
Manage Safe								    ManageSafe
Manage Safe Members							ManageSafeMembers
Validate Safe Content						<NOT RETURNED>
Backup Safe								    BackupSafe
Access Safe without confirmation			AccessWithoutConfirmation
Authorize account requests (level1, level2)	RequestsAuthorizationLevel

.PARAMETER SafeName
The name of the safe to get the members of

.PARAMETER MemberName
Specify the name of a safe member to return their safe permissions in full.
An empty PUT request (update) is sent to retrieve full safe permissions for a user, as such:
- You cannot report on the permissions of the user authenticated to the API.
- Reporting on the permissions of the Quota Owner is expected to fail.

.EXAMPLE
Get-PASSafeMember -SafeName Target_Safe

Lists all members with permissions on Target_Safe

.EXAMPLE
Get-PASSafeMember -SafeName Target_Safe -MemberName SomeUser

Lists all permissions for member SomeUser on Target_Safe

.INPUTS
All parameters can be piped by property name
Accepts pipeline input from *-PASSafe, or any function which
contains SafeName in the output

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Safe.Member
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.LINK
https://pspas.pspete.dev/commands/Get-PASSafeMember
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
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "MemberPermissions"
		)]
		[ValidateNotNullOrEmpty()]
		[string]$MemberName
	)

	BEGIN {

		$Method = "GET"
		$Request = @{ }

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Safes/$($SafeName |

            Get-EscapedString)/Members"

		#Get full permissions for specific user on safe
		if ($PSCmdlet.ParameterSetName -eq "MemberPermissions") {

			#Create URL for member specific request
			$URI = "$URI/$($MemberName | Get-EscapedString)"
			#Send a PUT Request instead of GET
			$Method = "PUT"
			#Send an empty body
			#Add to Request parameters for PUT Request
			$Request["Body"] = @{"member" = @{ } } | ConvertTo-Json

		}

		#Build Request Parameters
		$Request["URI"] = $URI
		$Request["Method"] = $Method
		$Request["WebSession"] = $Script:WebSession

		#Send request to webservice
		$result = Invoke-PASRestMethod @Request

		If ($null -ne $result) {

			if ($PSCmdlet.ParameterSetName -eq "MemberPermissions") {

				$MemberPermissions = [PSCustomObject]@{ }

				$result.member.Permissions | ForEach-Object {

					$MemberPermissions |
					Add-Member -MemberType NoteProperty -Name $($PSItem |
						Select-Object -ExpandProperty key) -Value $($PSItem |
						Select-Object -ExpandProperty value)

				}

				#format output
				$Output = $result.member | Select-Object MembershipExpirationDate,

				@{Name = "UserName"; "Expression" = {

						$MemberName }

				},

				@{Name = "Permissions"; "Expression" = {

						$MemberPermissions }

				}

			}

			Else {

				#output
				$Output = $result.members | Select-Object UserName, Permissions

			}

			$Output | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe.Member -PropertyToAdd @{

				"SafeName" = $SafeName

			}

		}

	}#process

	END { }#end

}