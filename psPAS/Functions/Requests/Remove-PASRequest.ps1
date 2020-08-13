function Remove-PASRequest {
	<#
.SYNOPSIS
Deletes a request from the Vault

.DESCRIPTION
Deletes a request from the Vault.
The "Manage" Safe vault permission is required.
Officially supported from version 9.10. Reports received that function works in 9.9 also.

.PARAMETER RequestID
The ID (composed of the Safe Name and internal RequestID.) of the request to delete.

.EXAMPLE
Remove-PASRequest -RequestID "<ID>"

Deletes Request <ID>

.INPUTS
All parameters can be piped by property name

.LINK
https://pspas.pspete.dev/commands/Remove-PASRequest
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$RequestID
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/API/MyRequests/$($RequestID)"

		if ($PSCmdlet.ShouldProcess($RequestID, "Delete Request")) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}