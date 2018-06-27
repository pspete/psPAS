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

.PARAMETER UseV9API
Specify this switch to force usage of the legacy API endpoint.

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

.PARAMETER ExternalVersion
The External CyberArk Version, returned automatically from the New-PASSession function from version 9.7 onwards.

.EXAMPLE
$token | Remove-PASAccount -AccountID 19_1

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
		[switch]$UseV9API,

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
		[string]$PVWAAppName = "PasswordVault",

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[System.Version]$ExternalVersion = "0.0"

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.4"
	}#begin

	PROCESS {

		If($PSCmdlet.ParameterSetName -eq "V9") {

			#Create URL for request (earlier than 10.4)
			$URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Accounts/$AccountID"

		}

		Else {

			#check minimum version
			Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for request (Version 10.4 onwards)
			$URI = "$baseURI/$PVWAAppName/api/Accounts/$AccountID"

		}

		if($PSCmdlet.ShouldProcess($AccountID, "Delete Account")) {

			#Send request to webservice
			Invoke-PASRestMethod -Uri $URI -Method DELETE -Headers $sessionToken -WebSession $WebSession

		}

	}#process

	END {}#end
}