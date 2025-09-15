# .ExternalHelp psPAS-help.xml
function Add-PASAllowedReferrer {
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

	begin {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/AccessRestriction/AllowedReferrers"

		#Create request body
		$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $result) {

			$result

		}

	}#process

	end { }#end

}