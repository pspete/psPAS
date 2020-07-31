function New-PASRequest {
	<#
.SYNOPSIS
Creates an access request for a specific account

.DESCRIPTION
Creates an access request for a specific account.
This account may be either a password account or an SSH Key account.
Officially supported from version 9.10. Reports received that function works in 9.9 also.

.PARAMETER accountId
The ID of the account to access

.PARAMETER reason
The reason why the account will be accessed

.PARAMETER TicketingSystemName
The name of the Ticketing system specified in the request

.PARAMETER TicketId
The Ticket ID given by the ticketing system.

.PARAMETER ConnectionComponent
If the connection is through PSM, the name of the connection component to connect with,
as defined in the configuration.

.PARAMETER MultipleAccessRequired
Whether the request is for multiple accesses

.PARAMETER FromDate
If the request is for a timeframe, the time from when the user wants to access the account.

.PARAMETER ToDate
If the request is for a timeframe, the time until the user wants to access the account.

.PARAMETER AdditionalInfo
Additional information included in the request

.PARAMETER UseConnect
Whether or not the request is for connection through the PSM.

.PARAMETER ConnectionComponent
If the connection is through PSM, the name of the connection component to connect with, as defined in the configuration

.PARAMETER ConnectionParams
A list of parameters required to perform the connection, as defined in each connection component configuration

.EXAMPLE
New-PASRequest -AccountId $ID -Reason "Task ABC" -MultipleAccessRequired $true -ConnectionComponent PSM-RDP

Creates a new request for access to account with ID in $ID

.NOTES
Minimum CyberArk Version 9.10

.LINK
https://pspas.pspete.dev/commands/New-PASRequest
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Reason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$TicketingSystemName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$TicketID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$MultipleAccessRequired,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$FromDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$ToDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[hashtable]$AdditionalInfo,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$UseConnect,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$ConnectionComponent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[hashtable]$ConnectionParams
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.10"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$Script:BaseURI/API/MyRequests"

		if ($PSBoundParameters.ContainsKey("FromDate")) {

			#convert to unix time
			$PSBoundParameters["FromDate"] = $FromDate | ConvertTo-UnixTime

		}

		if ($PSBoundParameters.ContainsKey("ToDate")) {

			#convert to unix time
			$PSBoundParameters["ToDate"] = $ToDate | ConvertTo-UnixTime

		}

		#Create body of request
		$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($AccountId, "Create Request for Account Access")) {

			#send request to PAS web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

			If ($null -ne $result) {

				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request

			}

		}

	}#process

	END { }#end

}