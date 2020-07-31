function Get-PASSafeShareLogo {
	<#
.SYNOPSIS
Returns details of configured SafeShare Logo

.DESCRIPTION
Gets configuration details of logo displayed in the SafeShare WebGUI

.PARAMETER ImageType
The requested logo type: Square or Watermark.

.EXAMPLE
Get-PASSafeShareLogo -ImageType Square

Retrieves Safe Share Logo

.INPUTS
WebSession & BaseURI can be piped to the function by propertyname

.NOTES
SafeShare no longer available from CyberArk

.LINK
https://pspas.pspete.dev/commands/Get-PASSafeShareLogo
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true
		)]
		[ValidateSet("Square", "Watermark")]
		[String]$ImageType
	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Logo?type=$ImageType"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession


		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end
}