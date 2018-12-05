function Request-PASAdHocAccess {
	<#
.SYNOPSIS
Requests access to a target Windows machine

.DESCRIPTION
Requests and receives access, with administrative rights, to a target Windows machine.
The domain user who requests access will be added to the local Administrators group of the target machine.

.PARAMETER AccountID
The ID of the local account that will be used to add the logged on user to the Administrators group on the target machine.

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
$token | Request-PASAdHocAccess -AccountID 36_3

Requests "ad hoc" access on the server for which the account with id 36_3 is a local account with local admin membership.

.INPUTS
All parameters can be piped by propertyname

.OUTPUTS
None

.NOTES

.LINK

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("id")]
		[string]$AccountID,

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
		$MinimumVersion = [System.Version]"10.6"
	}#begin

	PROCESS {

		#check minimum version
		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request (Version 10.4 onwards)
		$URI = "$baseURI/$PVWAAppName/api/Accounts/$AccountID/grantAdministrativeAccess"

		#Send request to webservice
		Invoke-PASRestMethod -Uri $URI -Method POST -Headers $sessionToken -WebSession $WebSession

	}#process

	END {}#end
}