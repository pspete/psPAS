# .ExternalHelp psPAS-help.xml
function Get-PASUserLoginInfo {
	[CmdletBinding()]
	param(	)

	begin {
		Assert-VersionRequirement -RequiredVersion 10.4
	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/LoginsInfo"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User.Login

		}

	}#process

	end { }#end

}