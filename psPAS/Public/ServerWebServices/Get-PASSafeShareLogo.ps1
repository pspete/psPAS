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

	begin {
		#!Depracated above 13.2
		Assert-VersionRequirement -MaximumVersion 13.2
	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Logo?type=$ImageType"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET


		if ($null -ne $result) {

			$result

		}

	}#process

	end { }#end

}