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

.LINK
https://pspas.pspete.dev/commands/Get-PASPTARemediation
#>
	[CmdletBinding()]
	param(	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.4
	}#begin

	PROCESS {

		#Create request URL
		$URI = "$Script:BaseURI/API/pta/API/Settings"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			#Return Results
			$result.automaticRemediation | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Remediation

		}

	}#process

	END { }#end
}