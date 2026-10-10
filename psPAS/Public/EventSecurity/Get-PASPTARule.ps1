# .ExternalHelp psPAS-help.xml
function Get-PASPTARule {
	[CmdletBinding()]
	param(	)

	begin {
		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 10.4
	}#begin

	process {

		#Create request URL
		$URI = "$($psPASSession.BaseURI)/API/pta/API/Settings"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			#Return Results
			$result.riskyActivities | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Rule

		}

	}#process

	end { }#end

}