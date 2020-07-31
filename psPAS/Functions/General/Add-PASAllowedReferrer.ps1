Function Add-PASAllowedReferrer {
	<#
.SYNOPSIS
Adds an entry to the allowed refferer list.

.DESCRIPTION
Adds a new web application URL to the allowed referrer list.
Vault admins group membership required.

.PARAMETER referrerURL
A URL from where access to PVWA will be allowed:

.PARAMETER regularExpression
Whether or not the URL is a regular expression.

.EXAMPLE
Add-PASAllowedReferrer -referrerURL "https://CompanyA/portal/"

Adds portal URL which permits access from any page or sub-directory

.EXAMPLE
Add-PASAllowedReferrer -referrerURL "https://CompanyB/management/dashboard"

Adds URL that only allows access from a specific page
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$referrerURL,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$regularExpression
	)

	BEGIN {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/AccessRestriction/AllowedReferrers"

		#Create request body
		$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}