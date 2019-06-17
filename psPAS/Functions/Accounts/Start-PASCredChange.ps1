function Start-PASCredChange {
	<#
.SYNOPSIS
Initiates an immediate password change by the CPM to a new random password.

.DESCRIPTION
Flags a managed account credentials for an immediate CPM password change.
The "Initiate CPM password management operations" permission is required.

.PARAMETER AccountID
The unique ID  of the account to delete.
This is retrieved by the Get-PASAccount function.

.PARAMETER ImmediateChangeByCPM
Yes/No value, dictating if the account will be scheduled for immediate change.
Specify Yes to initiate a password change by CPM

.PARAMETER ChangeCredsForGroup
Yes/No value, dictating if all accounts that belong to the same group should
have their passwords changed.
This is only relevant for accounts that belong to an account group.
Parameter will be ignored if account does not belong to a group.

.EXAMPLE
Start-PASCredChange -AccountID 21_3 -ImmediateChangeByCPM Yes

Will mark account with ID of "21_3" for immediate password change by CPM

.EXAMPLE
Get-PASAccount xAccount | Start-PASCredChange -ImmediateChangeByCPM Yes

Will mark xAccount for immediate password change by CPM

.INPUTS
SessionToken, AccountID, WebSession & BaseURI can be piped by  property name

.OUTPUTS
None
#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', 'ChangeCredsForGroup', Justification = "Parameter does not hold password")]
	[CmdletBinding(SupportsShouldProcess)]
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
			ValueFromPipelinebyPropertyName = $false
		)]
		[ValidateSet('Yes', 'No')]
		[string]$ImmediateChangeByCPM,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[ValidateSet('Yes', 'No')]
		[string]$ChangeCredsForGroup
	)

	BEGIN {

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$AccountID/ChangeCredentials"

		#Get parameters to include in request body
		$boundParameters = $PSBoundParameters |

		#ImmediateChangeByCPM must be sent in the request header
		#remove it from the body of the request
		Get-PASParameter -ParametersToRemove "ImmediateChangeByCPM", AccountID

		$ThisSession = $Script:WebSession

		#add ImmediateChangeByCPM to header as key=value pair
		$ThisSession.Headers["ImmediateChangeByCPM"] = $ImmediateChangeByCPM

		#create request body
		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($AccountID, "Mark for Immediate Change by CPM")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method PUT -body $body -WebSession $ThisSession

		}

	}#process

	END { }#end

}