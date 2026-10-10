# .ExternalHelp psPAS-help.xml
function Get-PASOpenIDConnectProvider {

	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$id

	)

	begin {

		Assert-VersionRequirement -RequiredVersion 11.7

	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/OIDC/Providers/$($id | Get-EscapedString)"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			if ($null -ne $result.Providers) {

				$result = $result | Select-Object -ExpandProperty Providers

			}

			$result

		}

	}#process

	end { }#end

}