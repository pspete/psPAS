function Approve-PASRequest {
	<#
.SYNOPSIS
Confirm a single request

.DESCRIPTION
Enables a request confirmer to confirm a single request, identified by its requestID.
Officially supported from version 9.10. Reports received that function works in 9.9 also.

.PARAMETER RequestId
The ID of the request to confirm

.PARAMETER reason
The reason why the request is approved

.EXAMPLE
Approve-PASRequest -RequestID <ID> - Reason "<Reason>"

Confirms request <ID>

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None

.NOTES
Minimum CyberArk Version 9.10

.LINK
https://pspas.pspete.dev/commands/Approve-PASRequest
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$RequestId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Reason
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.10"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$Script:BaseURI/API/IncomingRequests/$($RequestID)/Confirm"

		#Create body of request
		$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove RequestId | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($RequestId, "Confirm Request for Account Access")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}