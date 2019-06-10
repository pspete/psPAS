function Get-PASPlatform {
	<#
	.SYNOPSIS
	Retrieves details of a specified platform from the Vault.

	.DESCRIPTION
	Retrieves details of a specified platform from the Vault.

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

	.PARAMETER ExternalVersion
	The External CyberArk Version, returned automatically from the New-PASSession function from version 9.7 onwards.
	If the minimum version requirement of this function is not satisfied, execution will be halted.
	Omitting a value for this parameter, or supplying a version of "0.0" will skip the version check.

	.EXAMPLE
Get-PASPlatform -Name "CyberArk"

	.NOTES
	Minimum CyberArk version 9.10
	#>

	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Name
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.10"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create request URL
		$URI = "$Script:BaseURI/$Script:PVWAAppName/API/Platforms/$($Name | Get-EscapedString)"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $WebSession

		If($result) {

			#Return Results
			$result |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.Platform

		}

	}#process

	END {}#end

}