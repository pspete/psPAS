# .ExternalHelp psPAS-help.xml
function Get-PASUserLoginInfo {
	[CmdletBinding()]
	param(	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.4
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/LoginsInfo"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User.Login

		}

	}#process

	END { }#end

}