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

.OUTPUTS

.NOTES
SafeShare no longer available from CyberArk

.LINK

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true
		)]
		[ValidateSet("Square", "Watermark")]
		[String]$ImageType
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Logo?type=$ImageType"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession


		if($result) {

			$result

		}

	}#process

	END {}#end
}