function Remove-PASAccount {
	<#
.SYNOPSIS
Deletes an account

.DESCRIPTION
Deletes a specific account in the Vault.
The user who runs this web service requires the "Delete Accounts" permission.

.PARAMETER AccountID
The unique ID  of the account to delete.
This is retrieved by the Get-PASAccount function.

.PARAMETER UseClassicAPI
Specify the UseClassicAPI to force usage the Classic API endpoint.
Relevant for CyberArk versions earlier than 10.4

.EXAMPLE
Remove-PASAccount -AccountID 19_1

Deletes the account with AccountID of 19_1

.INPUTS
All parameters can be piped by propertyname


.LINK
https://pspas.pspete.dev/commands/Remove-PASAccount
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("id")]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v9"
		)]
		[switch]$UseClassicAPI
	)

	BEGIN {
		#check minimum version
		Assert-VersionRequirement -RequiredVersion 10.4
	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			"V9" {

				#Create URL for request (earlier than 10.4)
				$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$AccountID"
				break

			}

			default {

				#Create URL for request (Version 10.4 onwards)
				$URI = "$Script:BaseURI/api/Accounts/$AccountID"

			}

		}

		if ($PSCmdlet.ShouldProcess($AccountID, "Delete Account")) {

			#Send request to webservice
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}