# .ExternalHelp psPAS-help.xml
function Get-PASPSMServer {
	[CmdletBinding()]
	param(	)

	begin {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	process {


		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/PSM/Servers"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result.PSMServers) {

			$result | Select-Object -ExpandProperty PSMServers

		}

	}#process

	end { }#end

}