# .ExternalHelp psPAS-help.xml
function Get-PASBYOKPolicyStatement {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('main', 'recovery')]
		[string]$region
	)

	begin {
		Assert-VersionRequirement -PrivilegeCloud
	}

	process {

		#Create URL for request
		$URI = "$($psPASSession.ApiURI)/api/byok/key-policy-statement"

		#Create Query String, escaped for inclusion in request URL
		$queryString = $PSBoundParameters | Get-PASParameter | ConvertTo-QueryString

		if ($null -ne $queryString) {

			$URI = "$URI`?$queryString"

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result

		}

	}

	end {}

}
