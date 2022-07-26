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

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Logo?type=$ImageType"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession


		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}