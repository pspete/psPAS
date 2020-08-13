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

.PARAMETER AllowMappingLocalDrives
Whether or not to redirect their local hard drives to the remote server.

.PARAMETER AllowConnectToConsole
Whether or not to connect to the administrative console of the remote machine.

.PARAMETER RedirectSmartCards
Whether or not to redirect Smart Card so that the certificate stored on the card can be accessed on the target

.PARAMETER PSMRemoteMachine
Address of the remote machine to connect to.

.PARAMETER LogonDomain
The netbios domain name of the account being used.

.PARAMETER AllowSelectHTML5
Specify which connection method, HTML5-based or RDP-file, to use when connecting to the remote server

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
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "ConnectionParams")]
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
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "ConnectionParams"
		)]
		[ValidateSet("Yes", "No")]
		[string]$AllowMappingLocalDrives,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "ConnectionParams"
		)]
		[ValidateSet("Yes", "No")]
		[string]$AllowConnectToConsole,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "ConnectionParams"
		)]
		[ValidateSet("Yes", "No")]
		[string]$RedirectSmartCards,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "ConnectionParams"
		)]
		[string]$PSMRemoteMachine,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "ConnectionParams"
		)]
		[string]$LogonDomain,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "ConnectionParams"
		)]
		[ValidateSet("Yes", "No")]
		[string]$AllowSelectHTML5,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "ManualParams"
		)]
		[hashtable]$ConnectionParams
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$Script:BaseURI/API/MyRequests"

		$boundParameters = $PSBoundParameters | Get-PASParameter

		if ($boundParameters.ContainsKey("FromDate")) {

			#convert to unix time
			$boundParameters["FromDate"] = $FromDate | ConvertTo-UnixTime

		}

		if ($boundParameters.ContainsKey("ToDate")) {

			#convert to unix time
			$boundParameters["ToDate"] = $ToDate | ConvertTo-UnixTime

		}

		#Nest parameters "AllowMappingLocalDrives", "AllowConnectToConsole","RedirectSmartCards",
		#"PSMRemoteMachine", "LogonDomain" & "AllowSelectHTML5" under ConnectionParams Property
		$boundParameters = $boundParameters | ConvertTo-ConnectionParam

		#Create body of request
		$body = $boundParameters | ConvertTo-Json

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