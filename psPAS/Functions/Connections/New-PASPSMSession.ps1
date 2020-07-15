function New-PASPSMSession {
	<#
.SYNOPSIS
Get required parameters to connect through PSM

.DESCRIPTION
This method enables you to connect to an account through PSM (PSMConnect) using.
The function returns either an RDP file or URL for PSM connections.
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

.PARAMETER Path
The folder to save the output file in.

.EXAMPLE
New-PASPSMSession -AccountID $ID -ConnectionComponent PSM-SSH -reason "Fix XYZ"

Outputs RDP file for Direct Connection via PSM using account with ID in $ID

.NOTES
Minimum CyberArk Version 9.10
PSMGW connections require 10.2
Ad-Hoc connections require 10.5

.LINK
https://pspas.pspete.dev/commands/New-PASPSMSession
#>
	[CmdletBinding()]
	[Alias("Get-PASPSMConnectionParameter")]
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
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateScript( { Test-Path -Path $_ -IsValid })]
		[string]$Path
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.10"
		$RequiredVersion = [System.Version]"10.2"
		$AdHocVersion = [System.Version]"10.5"

		$AdHocParameters = @("ConnectionComponent", "reason", "ticketingSystemName", "ticketId")


	}#begin

	PROCESS {

		if ($PSCmdlet.ParameterSetName -eq "PSMConnect") {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for Request
			$URI = "$Script:BaseURI/API/Accounts/$($AccountID)/PSMConnect"

			#Create body of request
			$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID, ConnectionMethod | ConvertTo-Json

		}
		elseif ($PSCmdlet.ParameterSetName -eq "AdHocConnect") {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $AdHocVersion

			#Create URL for Request
			$URI = "$Script:BaseURI/API/Accounts/AdHocConnect"

			#Get all parameters that will be sent in the request
			$boundParameters = $PSBoundParameters | Get-PASParameter

			#Include decoded password in request
			$boundParameters["secret"] = $(ConvertTo-InsecureString -SecureString $secret)

			$PSMConnectPrerequisites = @{ }

			$boundParameters.keys | Where-Object { $AdHocParameters -contains $_ } | ForEach-Object {

				#add key=value to hashtable
				$PSMConnectPrerequisites[$_] = $boundParameters[$_]

			}

			$boundParameters["PSMConnectPrerequisites"] = $PSMConnectPrerequisites

			$body = $boundParameters | Get-PASParameter -ParametersToRemove $AdHocParameters | ConvertTo-Json -Depth 4

		}

		$ThisSession = $Script:WebSession

		#if a connection method is specified
		If ($PSBoundParameters.ContainsKey("ConnectionMethod")) {

			#The information needs to passed in the header
			if ($PSBoundParameters["ConnectionMethod"] -eq "RDP") {

				#RDP accept "application/json" response
				$Accept = "application/octet-stream"

			}
			elseif ($PSBoundParameters["ConnectionMethod"] -eq "PSMGW") {

				Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $RequiredVersion

				#PSMGW accept * / * response
				$Accept = "* / *"

			}

			#add detail to header
			$ThisSession.Headers["Accept"] = $Accept

		}

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $body -WebSession $ThisSession

		If ($result) {

			If (($result | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name) -contains "PSMGWRequest") {

				#Return PSM GW URL Details
				$result

			}
			Else {

				#Save the RDP file to disk
				Out-PASFile -InputObject $result -Path $Path

			}

		}

	} #process

	END { }#end

}