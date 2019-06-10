function Get-PASServer {
	<#
	.SYNOPSIS
	Returns details of the Web Service Server

	.DESCRIPTION
	Returns information on Server.
	Returns the name of the Vault configured in the ServerDisplayName configuration parameter
	Appears to need Vault administrator rights

	.EXAMPLE
	Get-PASServer

	Displays CyberArk Server information
	#>


	[CmdletBinding()]
	param(	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Server"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		if ($result) {

			$result

		}

	}#process

	END { }#end

}