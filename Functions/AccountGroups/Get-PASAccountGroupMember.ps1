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
$token | Get-PASAccountGroupMember -GroupID 21_9

List all members of account group with ID of 21_9

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.AccountGroup
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Minimum CyberArk version 9.10

.LINK

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$GroupID,

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

	BEGIN {}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$baseURI/$PVWAAppName/API/AccountGroups/$GroupID/Members"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

		if($result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.AccountGroup -PropertyToAdd @{

				"sessionToken" = $sessionToken
				"WebSession"   = $WebSession
				"BaseURI"      = $BaseURI
				"PVWAAppName"  = $PVWAAppName

			}

		}

	}#process

	END {}#end

}