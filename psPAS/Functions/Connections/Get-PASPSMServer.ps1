Function Get-PASPSMServer {
	<#
.SYNOPSIS
Lists configured PSM Servers

.DESCRIPTION
Allows Vault admins to get a list of all PSM servers defined for an environment.

.EXAMPLE
Get-PASPSMServer

Lists all configured PSM Servers
#>
	[CmdletBinding()]
	param(	)

	BEGIN {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion 11.5

	}#begin

	PROCESS {


		#Create URL for request
		$URI = "$Script:BaseURI/API/PSM/Servers"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		if ($result.PSMServers) {

			$result | Select-Object -ExpandProperty PSMServers

		}

	}#process

	END { }#end

}