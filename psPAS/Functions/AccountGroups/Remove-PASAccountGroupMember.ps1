function Remove-PASAccountGroupMember {
	<#
.SYNOPSIS
Deletes a member of an account group.

.DESCRIPTION
Removes an account member from an account group.
This account can be either a password account or an SSH Key account.
The following permissions are required on the safe:
 - Add Accounts
 - Update Account Content
 - Update Account Properties
  -Create Folders

.PARAMETER AccountID
The unique ID of the account group.

.PARAMETER GroupID
The unique ID of the account group.

.EXAMPLE
Remove-PASAccountGroupMember -AccountID 21_7 -GroupID 21_9

Removes member with ID of 21_& from account group with ID of 21_9

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None

.NOTES
Minimum CyberArk version 9.10

.LINK
https://pspas.pspete.dev/commands/Remove-PASAccountGroupMember
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$AccountID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$GroupID
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$Script:BaseURI/API/AccountGroups/$GroupID/Members/$AccountID"

		if ($PSCmdlet.ShouldProcess($AccountID, "Delete Member from Account Group $($GroupID)")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}