function Get-PASPlatform {
	<#
	.SYNOPSIS
	Retrieves details of a specified platform from the Vault.

	.DESCRIPTION
	Retrieves details of a specified platform from the Vault.

	.PARAMETER Name
	The unique ID/Name of the platform.

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
		$URI = "$Script:BaseURI/API/Platforms/$($Name | Get-EscapedString)"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($result) {

			#Return Results
			$result |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.Platform

		}

	}#process

	END { }#end

}