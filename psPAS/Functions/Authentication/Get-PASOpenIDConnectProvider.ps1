# .ExternalHelp psPAS-help.xml
Function Get-PASOpenIDConnectProvider {

	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$id

	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.7

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/OIDC/Providers/$($id | Get-EscapedString)"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			if ($null -ne $result.Providers) {

				$result = $result | Select-Object -ExpandProperty Providers

			}

			$result

		}

	}#process

	END { }#end

}