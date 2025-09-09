# .ExternalHelp psPAS-help.xml
Function Get-PASStoredPlatform{

[CmdletBinding()]
	param(	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 14.6
	}#begin

	PROCESS {
		#Create request URL
		$URI = "$($psPASSession.BaseURI)/API/Platforms/Storage"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($result) {

			#Return Results
			$result

		}
	}

}