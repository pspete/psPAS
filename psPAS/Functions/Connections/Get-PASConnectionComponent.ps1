# .ExternalHelp psPAS-help.xml
function Get-PASConnectionComponent {
	[CmdletBinding()]
	param(	)

	begin {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	process {


		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/PSM/Connectors"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result.PSMConnectors) {

			$result | Select-Object -ExpandProperty PSMConnectors

		}

	}#process

	end { }#end

}