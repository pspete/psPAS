Function Get-PASPlatformPSMConfig {
	<#
.SYNOPSIS
Lists PSM Policy Section of a target platform.

.DESCRIPTION
Allows Vault admins to retrieve the PSM Policy Section of a target platform.

.PARAMETER ID
The numeric ID of the target platform to list PSM Policy of.

.EXAMPLE
Get-PASPlatformPSMConfig -ID 42

Lists PSM Policy Section of target platform with ID of 42.
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$ID
	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/API/Platforms/Targets/$ID/PrivilegedSessionManagement"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}