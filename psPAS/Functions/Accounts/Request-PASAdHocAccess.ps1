function Request-PASAdHocAccess {
	<#
.SYNOPSIS
Requests access to a target Windows machine

.DESCRIPTION
Requests and receives access, with administrative rights, to a target Windows machine.
The domain user who requests access will be added to the local Administrators group of the target machine.

.PARAMETER AccountID
The ID of the local account that will be used to add the logged on user to the Administrators group on the target machine.

.EXAMPLE
Request-PASAdHocAccess -AccountID 36_3

Requests "ad hoc" access on the server for which the account with id 36_3 is a local account with local admin membership.

.INPUTS
All parameters can be piped by propertyname


.LINK
https://pspas.pspete.dev/commands/Request-PASAdHocAccess
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("id")]
		[string]$AccountID
	)

	BEGIN {
		#check minimum version
		Assert-VersionRequirement -RequiredVersion 10.6
	}#begin

	PROCESS {

		#Create URL for request (Version 10.4 onwards)
		$URI = "$Script:BaseURI/api/Accounts/$AccountID/grantAdministrativeAccess"

		#Send request to webservice
		Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

	}#process

	END { }#end
}