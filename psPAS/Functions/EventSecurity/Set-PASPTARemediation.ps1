Function Set-PASPTARemediation {
	<#
	.SYNOPSIS
	Updates automatic remediation settings in PTA

	.DESCRIPTION
	Updates automatic remediation settings configured in PTA

	.PARAMETER changePassword_SuspectedCredentialsTheft
	Indicate if Change Password on Suspected Credential Theft the command is active

	.PARAMETER changePassword_OverPassTheHash
	Indicate if the Change Password on Over Pass The Hash command is active

	.PARAMETER reconcilePassword_SuspectedPasswordChange
	Indicate if the Reconcile Password on Suspected Password Change command is active

	.PARAMETER pendAccount_UnmanagedPrivilegedAccount
	Indicate if the Add Unmanaged Accounts to Pending Accounts command is active

	.EXAMPLE
Set-PASPTARemediation -changePassword_SuspectedCredentialsTheft $true

	Enables the "Change password on Suspected Credentials Theft" rule.
	.EXAMPLE
Set-PASPTARemediation -reconcilePassword_SuspectedPasswordChange $false

	Disables the "reconcile on suspected password change" rule.

	.NOTES
	Minimum Version CyberArk 10.4
	#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$changePassword_SuspectedCredentialsTheft,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$changePassword_OverPassTheHash,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$reconcilePassword_SuspectedPasswordChange,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$pendAccount_UnmanagedPrivilegedAccount

	)

	BEGIN {

		$MinimumVersion = [System.Version]"10.4"

	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#Create URL for Request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/API/pta/API/Settings/AutomaticRemediations/"


		#Create body of request
		$body = $boundParameters | ConvertTo-Json

		if($PSCmdlet.ShouldProcess("PTA", "Update Automatic Remediation Config")) {

			#send request to PAS web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body -WebSession $Script:WebSession

			if($result) {

				#Return Results
				$result.automaticRemediation | Add-ObjectDetail -typename "psPAS.CyberArk.Vault.PTA.Remediation"

			}

		}

	}#process

	END {}#end

}