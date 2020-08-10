function Deny-PASRequest {
	<#
.SYNOPSIS
Reject a single request

.DESCRIPTION
Enables a request confirmer to reject a single request, identified by its requestID.
Officially supported from version 9.10. Reports received that function works in 9.9 also.

.PARAMETER RequestId
The ID of the request to confirm

.PARAMETER reason
The reason why the request is approved

.EXAMPLE
Deny-PASRequest -RequestID <ID> - Reason "<Reason>"

Denies request <ID>

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None

.NOTES
Minimum CyberArk Version 9.10

.LINK
https://pspas.pspete.dev/commands/Deny-PASRequest
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
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$Script:BaseURI/API/IncomingRequests/$($RequestID)/Reject"

		#Create body of request
		$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove RequestId | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($RequestId, "Reject Request for Account Access")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}