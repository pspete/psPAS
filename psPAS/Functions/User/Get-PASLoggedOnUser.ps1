# .ExternalHelp psPAS-help.xml
function Get-PASLoggedOnUser {
	[CmdletBinding()]
	param(

	)

	BEGIN {
		Assert-VersionRequirement -SelfHosted
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/User"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User

		}

	}#process

	END { }#end

}