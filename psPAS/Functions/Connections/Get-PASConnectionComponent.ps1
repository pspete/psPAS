# .ExternalHelp psPAS-help.xml
Function Get-PASConnectionComponent {
	[CmdletBinding()]
	param(	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {


		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/PSM/Connectors"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result.PSMConnectors) {

			$result | Select-Object -ExpandProperty PSMConnectors

		}

	}#process

	END { }#end

}