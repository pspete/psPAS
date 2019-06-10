function Get-PASUserLoginInfo {
	<#
.SYNOPSIS
Get Login information for the current user

.DESCRIPTION
Returns data about the User that is currently logged into the system

.EXAMPLE
Get-PASUserLoginInfo

Returns Login Info for the current user

.INPUTS
WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
Last successful & failed logon times for the current user

.NOTES

.LINK

#>
	[CmdletBinding()]
	param(	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.4"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/api/LoginsInfo"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $WebSession

		If($result) {

			#Return Results
			$result |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.User.Login

		}

	}#process

	END {}#end

}