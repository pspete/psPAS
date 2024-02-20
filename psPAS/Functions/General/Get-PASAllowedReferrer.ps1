# .ExternalHelp psPAS-help.xml
Function Get-PASAllowedReferrer {
	[CmdletBinding()]
	param(	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/AccessRestriction/AllowedReferrers"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}