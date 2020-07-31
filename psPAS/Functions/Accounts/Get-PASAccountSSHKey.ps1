Function Get-PASAccountSSHKey {
	<#
.SYNOPSIS
Retrieves a private SSH key

.DESCRIPTION
Get the private SSH key value from an existing account

.PARAMETER AccountID
The ID of the account whose SSH Key will be retrieved.

.PARAMETER Reason
The reason for retrieving the private SSH key.

.PARAMETER TicketingSystem
The name of the ticketing system.

.PARAMETER TicketId
The ticket ID defined in the ticketing system.

.PARAMETER Version
The version number of the required SSH key.
If the value is left empty or the value passed does not exist,
then the current SSH key version is returned.

.PARAMETER ActionType
The action this SSH key is used for

.PARAMETER isUse
Internal parameter (for use of PSMP only)

.PARAMETER Machine
The address of the remote machine

.EXAMPLE
Get-PASAccountSSHKey -AccountId 12_3 -Reason "Some Reason"

Returns Private SSH Key associated with account 12_3

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("id")]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Reason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$TicketingSystem,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$TicketId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$Version,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("retrieve")]
		[string]$ActionType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$isUse,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[switch]$Machine
	)

	BEGIN {
		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion 11.5
	}

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/Accounts/$($AccountID | Get-EscapedString)/Secret/Retrieve"

		#Create request body
		$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result

		}
	}

	END { }

}