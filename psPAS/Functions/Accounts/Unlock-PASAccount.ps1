function Unlock-PASAccount {
	<#
	.SYNOPSIS
	Checks in an exclusive account in to the Vault.

	.DESCRIPTION
	Checks in an account, locked due to an exclusive account policy, to the Vault.
	If the account is managed automatically by the CPM, after it is checked in,the password is changed immediately.
	If the account is managed manually, a notification is sent to a user who is authorised to change the password.
	The account is checked in automatically after it has been changed.
	Requires Initiate CPM password management operations on the Safe where the account is stored.

	.PARAMETER AccountID
	The unique ID  of the account.
	This is retrieved by the Get-PASAccount function.

	.EXAMPLE
Unlock-PASAccount -AccountID 21_3

	Will check-in exclusive access account with ID of "21_3"

	.EXAMPLE
Get-PASAccount xAccount | Unlock-PASAccount

	Will check-in exclusive access account xAccount

	.INPUTS
	SessionToken, AccountID, WebSession & BaseURI can be piped by  property name

	.OUTPUTS
	None

	.NOTES
	Minimum CyberArk version 9.10

	#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("id")]
		[string]$AccountID
	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/API/Accounts/$AccountID/CheckIn"

		if ($PSCmdlet.ShouldProcess($AccountID, "Check-In Exclusive Access Account")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}