function Invoke-PASCredReconcile {
	<#
	.SYNOPSIS
	Initiates password reconcile by the CPM to a new random password.

	.DESCRIPTION
	Flags a managed account credentials for an automatic CPM password reconcile.
	The "Initiate CPM password management operations" permission is required.

	.PARAMETER AccountID
	The unique ID  of the account.
	This is retrieved by the Get-PASAccount function.

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
	If the minimum version requirement of this function is not satisfied, execution will be halted.
	Omitting a value for this parameter, or supplying a version of "0.0" will skip the version check.

	.EXAMPLE
	Invoke-PASCredReconcile -AccountID 21_3

	Will mark account with ID of "21_3" for password reconcile by CPM

	.EXAMPLE
	Get-PASAccount xAccount | Invoke-PASCredReconcile

	Will mark xAccount for password reconciliation by CPM

	.INPUTS
	SessionToken, AccountID, WebSession & BaseURI can be piped by  property name

	.OUTPUTS
	None

	.NOTES
	Minimum CyberArk version 9.10

	#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("id")]
		[string]$AccountID
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.10"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/API/Accounts/$AccountID/Reconcile"

		if ($PSCmdlet.ShouldProcess($AccountID, "Mark for password reconcile by CPM")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}