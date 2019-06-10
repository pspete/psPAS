function Remove-PASDirectory {
	<#
.SYNOPSIS
Removes an LDAP directory configured in the Vault

.DESCRIPTION
Removes an LDAP directory configuration from the vault.
Membership of the Vault Admins group required.

.PARAMETER id
The ID or Name of the directory to return information on.

.EXAMPLE
Remove-PASDirectory -id LDAPDirectory

Removes LDAP directory configured in the Vault

.INPUTS
WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
LDAP Directory Details

.NOTES

.LINK

#>
	[CmdletBinding(SupportsShouldProcess = $true)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("DomainName")]
		[string]$id

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.7"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/api/Configuration/LDAP/Directories/$id"

		if($PSCmdlet.ShouldProcess($id, "Delete Directory")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}