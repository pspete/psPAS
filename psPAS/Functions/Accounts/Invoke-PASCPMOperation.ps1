function Invoke-PASCPMOperation {
	<#
.SYNOPSIS
Marks accounts for CPM Verify, Change or Reconcile operations

.DESCRIPTION
Accounts Can be flagged for immediate verification, change or reconcile
Flags a managed account credentials for an immediate CPM password verification.
CPM Change Options:
Flags a managed account credentials for an immediate CPM password change.
	- The "Initiate CPM password management operations" permission is required.

Sets a password to use for an account's next CPM change.
	- The "Initiate CPM password management operations" & "Specify next password value" permission is required.

Updates the account's password only in the Vault (without affecting the credentials on the target device).
	- The "Update password value" permission is required.

Verify & Reconcile both require "Initiate CPM password management operations"

.PARAMETER AccountID
The unique ID  of the account.

.PARAMETER VerifyTask
Initiates a verify task

.PARAMETER ChangeTask
Initiates a change task

.PARAMETER ReconcileTask
Initiates a reconcile task
Requires CyberArk version 9.10+

.PARAMETER ChangeImmediately
Whether or not the password will be changed immediately in the Vault.
Only relevant when specifying a password value for the next CPM change.
Requires CyberArk version 10.1+

.PARAMETER NewCredentials
Secure String value of the new account password that will be allocated to the account in the Vault.
Only relevant when specifying a password value for the next CPM change, or updating the password only in the vault.
Requires CyberArk version 10.1+

.PARAMETER ChangeEntireGroup
Boolean value, dictating if all accounts that belong to the same group should have their passwords changed.
This is only relevant for accounts that belong to an account group.
Parameter will be ignored if account does not belong to a group.
Applicable to immediate change via CPM, and password change in the vault only.
Requires CyberArk version 10.1+

.PARAMETER ImmediateChangeByCPM
Yes/No value, dictating if the account will be scheduled for immediate change.
Specify Yes to initiate a password change by CPM - Relevant for Classic API only.

.PARAMETER ChangeCredsForGroup
Yes/No value, dictating if all accounts that belong to the same group should
have their passwords changed.
This is only relevant for accounts that belong to an account group.
Parameter will be ignored if account does not belong to a group.
Relevant for Classic API only.

.PARAMETER UseClassicAPI
Specify to force verification via Classic API.

.EXAMPLE
Invoke-PASCPMOperation -AccountID $ID -VerifyTask

Marks an account for verification

.EXAMPLE
Invoke-PASCPMOperation -AccountID $ID -VerifyTask -UseClassicAPI

Marks an account for verification using the Classic API

.EXAMPLE
Invoke-PASCPMOperation -AccountID $ID -ChangeTask -ImmediateChangeByCPM Yes

Marks an account for immediate change using the Classic API

.EXAMPLE
Invoke-PASCPMOperation -AccountID $ID -ChangeTask

Marks an account for immediate change

.EXAMPLE
Invoke-PASCPMOperation -AccountID $ID -ChangeTask -ChangeImmediately $true -NewCredentials $SecureString

Marks an account for immediate change to the specified password value

.EXAMPLE
Invoke-PASCPMOperation -AccountID $ID -ChangeTask -NewCredentials $SecureString

Changes the password for the account in the Vault

.EXAMPLE
Invoke-PASCPMOperation -AccountID $ID -ReconcileTask

Marks an account for immediate reconcile

.LINK
https://pspas.pspete.dev/commands/Invoke-PASCPMOperation
#>

	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', 'ChangeCredsForGroup', Justification = "Parameter does not hold password")]
	[CmdletBinding(SupportsShouldProcess)] # DefaultParameterSetName = "VerifyStandard"
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("id")]
		[string]$AccountID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "VerifyClassic"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Verify"
		)]
		[switch]$VerifyTask,

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
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Change"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "ChangeClassic"
		)]
		[switch]$ChangeTask,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Reconcile"
		)]
		[switch]$ReconcileTask,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "SetNextPassword"
		)]
		[boolean]$ChangeImmediately,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "SetNextPassword"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Password/Update"
		)]
		[securestring]$NewCredentials,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Change"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Password/Update"
		)]
		[boolean]$ChangeEntireGroup,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "ChangeClassic"
		)]
		[ValidateSet('Yes', 'No')]
		[string]$ImmediateChangeByCPM,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "ChangeClassic"
		)]
		[ValidateSet('Yes', 'No')]
		[string]$ChangeCredsForGroup,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "VerifyClassic"
		)]
		[switch]$UseClassicAPI
	)

	Begin {

		#Create hashtable for splatting
		$ThisRequest = @{ }
		$ThisRequest["WebSession"] = $Script:WebSession
		$ThisRequest["Method"] = "PUT"
		#Version Requirements
		$MinimumVersion = [System.Version]"9.10"
		$RequiredVersion = [System.Version]"10.1"

	}#Begin

	Process {

		#Get parameters to include in request body
		$boundParameters = $PSBoundParameters |
		Get-PASParameter -ParametersToRemove ImmediateChangeByCPM, AccountID, VerifyTask, ChangeTask, ReconcileTask

		switch ($PSCmdlet.ParameterSetName) {

			"ChangeClassic" {

				#Classic API CPM Change URI
				$ThisRequest["URI"] = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$AccountID/ChangeCredentials"

				#add ImmediateChangeByCPM to header as key=value pair
				$ThisRequest["WebSession"].Headers["ImmediateChangeByCPM"] = $ImmediateChangeByCPM

				#create request body
				$ThisRequest["Body"] = $boundParameters | ConvertTo-Json

			}

			"VerifyClassic" {

				#Classic API CPM Verify URI
				$ThisRequest["URI"] = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$AccountID/VerifyCredentials"

				#Empty Body
				$ThisRequest["Body"] = @{ } | ConvertTo-Json

			}

			default {

				#Not using classic API
				#At least version 9.10 required to verify/change/reconcile
				Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

				#Use ParameterSet name for required URI
				$ThisRequest["URI"] = "$Script:BaseURI/API/Accounts/$AccountID/$($PSCmdlet.ParameterSetName)"

				#verify/change/reconcile method
				$ThisRequest["Method"] = "POST"

				#deal with NewCredentials SecureString
				If ($PSBoundParameters.ContainsKey("NewCredentials")) {

					#Specifying next password value, or changing in the vault requires 10.1 or above
					Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $RequiredVersion

					#Include decoded password in request
					$boundParameters["NewCredentials"] = $(ConvertTo-InsecureString -SecureString $NewCredentials)

				}

				#create request body
				$ThisRequest["Body"] = $boundParameters | ConvertTo-Json

			}

		}

		if ($PSCmdlet.ShouldProcess($AccountID, "Initiate CPM $($PSBoundParameters.Keys | Where-Object{$_ -like '*Task'})")) {

			#Send the request to the web service
			Invoke-PASRestMethod @ThisRequest

		}

		If ($ThisRequest["WebSession"].Headers.ContainsKey("ImmediateChangeByCPM")) {

			#Ensure ImmediateChangeByCPM is removed from WebSession Header
			$ThisRequest["WebSession"].Headers.Remove("ImmediateChangeByCPM") | Out-Null

		}

	}#Process

	End { }#End

}