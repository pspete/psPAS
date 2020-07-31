function Get-PASApplicationAuthenticationMethod {
	<#
.SYNOPSIS
Returns information about all of the authentication methods of a specific application.

.DESCRIPTION
Returns information about all of the authentication methods of a specific application.
The user authenticated to the vault running the command must have the "Audit Users" permission.

.PARAMETER AppID
The name of the application for which information about authentication methods will be returned.

.EXAMPLE
Get-PASApplicationAuthenticationMethod -AppID NewApp

Gets all authentication methods of application NewApp

.INPUTS
All parameters can be piped by property name
Should accept pipeline objects from other *-PASApplication* functions

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Application
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.LINK
https://pspas.pspete.dev/commands/Get-PASApplicationAuthenticationMethod
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$AppID
	)

	BEGIN { }#begin

	PROCESS {

		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Applications/$($AppID |

            Get-EscapedString)/Authentications"

		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result.authentication | Add-ObjectDetail -typename psPAS.CyberArk.Vault.ApplicationAuth

		}

	}#process

	END { }#end

}