# .ExternalHelp psPAS-help.xml
Function Get-PASAllowedReferrer {
	[CmdletBinding()]
	param(	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/AccessRestriction/AllowedReferrers"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}