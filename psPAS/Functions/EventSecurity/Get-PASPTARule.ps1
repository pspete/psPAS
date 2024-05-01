# .ExternalHelp psPAS-help.xml
Function Get-PASPTARule {
	[CmdletBinding()]
	param(	)

	BEGIN {
		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 10.4
	}#begin

	PROCESS {

		#Create request URL
		$URI = "$($psPASSession.BaseURI)/API/pta/API/Settings"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			#Return Results
			$result.riskyActivities | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Rule

		}

	}#process

	END { }#end

}