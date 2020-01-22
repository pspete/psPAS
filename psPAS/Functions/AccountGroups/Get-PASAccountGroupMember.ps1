function Get-PASAccountGroupMember {
	<#
.SYNOPSIS
Returns all the members of a specific account group.

.DESCRIPTION
Returns all the members of a specific account group.
These accounts can be either password accounts or SSH Key accounts.
The following permissions are required on the safe:
 - Add Accounts
 - Update Account Content
 - Update Account Properties
  -Create Folders

.PARAMETER GroupID
The unique ID of the account groups.

.EXAMPLE
Get-PASAccountGroupMember -GroupID 21_9

List all members of account group with ID of 21_9

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Account.Group
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Minimum CyberArk version 9.10

.LINK
https://pspas.pspete.dev/commands/Get-PASAccountGroupMember
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$GroupID
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.10"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$Script:BaseURI/API/AccountGroups/$GroupID/Members"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		if ($result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account.Group.Member

		}

	}#process

	END { }#end

}