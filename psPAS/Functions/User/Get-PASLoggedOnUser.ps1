function Get-PASLoggedOnUser {
	<#
.SYNOPSIS
Returns details of the logged on user

.DESCRIPTION
Returns information on the user who is logged in.

.EXAMPLE
Get-PASLoggedOnUser

Returns information on the user associated with the authorisation token.

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.User
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK

#>
	[CmdletBinding()]
	param(

	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/WebServices/PIMServices.svc/User"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $WebSession

		if($result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User

		}

	}#process

	END {}#end

}