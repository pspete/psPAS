function Get-PASPlatformTargetScope {
	<#
.SYNOPSIS
Retrieves the target platform settings scope values valid for the connected environment

.DESCRIPTION
Used to provide tab completion for the Get-PASPlatform "Scope" parameter.
Valid scope values vary by connected environment/version, so are retrieved from the API
rather than being a fixed list.

.EXAMPLE
Get-PASPlatformTargetScope

Returns the settings scope values valid for the connected environment

#>
	[CmdletBinding()]
	[OutputType('System.String')]
	param()

	process {

		#Create request URL
		$URI = "$($psPASSession.BaseURI)/API/Platforms/Targets/settings/scopes"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result.scopes

		}

	}#process

}
