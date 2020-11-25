# .ExternalHelp psPAS-help.xml
function Get-PASServerWebService {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = "PasswordVault"
	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$BaseURI/$PVWAAppName/WebServices/PIMServices.svc/Verify"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $WebSession

		If ($null -ne $result) {

			#return results
			$result | Select-Object ServerName, ServerId, ApplicationName , AuthenticationMethods

		}

	}#process

	END { }#end
}