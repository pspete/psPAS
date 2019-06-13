function Remove-PASApplicationAuthenticationMethod {
	<#
.SYNOPSIS
Deletes an authentication method from an application

.DESCRIPTION
Deletes a specific authentication method from a defined application.
"Manage Users" permission is required.

.PARAMETER AppID
The ID of the application in which the authentication will be deleted.

.PARAMETER AuthID
The unique ID of the specific authentication.

.EXAMPLE
Remove-PASApplicationAuthenticationMethod -AppID NewApp -AuthID 1

Deletes authentication method with ID of 1 from "NewApp"

.EXAMPLE
Get-PASApplicationAuthenticationMethods -AppID NewApp | Remove-PASApplicationAuthenticationMethod

Deletes all authentication methods from "NewApp"

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
		[string]$AppID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AuthID
	)

	BEGIN {}#begin

	PROCESS {

		#request URL
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Applications/$($AppID |

            Get-EscapedString)/Authentications/$($AuthID |

                Get-EscapedString)"

		if($PSCmdlet.ShouldProcess($AppID, "Delete Authentication Method '$AuthID'")) {

			#Send Request
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END {}#end

}