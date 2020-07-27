Function Get-PASConnectionComponent {
	<#
.SYNOPSIS
Returns configured connection components

.DESCRIPTION
Allows Vault admins to get the list of all connection components of an entire environment.

.EXAMPLE
Get-PASConnectionComponent

Lists all connection components configred in the environment

#>
	[CmdletBinding()]
	param(	)

	BEGIN {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion 11.5

	}#begin

	PROCESS {


		#Create URL for request
		$URI = "$Script:BaseURI/API/PSM/Connectors"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		if ($result.PSMConnectors) {

			$result | Select-Object -ExpandProperty PSMConnectors

		}

	}#process

	END { }#end

}