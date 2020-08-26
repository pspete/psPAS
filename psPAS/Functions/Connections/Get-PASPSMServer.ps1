# .ExternalHelp psPAS-help.xml
Function Get-PASPSMServer {
	[CmdletBinding()]
	param(	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {


		#Create URL for request
		$URI = "$Script:BaseURI/API/PSM/Servers"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		if ($null -ne $result.PSMServers) {

			$result | Select-Object -ExpandProperty PSMServers

		}

	}#process

	END { }#end

}