# .ExternalHelp psPAS-help.xml
function Get-PASAllowedReferrer {
	[CmdletBinding()]
	param(	)

	begin {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/AccessRestriction/AllowedReferrers"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result

		}

	}#process

	end { }#end

}