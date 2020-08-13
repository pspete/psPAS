Function Get-PASAllowedReferrer {
	<#
.SYNOPSIS
Gets the allowed referrer list

.DESCRIPTION
Returns details of all configured entries from the allowed referrer list.
Vault admins group membership required

.EXAMPLE
Get-PASAllowedReferrer

Returns referrer list
#>
	[CmdletBinding()]
	param(	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/AccessRestriction/AllowedReferrers"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}