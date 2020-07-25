Function Get-PASAuthenticationMethod {
	<#
.SYNOPSIS
List authentication methods

.DESCRIPTION
Returns a list of all existing authentication methods.
Membership of ault admins group required

.EXAMPLE
Get-PASAuthenticationMethod

Returns list of all authentication methods.
#>
	[CmdletBinding()]
	param(	)

	BEGIN {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion 11.5

	}#begin

	PROCESS {


		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/AuthenticationMethods"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		if ($result.Methods) {

			$result.Methods

		}

	}#process

	END { }#end


}