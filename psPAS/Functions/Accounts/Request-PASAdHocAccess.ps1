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

.OUTPUTS
None

.NOTES

.LINK

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
		$MinimumVersion = [System.Version]"10.6"
	}#begin

	PROCESS {

		#check minimum version
		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request (Version 10.4 onwards)
		$URI = "$Script:BaseURI/$Script:PVWAAppName/api/Accounts/$AccountID/grantAdministrativeAccess"

		#Send request to webservice
		Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

	}#process

	END {}#end
}