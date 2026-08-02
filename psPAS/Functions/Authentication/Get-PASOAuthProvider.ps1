# .ExternalHelp psPAS-help.xml
function Get-PASOAuthProvider {
	[CmdletBinding()]
	param()

	begin {

		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 15.0

	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/OAuth/Providers"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			if ($null -ne $result.Providers) {

				$result = $result | Select-Object -ExpandProperty Providers

			}

			$result | Add-ObjectDetail -TypeName psPAS.CyberArk.Vault.OAuthProvider

		}

	}#process

	end { }#end

}
