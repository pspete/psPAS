# .ExternalHelp psPAS-help.xml
Function Add-PASAllowedReferrer {
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

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/AccessRestriction/AllowedReferrers"

		#Create request body
		$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}