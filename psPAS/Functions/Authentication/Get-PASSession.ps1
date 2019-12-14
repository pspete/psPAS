function Get-PASSession {
	<#
.SYNOPSIS
Returns information related to the authenticated session

.DESCRIPTION
For the current session, returns data from the module scope:
- Username relating to the session.
- BaseURI: URL value used for sending requests to the API.
- ExternalVersion: PAS version information.
- Websession: Contains Authorization Header, Cookie & Certificate data related to the current session.

The session information can be saved a variable accessible outside of the module scope for use in requests outside of psPAS.

.EXAMPLE
Show current session related information

Get-PASSession

.EXAMPLE
Save current session related information

$session = Get-PASSession

.EXAMPLE
Use session information for Invoke-RestMethod command

$session = Get-PASSession

Invoke-RestMethod
Invoke-RestMethod -Method GET -Uri "$session.BaseURI/SomePath" -WebSession $session.WebSession

.LINK
https://pspas.pspete.dev/commands/Get-PASSession
#>
	[CmdletBinding()]
	param( )

	BEGIN { }#begin

	PROCESS {

		[PSCustomObject]@{
			User            = Get-PASLoggedOnUser -ErrorAction Stop | Select-Object -ExpandProperty Username
			BaseURI         = $Script:BaseURI
			ExternalVersion = $Script:ExternalVersion
			WebSession      = $Script:WebSession
		} | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Session

	}#process

	END { }#end

}