# .ExternalHelp psPAS-help.xml
function Get-PASLoggedOnUser {
	[CmdletBinding()]
	param(

	)

	begin {
		Assert-VersionRequirement -SelfHosted
	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/User"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User

		}

	}#process

	end { }#end

}