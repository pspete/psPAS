function Start-PASCredVerify {
	<#
.SYNOPSIS
Marks account for immediate verification by the CPM to a new random password.

.DESCRIPTION
Flags a managed account credentials for an immediate CPM password verification.
The "Initiate CPM password management operations" permission is required.

.PARAMETER AccountID
The unique ID  of the account to delete.
This is retrieved by the Get-PASAccount function.

.EXAMPLE
Start-PASCredVerify -AccountID 19_1

Will mark account with AccountID of 19_1 for Immediate CPM Verification

.INPUTS
SessionToken, AccountID, WebSession & BaseURI can be piped by  property name

.OUTPUTS
None

.NOTES

.LINK

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
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$AccountID/VerifyCredentials"

		$body = @{ } | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($AccountID, "Mark for Immediate Verification")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method PUT -Body $body -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}