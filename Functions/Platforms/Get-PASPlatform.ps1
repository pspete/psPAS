function Get-PASPlatform {
	<#
	.SYNOPSIS
	Retrieves details of a specified platform from the Vault.

	.DESCRIPTION
	Long description

	.PARAMETER Name
	The unique ID/Name of the platform.

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
	$token | Get-PASPlatform -Name "CyberArk"

	.NOTES
	Minimum CyberArk version 9.9.10
	#>

	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Name,

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

		#Create request URL
		$URI = "$baseURI/$PVWAAppName/API/Platforms/$($Name | Get-EscapedString)"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

		If($result) {

			#Return Results
			$result |

			Add-ObjectDetail -PropertyToAdd @{

				"sessionToken" = $sessionToken
				"WebSession"   = $WebSession
				"BaseURI"      = $BaseURI
				"PVWAAppName"  = $PVWAAppName

			}

		}

	}#process

	END {}#end

}