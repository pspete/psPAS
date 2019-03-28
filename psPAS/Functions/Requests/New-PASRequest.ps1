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

.PARAMETER MultipleAccess
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
New-PASRequest -AccountId $ID -Reason "Task ABC" -MultipleAccess $true -ConnectionComponent PSM-RDP -sessionToken $ST -BaseURI $url

Creates a new request for access to account with ID in $ID

.INPUTS
All parameters can be piped by property name

.OUTPUTS
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Minimum CyberArk Version 9.10

.LINK

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
		[boolean]$MultipleAccess,

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
		[hashtable]$ConnectionParams,

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
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$baseURI/$PVWAAppName/API/MyRequests"

		#Get all parameters that will be sent in the web request
		#$boundParameters = $PSBoundParameters | Get-PASParameter

		if($PSBoundParameters.ContainsKey("FromDate")) {

			#convert to unix time
			$PSBoundParameters["FromDate"] = Get-Date $FromDate -UFormat %s

		}

		if($PSBoundParameters.ContainsKey("ToDate")) {

			#convert to unix time
			$PSBoundParameters["ToDate"] = Get-Date $ToDate -UFormat %s
		}

		#Create body of request
		$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

	if($PSCmdlet.ShouldProcess($AccountId, "Create Request for Account Access")) {

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

		if($result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request -PropertyToAdd @{

				"sessionToken"    = $sessionToken
				"WebSession"      = $WebSession
				"BaseURI"         = $BaseURI
				"PVWAAppName"     = $PVWAAppName
				"ExternalVersion" = $ExternalVersion

			}

	}

}

}#process

END { }#end

}