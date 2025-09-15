# .ExternalHelp psPAS-help.xml
function Get-PASStoredPlatform {

	[CmdletBinding()]
	param(	)

	begin {
		Assert-VersionRequirement -RequiredVersion 14.6
	}#begin

	process {
		#Create request URL
		$URI = "$($psPASSession.BaseURI)/API/Platforms/Storage"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($result) {

			#Return Results
			$result

		}
	}

}