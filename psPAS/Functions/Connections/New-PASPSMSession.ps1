function New-PASPSMSession {
	<#
.SYNOPSIS
Get required parameters to connect through PSM

.DESCRIPTION
This method enables you to connect to an account through PSM (PSMConnect).
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

.PARAMETER ConnectionMethod
The expected parameters to be returned, either RDP or PSMGW.

PSMGW is only available from version 10.2 onwards

.PARAMETER Path
The folder to save the output file in.

.EXAMPLE
New-PASPSMSession -AccountID $ID -ConnectionComponent PSM-SSH -reason "Fix XYZ"

Outputs RDP file for Direct Connection via PSM using account with ID in $ID

.EXAMPLE
New-PASPSMSession -AccountID $id -ConnectionComponent PSM-RDP -AllowMappingLocalDrives No -PSMRemoteMachine ServerName

Provide connection parameters for the new PSM connection

.NOTES
Minimum CyberArk Version 9.10
PSMGW connections require 10.2
Ad-Hoc connections require 10.5

.LINK
https://pspas.pspete.dev/commands/New-PASPSMSession
#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'ConnectionParams', Justification = "False Positive")]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'PSMConnectPrerequisites', Justification = "False Positive")]
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
		[ValidateSet("Yes", "No")]
		[string]$AllowMappingLocalDrives,

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
		[ValidateSet("Yes", "No")]
		[string]$AllowConnectToConsole,

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
		[ValidateSet("Yes", "No")]
		[string]$RedirectSmartCards,

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
		[string]$PSMRemoteMachine,

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
		[string]$LogonDomain,

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
		[ValidateSet("Yes", "No")]
		[string]$AllowSelectHTML5,

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

		$AdHocParameters = @("ConnectionComponent", "reason", "ticketingSystemName", "ticketId", "ConnectionParams")
		$ConnectionParameters = @("AllowMappingLocalDrives", "AllowConnectToConsole", "RedirectSmartCards", "PSMRemoteMachine", "LogonDomain", "AllowSelectHTML5")


	}#begin

	PROCESS {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID, ConnectionMethod, Path

		#ConnectionParameters are included under the ConnectionParams property of the JSON body
		$boundParameters.keys | Where-Object { $ConnectionParameters -contains $PSItem } | ForEach-Object { $ConnectionParams = @{ } } {

			#For Each ConnectionParams Parameter
			#add key=value to hashtable
			$ConnectionParams.Add($PSItem, @{"value" = $boundParameters[$PSItem] })

		} {
			if ($ConnectionParams.keys.count -gt 0) {

				#if ConnectionParameters have been specified
				#Add ConnectionParams to boundParameters
				$boundParameters["ConnectionParams"] = $ConnectionParams

				#Remove individual ConnectionParameters from boundParameters
				$boundParameters = $boundParameters | Get-PASParameter -ParametersToRemove $ConnectionParameters

			}
		}

		switch ($PSCmdlet.ParameterSetName) {

			"PSMConnect" {
				Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

				#Create URL for Request
				$URI = "$Script:BaseURI/API/Accounts/$($AccountID)/PSMConnect"

				#Create body of request
				$body = $boundParameters | ConvertTo-Json

				break

			}

			"AdHocConnect" {
				Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $AdHocVersion

				#Create URL for Request
				$URI = "$Script:BaseURI/API/Accounts/AdHocConnect"

				#Include decoded password in request
				$boundParameters["secret"] = $(ConvertTo-InsecureString -SecureString $secret)

				#Connection parameters are included under the PSMConnectPrerequisites property of the JSON body, for each one specified
				$boundParameters.keys | Where-Object { $AdHocParameters -contains $PSItem } | ForEach-Object { $PSMConnectPrerequisites = @{ } } {

					#add key=value to hashtable
					$PSMConnectPrerequisites.Add($PSItem, $boundParameters[$PSItem] )

				} {
					if ($PSMConnectPrerequisites.keys.count -gt 0) {

						#If PSMConnectPrerequisites have been specified, add PSMConnectPrerequisites to boundParameters
						$boundParameters["PSMConnectPrerequisites"] = $PSMConnectPrerequisites

					}
				}

				#Create body of request
				$body = $boundParameters | Get-PASParameter -ParametersToRemove $AdHocParameters | ConvertTo-Json -Depth 4

				break

			}

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