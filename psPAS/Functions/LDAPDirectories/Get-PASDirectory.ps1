function Get-PASDirectory {
	<#
.SYNOPSIS
Get LDAP directories configured in the Vault

.DESCRIPTION
Returns a list of existing directories in the Vault.
Each directory will be returned with its own data.
Membership of the Vault Admins group required.

.PARAMETER id
The ID or Name of the directory to return information on.

.EXAMPLE
Get-PASDirectory

Returns LDAP directories configured in the Vault

.INPUTS
WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
LDAP Directory Details

.NOTES

.LINK

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10_5"
		)]
		[Alias("DomainName")]
		[string]$id

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.4"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/api/Configuration/LDAP/Directories"

		if($PSCmdlet.ParameterSetName -eq "v10_5") {

			[System.Version]$RequiredVersion = "10.5"
			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $RequiredVersion

			#Update URL for request
			$URI = "$URI/$id/"

			$type = "psPAS.CyberArk.Vault.Directory.Extended"

		} Else {$type = "psPAS.CyberArk.Vault.Directory"}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If($result) {

			#Return Results
			$result |

			Add-ObjectDetail -typename $type

		}

	}#process

	END {}#end
}