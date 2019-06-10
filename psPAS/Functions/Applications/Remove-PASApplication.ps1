function Remove-PASApplication {
	<#
.SYNOPSIS
Deletes an application

.DESCRIPTION
Deletes a specific application.
"Manage Users" permission is required to be held.

.PARAMETER AppID
The name of the application to delete.

.EXAMPLE
Remove-PASApplication -AppID NewApp

Deletes application "NewApp"

.INPUTS
All parameters can be piped by property name
Should accept pipeline objects from other *-PASApplication* functions

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
		[string]$AppID
	)

	BEGIN {}#begin

	PROCESS {

		#Request URL
		$URI = "$Script:BaseURI/$Script:PVWAAppName/WebServices/PIMServices.svc/Applications/$($AppID |

            Get-EscapedString)/"

		if($PSCmdlet.ShouldProcess($AppID, "Delete Application")) {

			#Send Request
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END {}#end

}