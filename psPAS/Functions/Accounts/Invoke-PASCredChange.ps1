function Invoke-PASCredChange {
	<#
	.SYNOPSIS
	Either initiates an immediate password change by the CPM to a new random password or a specified password value,
	or updates an accounts password only in the vault.

	.DESCRIPTION
	This function has 3 modes of operation, either:

	Flags a managed account credentials for an immediate CPM password change.
	 - The "Initiate CPM password management operations" permission is required.

	Sets a password to use for an account's next CPM change.
	 - The "Initiate CPM password management operations" & "Specify next password value" permission is required.

	Updates the account's password only in the Vault (without affecting the credentials on the target device).
	 - The "Update password value" permission is required.

	.PARAMETER AccountID
	The unique ID  of the account.
	This is retrieved by the Get-PASAccount function.

	.PARAMETER ChangeCredsForGroup
	Boolean value, dictating if all accounts that belong to the same group should
	have their passwords changed.
	This is only relevant for accounts that belong to an account group.
	Parameter will be ignored if account does not belong to a group.
	Applicable to immediate change via CPM, and password change in the vault only.

	.PARAMETER UpdateVaultOnly
	Specify this switch to only update the password in the vault

	.PARAMETER SetNextPassword
	Specify this switch to provide a value for the next password to be set by the CPM

	.PARAMETER AutoGenerate
	Whether or not the password will be generated according to the password policy rules.
	If the CPM is not configured to enforce a password policy rule, this parameter is irrelevant.
	If the NewCredentials parameter contains a value, this parameter will be ignored.
	Only relevant when updating password in vault only.

	.PARAMETER ChangeImmediately
	Whether or not the password will be changed immediately in the Vault.
	Only relevant when specifying a password value for the next CPM change.

	.PARAMETER NewCredentials
	Secure String value of the new account password that will be allocated to the account in the Vault.
	Only relevant when specifying a password value for the next CPM change, or updating the password only in the vault.

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
	$token | Invoke-PASCredChange -AccountID 21_3

	Will mark account with ID of "21_3" for immediate password change by CPM

	.EXAMPLE
	$token | Get-PASAccount xAccount | Invoke-PASCredChange

	Will mark xAccount for immediate password change by CPM

	.EXAMPLE
	$token | Invoke-PASCredChange -AccountID 24_3 -UpdateVaultOnly -NewCredentials (Read-Host -AsSecureString)

	Updates the password int he vault to the specified value

	.EXAMPLE
	$token | Invoke-PASCredChange -AccountID 24_3 -SetNextPassword -ChangeImmediately $true -NewCredentials $PassWD

	Immediately changes, via CPM, the password to the value contained in the $PassWD variable

	.EXAMPLE
	$token | Invoke-PASCredChange -AccountID 24_3 -SetNextPassword -NewCredentials $PassWD

	Changes, via CPM, the password to the value contained in the $PassWD variable

	.INPUTS
	SessionToken, AccountID, NewCredentials, WebSession & BaseURI can be piped by  property name

	.OUTPUTS
	None

	.NOTES
	Minimum CyberArk version 9.10 for immediate change by CPM
	Minimum CyberArk version 10.1 for specify next password value, and update password only in the Vault

	#>

	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "Change")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("id")]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Change"
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Password/Update"
		)]
		[boolean]$ChangeCredsForGroup,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Password/Update"
		)]
		[switch]$UpdateVaultOnly,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "SetNextPassword"
		)]
		[switch]$SetNextPassword,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Password/Update"
		)]
		[boolean]$AutoGenerate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "SetNextPassword"
		)]
		[boolean]$ChangeImmediately,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Password/Update"
		)]

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "SetNextPassword"
		)]
		[securestring]$NewCredentials,

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
		$MinimumVersion = [System.Version]"9.10"
		$RequiredVersion = [System.Version]"10.1"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		Write-Debug "ParameterSet $($PSCmdlet.ParameterSetName)"

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/API/Accounts/$AccountID/$($PSCmdlet.ParameterSetName)"

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove UpdateVaultOnly, SetNextPassword, AccountID

		#deal with NewCredentials SecureString
		If ($PSBoundParameters.ContainsKey("NewCredentials")) {

			Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $RequiredVersion

			#Include decoded password in request
			$boundParameters["NewCredentials"] = $(ConvertTo-InsecureString -SecureString $NewCredentials)

		}

		#create request body
		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($AccountID, "Password: $($PSCmdlet.ParameterSetName) Value")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -body $body -Headers $SessionToken -WebSession $WebSession

		}

	}#process

	END { }#end

}