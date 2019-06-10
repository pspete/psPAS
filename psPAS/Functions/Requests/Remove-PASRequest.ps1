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

.OUTPUTS
None

.NOTES

.LINK

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
		$MinimumVersion = [System.Version]"9.10"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/API/MyRequests/$($RequestID)"

		if($PSCmdlet.ShouldProcess($RequestID, "Delete Request")) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}