# .ExternalHelp psPAS-help.xml
function Get-PASSafeShareLogo {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true
		)]
		[ValidateSet('Square', 'Watermark')]
		[String]$ImageType
	)

	BEGIN {
		#!Depracated above 13.2
		Assert-VersionRequirement -MaximumVersion 13.2
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Logo?type=$ImageType"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET


		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}