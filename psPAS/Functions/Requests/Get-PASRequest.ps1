function Get-PASRequest {
	<#
.SYNOPSIS
Gets requests

.DESCRIPTION
Gets Requests
Officially supported from version 9.10. Reports received that function works in 9.9 also.

.PARAMETER RequestType
Specify whether outgoing or incoming requests will be searched for

.PARAMETER OnlyWaiting
Only requests waiting for approval will be listed

.PARAMETER Expired
Expired requests will be included in the list

.EXAMPLE
Get-PASRequest -RequestType IncomingRequests -OnlyWaiting $true

Lists waiting incoming requests

.EXAMPLE
Get-PASRequest -RequestType MyRequests -Expired $false

Lists your none expired (outgoing) requests.

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Minimum CyberArk Version 9.10

.LINK
https://pspas.pspete.dev/commands/Get-PASRequest
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateSet("MyRequests", "IncomingRequests")]
		[string]$RequestType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$OnlyWaiting,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$Expired
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.10"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		$QueryString = $PSBoundParameters | Get-PASParameter -ParametersToRemove RequestType | ConvertTo-QueryString

		#Create URL for Request
		$URI = "$Script:BaseURI/API/$($RequestType)?$QueryString"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			#Return Results
			$result.$RequestType | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request.Details

		}

	}#process

	END { }#end

}