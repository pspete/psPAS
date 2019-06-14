function Remove-PASAccount {
	<#
.SYNOPSIS
Deletes an account

.DESCRIPTION
Deletes a specific account in the Vault.
The user who runs this web service requires the "Delete Accounts" permission.
If running against a CyberArk version earlier than 10.4, you must specify the UseV9API switch parameter.

.PARAMETER AccountID
The unique ID  of the account to delete.
This is retrieved by the Get-PASAccount function.

.PARAMETER UseClassicAPI
Specify the UseClassicAPI to force usage the Classic (v9) API endpoint.

.EXAMPLE
Remove-PASAccount -AccountID 19_1

Deletes the account with AccountID of 19_1

.INPUTS
All parameters can be piped by propertyname

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
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v9"
		)]
		[Alias("UseV9API")]
		[switch]$UseClassicAPI
	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.4"
	}#begin

	PROCESS {

		If ($PSCmdlet.ParameterSetName -eq "V9") {

			#Create URL for request (earlier than 10.4)
			$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$AccountID"

		}

		Else {

			#check minimum version
			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for request (Version 10.4 onwards)
			$URI = "$Script:BaseURI/api/Accounts/$AccountID"

		}

		if ($PSCmdlet.ShouldProcess($AccountID, "Delete Account")) {

			#Send request to webservice
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}