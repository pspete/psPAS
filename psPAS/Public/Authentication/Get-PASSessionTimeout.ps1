# .ExternalHelp psPAS-help.xml
function Get-PASSessionTimeout {
	[CmdletBinding()]
	param(

	)

	begin {

		Assert-VersionRequirement -RequiredVersion 13.2
		Assert-VersionRequirement -SelfHosted

	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Settings/Timeout"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Session.Timeout

		}

	}#process

	end { }#end

}
