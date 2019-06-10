Function Get-PASPTARemediation {
	<#
	.SYNOPSIS
	Returns automatic remediation settings from PTA

	.DESCRIPTION
	Returns automatic remediation settings configured in PTA

	.EXAMPLE
Get-PASPTARemediation

	Returns all automatic remediation settings from PTA

	.NOTES
	Minimum Version CyberArk 10.4
	#>
	[CmdletBinding()]
	param(	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.4"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create request URL
		$URI = "$Script:BaseURI/API/pta/API/Settings"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If($result) {

			#Return Results
			$result.automaticRemediation |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Remediation

		}

	}#process

	END {}#end
}