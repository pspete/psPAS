function Remove-PASSafe {
	<#
.SYNOPSIS
Deletes a safe from the Vault


.DESCRIPTION
Deletes a safe from the Vault.
The "Manage" Safe vault permission is required.

.PARAMETER SafeName
The name of the safe to delete.

.EXAMPLE
Remove-PASSafe -SafeName OLD_Safe

Deletes "OLD_Safe"

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
		[string]$SafeName

	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Safes/$($SafeName |

            Get-EscapedString)"

		if($PSCmdlet.ShouldProcess($SafeName, "Delete Safe")) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END {}#end
}