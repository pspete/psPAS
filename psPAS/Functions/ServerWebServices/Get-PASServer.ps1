# .ExternalHelp psPAS-help.xml
function Get-PASServer {
	[CmdletBinding()]
	param(	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Server"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}