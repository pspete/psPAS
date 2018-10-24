function Connect-PASPSMSession {
	<#
.SYNOPSIS
Connect to Live PSM Sessions

.DESCRIPTION
Returns connection data necessary to monitor an active PSM session.

.PARAMETER SessionId
The unique ID of the PSM Live Session.

.PARAMETER ConnectionMethod
The expected parameters to be returned, either RDP or PSMGW.

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
$token | Connect-PASPSMSession -LiveSessionId $SessionUUID -ConnectionMethod RDP

Returns parameters to connect to Live PSM Session via RDP.

.EXAMPLE
$token | Connect-PASPSMSession -LiveSessionId $SessionUUID -ConnectionMethod PSMGW

Returns parameters to connect to Live PSM Session via HTML5 GW.

.INPUTS

.OUTPUTS

.NOTES
Minimum CyberArk Version 10.5

.LINK

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$SessionId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
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
		$MinimumVersion = [System.Version]"10.5"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$baseURI/$PVWAAppName/API/LiveSessions/$($SessionId | Get-EscapedString)/monitor"

		$Header = $sessionToken

		#if a connection method is specified
		If($PSBoundParameters.ContainsKey("ConnectionMethod")) {

			#The information needs to passed in the header
			if($PSBoundParameters["ConnectionMethod"] -eq "RDP") {

				#RDP accept "application/json" response
				$Accept = "application/json"

			} elseif($PSBoundParameters["ConnectionMethod"] -eq "PSMGW") {

				#PSMGW accept * / * response
				$Accept = "* / *"

			}

			#add detail to header
			$Header["Accept"] = $Accept

		}

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $Header -WebSession $WebSession

		If($result) {

			$result

		} #process

	}

	END {}#end

}