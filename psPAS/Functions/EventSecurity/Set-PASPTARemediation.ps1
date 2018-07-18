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

	.PARAMETER sessionToken
	Hashtable containing the session token returned from New-PASSession

	.PARAMETER WebSession
	WebRequestSession object returned from New-PASSession

	.PARAMETER BaseURI
	PVWA Web Address
	Do not include "/PasswordVault/"

	.PARAMETER PVWAAppName
	The name of the CyberArk PVWA Virtual Directory.
	Defaults to PasswordVault

	.PARAMETER ExternalVersion
	The External CyberArk Version, returned automatically from the New-PASSession function from version 9.7 onwards.

	.EXAMPLE
	$token | Set-PASPTARemediation -changePassword_SuspectedCredentialsTheft $true

	Enables the "Change password on Suspected Credentials Theft" rule.
	.EXAMPLE
	$token | Set-PASPTARemediation -reconcilePassword_SuspectedPasswordChange $false

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
		[boolean]$pendAccount_UnmanagedPrivilegedAccount,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$sessionToken,

		[parameter(
			ValueFromPipelinebyPropertyName = $true
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = "PasswordVault",

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[System.Version]$ExternalVersion = "0.0"
	)

	BEGIN {

		$MinimumVersion = [System.Version]"10.4"

	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#Create URL for Request
		$URI = "$baseURI/$PVWAAppName/API/pta/API/Settings/AutomaticRemediations/"


		#Create body of request
		$body = $boundParameters | ConvertTo-Json

		if($PSCmdlet.ShouldProcess("PTA", "Update Automatic Remediation Config")) {

			#send request to PAS web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body -Headers $sessionToken -WebSession $WebSession

			if($result) {

				#Return Results
				$result.automaticRemediation | Add-ObjectDetail -typename "psPAS.CyberArk.Vault.PTA.Remediation" -PropertyToAdd @{

					"sessionToken"    = $sessionToken
					"WebSession"      = $WebSession
					"BaseURI"         = $BaseURI
					"PVWAAppName"     = $PVWAAppName
					"ExternalVersion" = $ExternalVersion

				}

			}

		}

	}#process

	END {}#end

}