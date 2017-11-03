function Invoke-PASCredChange {
	<#
	.SYNOPSIS
	Initiates an immediate password change by the CPM to a new random password.

	.DESCRIPTION
	Flags a managed account credentials for an immediate CPM password change.
	The "Initiate CPM password management operations" permission is required.

	.PARAMETER AccountID
	The unique ID  of the account.
	This is retrieved by the Get-PASAccount function.

	.PARAMETER ChangeEntireGroup
	Boolean value, dictating if all accounts that belong to the same group should
	have their passwords changed.
	This is only relevant for accounts that belong to an account group.
	Parameter will be ignored if account does not belong to a group.

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
	$token | Invoke-PASCredChange -AccountID 21_3

	Will mark account with ID of "21_3" for immediate password change by CPM

	.EXAMPLE
	$token | Get-PASAccount xAccount | Invoke-PASCredChange

	Will mark xAccount for immediate password change by CPM

	.INPUTS
	SessionToken, AccountID, WebSession & BaseURI can be piped by  property name

	.OUTPUTS
	None

	.NOTES
	Minimum CyberArk version 9.9.10

	#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[boolean]$ChangeEntireGroup,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$SessionToken,

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

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/API/Accounts/$AccountID/Change"

		#create request body
		$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		if($PSCmdlet.ShouldProcess($AccountID, "Mark for Immediate Change by CPM")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -body $body -Headers $SessionToken -WebSession $WebSession

		}

	}#process

	END {}#end

}