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
Requires CyberArk version 10.5+

.EXAMPLE
Get-PASDirectory

Returns LDAP directories configured in the Vault

.INPUTS
WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
LDAP Directory Details

.LINK
https://pspas.pspete.dev/commands/Get-PASDirectory
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10.5"
		)]
		[Alias("DomainName")]
		[string]$id

	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 10.4

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/LDAP/Directories"

		switch ($PSCmdlet.ParameterSetName) {

			"10.5" {

				Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName

				#Update URL for request
				$URI = "$URI/$id/"

				$type = "psPAS.CyberArk.Vault.Directory.Extended"

				break

			}

			default {

				$type = "psPAS.CyberArk.Vault.Directory"

				break

			}

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename $type

		}

	}#process

	END { }#end
}