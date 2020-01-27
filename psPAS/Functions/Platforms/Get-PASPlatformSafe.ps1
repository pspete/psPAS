function Get-PASPlatformSafe {
	<#
.SYNOPSIS
Get safes by platform id

.DESCRIPTION
Returns all safes for a given platform ID

.PARAMETER PlatformID
The unique ID/Name of the platform.

.EXAMPLE
Get-PASPlatformSafe -PlatformID WINDOMAIN

.NOTES
Minimum CyberArk version 11.1

.LINK
https://pspas.pspete.dev/commands/Get-PASPlatformSafe
#>

	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PlatformID
	)

	BEGIN {
		$MinimumVersion = [System.Version]"11.1"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create request URL
		$URI = "$Script:BaseURI/API/Platforms/$($PlatformID | Get-EscapedString)/Safes"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($result.count -gt 0) {

			#Return Results
			$result.value | ForEach-Object { [pscustomobject]@{"SafeName" = $PSItem } }

		}

	}#process

	END { }#end

}