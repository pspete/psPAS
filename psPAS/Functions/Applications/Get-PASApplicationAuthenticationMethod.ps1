function Get-PASApplicationAuthenticationMethod {
	<#
.SYNOPSIS
Returns information about all of the authentication methods of a specific application.

.DESCRIPTION
Returns information about all of the authentication methods of a specific application.
The user authenticated to the vault running the command must have the "Audit Users" permission.

.PARAMETER AppID
The name of the application for which information about authentication methods will be returned.

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
$token | Get-PASApplicationAuthenticationMethod -AppID NewApp

Gets all authentication methods of application NewApp

.INPUTS
All parameters can be piped by property name
Should accept pipeline objects from other *-PASApplication* functions

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Application
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK

#>
	[Alias("Get-PASApplicationAuthenticationMethods")]
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$AppID,

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

	BEGIN {}#begin

	PROCESS {

		$URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Applications/$($AppID |

            Get-EscapedString)/Authentications"

		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

		if($result) {

			$result.authentication | Add-ObjectDetail -typename psPAS.CyberArk.Vault.ApplicationAuth -PropertyToAdd @{

				"sessionToken"    = $sessionToken
				"WebSession"      = $WebSession
				"BaseURI"         = $BaseURI
				"PVWAAppName"     = $PVWAAppName
				"ExternalVersion" = $ExternalVersion

			}

		}

	}#process

	END {}#end

}