function Remove-PASUser {
	<#
.SYNOPSIS
Deletes a vault user

.DESCRIPTION
Deletes an existing user from the vault

.PARAMETER UserName
The name of the user to delete from the vault

.EXAMPLE
Remove-PASUser This_User

Deletes vault user "This_User"

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
		[string]$UserName
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)"

		if($PSCmdlet.ShouldProcess($UserName, "Delete User")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END {}#end
}