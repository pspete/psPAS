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

.EXAMPLE
Connect-PASPSMSession -LiveSessionId $SessionUUID -ConnectionMethod RDP

Returns parameters to connect to Live PSM Session via RDP.

.EXAMPLE
Connect-PASPSMSession -LiveSessionId $SessionUUID -ConnectionMethod PSMGW

Returns parameters to connect to Live PSM Session via HTML5 GW.

.NOTES
Minimum CyberArk Version 10.5

.LINK
https://pspas.pspete.dev/commands/Connect-PASPSMSession
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
		[string]$ConnectionMethod
	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.5"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$($Script:BaseURI)/API/LiveSessions/$($SessionId | Get-EscapedString)/monitor"

		$ThisSession = $Script:WebSession

		#if a connection method is specified
		If ($PSBoundParameters.ContainsKey("ConnectionMethod")) {

			#The information needs to passed in the header
			if ($PSBoundParameters["ConnectionMethod"] -eq "RDP") {

				#RDP accept "application/json" response
				$Accept = "application/json"

			}
			elseif ($PSBoundParameters["ConnectionMethod"] -eq "PSMGW") {

				#PSMGW accept * / * response
				$Accept = "* / *"

			}

			#add detail to header
			$ThisSession.Headers["Accept"] = $Accept

		}

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $ThisSession

		If ($null -ne $result) {

			$result

		} #process

	}

	END { }#end

}