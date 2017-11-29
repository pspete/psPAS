function Get-PASPSMConnectionParameters {
	<#
.SYNOPSIS
Connect through PSM

.DESCRIPTION
This method allows you to connect with an account through PSM using an RDP file,
by returning RDP parameters that can be used with an RDP client application.
It requires the PVWA and PSM to be configured for transparent connections through PSM with RDP files.

.PARAMETER AccountID
The unique ID of the account to retrieve and use to connect to the target via PSM

.PARAMETER reason
The reason that is required to request access to this account.

.PARAMETER TicketingSystemName
The name of the Ticketing System used in the request.

.PARAMETER TicketId
The TicketId to use with the Ticketing System

.PARAMETER ConnectionComponent
The name of the connection component to connect with as defined in the configuration

.PARAMETER Connectionparameter
List of params

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

.EXAMPLE


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
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$reason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Ticketing"
		)]
		[string]$TicketingSystemName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Ticketing"
		)]
		[string]$TicketId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$ConnectionComponent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[hashtable]$ConnectionParam,

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
		[string]$PVWAAppName = "PasswordVault"
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$baseURI/$PVWAAppName/API/Accounts/$($AccountID)/PSMConnect"

		#Create body of request
		$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $body -Headers $sessionToken -WebSession $WebSession

		If($result) {

			#Return PSM RDP Parameters
			$result

		}

	} #process

	END {}#end

}