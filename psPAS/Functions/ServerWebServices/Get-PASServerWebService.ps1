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
		[string]$PVWAAppName = 'PasswordVault',

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('UseClassicAPI')]
		[switch]$UseGen1API

	)

	BEGIN { }#begin

	PROCESS {

		switch ($PSBoundParameters.Keys) {

			'UseGen1API' {
				#!Depracated above 13.2
				Assert-VersionRequirement -MaximumVersion 13.2

				#Create URL for request
				$URI = "$BaseURI/$PVWAAppName/WebServices/PIMServices.svc/Verify"

				break
			}

			default {

				#Create URL for request
				$URI = "$BaseURI/$PVWAAppName/API/verify/"

			}

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			#return results
			$result | Select-Object ServerName, ServerId, ApplicationName , AuthenticationMethods, Features

		}

	}#process

	END { }#end

}