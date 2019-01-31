function Get-PASPSMConnectionParameter {
	<#
.SYNOPSIS
Get required parameters to connect through PSM

.DESCRIPTION
This method enables you to connect to an account through PSM (PSMConnect) using
a connection method defined in the PVWA.
The function returns the parameters to be used in an RDP file or with a Remote Desktop Manager, or if
a PSMGW is configured, the HTML5 connection data and the required PSMGW URL.
It requires the PVWA and PSM to be configured for either transparent connections through PSM with RDP files
or the HTML5 Gateway.

.PARAMETER AccountID
The unique ID of the account to retrieve and use to connect to the target via PSM

.PARAMETER userName
For Ad-Hoc connections: the username of the account to connect with.

.PARAMETER secret
For Ad-Hoc connections: The target account password.

.PARAMETER address
For Ad-Hoc connections: The target account address.

.PARAMETER platformID
For Ad-Hoc connections: A configured secure connect platform.

.PARAMETER extraFields
For Ad-Hoc connections: Additional needed parameters for the various connection components.

.PARAMETER reason
The reason that is required to request access to this account.

.PARAMETER TicketingSystemName
The name of the Ticketing System used in the request.

.PARAMETER TicketId
The TicketId to use with the Ticketing System

.PARAMETER ConnectionComponent
The name of the connection component to connect with as defined in the configuration

.PARAMETER ConnectionParams
List of params

.PARAMETER ConnectionMethod
The expected parameters to be returned, either RDP or PSMGW.

PSMGW is only available from version 10.2 onwards

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
Get-PASPSMConnectionParameter -AccountID $ID -ConnectionComponent PSM-SSH -reason "Fix XYZ" -sessionToken $ST -BaseURI $url

Outputs RDP file contents for Direct Connection via PSM using account with ID in $ID

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
PSMGW connections require 10.2
Ad-Hoc connections require 10.5

.LINK

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "PSMConnect"
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AdHocConnect"
		)]
		[string]$userName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AdHocConnect"
		)]
		[securestring]$secret,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AdHocConnect"
		)]
		[string]$address,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AdHocConnect"
		)]
		[string]$platformID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AdHocConnect"
		)]
		[string]$extraFields,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "PSMConnect"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AdHocConnect"
		)]
		[string]$reason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "PSMConnect"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AdHocConnect"
		)]
		[string]$TicketingSystemName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "PSMConnect"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AdHocConnect"
		)]
		[string]$TicketId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "PSMConnect"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AdHocConnect"
		)]
		[string]$ConnectionComponent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "PSMConnect"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AdHocConnect"
		)]
		[hashtable]$ConnectionParams,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "PSMConnect"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "AdHocConnect"
		)]
		[ValidateSet("RDP", "PSMGW")]
		[string]$ConnectionMethod,

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
		$RequiredVersion = [System.Version]"10.2"
		$AdHocVersion = [System.Version]"10.5"

		$AdHocParameters = @("ConnectionComponent", "reason", "ticketingSystemName", "ticketId")


	}#begin

	PROCESS {

		if($PSCmdlet.ParameterSetName -eq "PSMConnect") {

			Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for Request
			$URI = "$baseURI/$PVWAAppName/API/Accounts/$($AccountID)/PSMConnect"

			#Create body of request
			$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID, ConnectionMethod | ConvertTo-Json

		} elseif($PSCmdlet.ParameterSetName -eq "AdHocConnect") {

			Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $AdHocVersion

			#Create URL for Request
			$URI = "$baseURI/$PVWAAppName/API/Accounts/AdHocConnect"

			#Get all parameters that will be sent in the request
			$boundParameters = $PSBoundParameters | Get-PASParameter

			#Include decoded password in request
			$boundParameters["secret"] = $(ConvertTo-InsecureString -SecureString $secret)

			$PSMConnectPrerequisites = @{}

			$boundParameters.keys | Where-Object {$AdHocParameters -contains $_} | ForEach-Object {

				#add key=value to hashtable
				$PSMConnectPrerequisites[$_] = $boundParameters[$_]

			}

			$boundParameters["PSMConnectPrerequisites"] = $PSMConnectPrerequisites

			$body = $boundParameters | Get-PASParameter -ParametersToRemove $AdHocParameters | ConvertTo-Json -Depth 4

		}

		$Header = $sessionToken

		#if a connection method is specified
		If($PSBoundParameters.ContainsKey("ConnectionMethod")) {

			#The information needs to passed in the header
			if($PSBoundParameters["ConnectionMethod"] -eq "RDP") {

				#RDP accept "application/json" response
				$Accept = "application/json"

			} elseif($PSBoundParameters["ConnectionMethod"] -eq "PSMGW") {

				Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $RequiredVersion

				#PSMGW accept * / * response
				$Accept = "* / *"

			}

			#add detail to header
			$Header["Accept"] = $Accept

		}

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $body -Headers $Header -WebSession $WebSession

		If($result) {

			#Return PSM Connection Parameters
			$result | Add-ObjectDetail -typename "psPAS.CyberArk.Vault.PSM.Connection.RDP"

		}

	} #process

	END {}#end

}