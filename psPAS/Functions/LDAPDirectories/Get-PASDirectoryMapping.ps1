function Get-PASDirectoryMapping {
	<#
.SYNOPSIS
Get directory mappings configured for a directory

.DESCRIPTION
Returns a list of existing directory mappings in the Vault.
Membership of the Vault Admins group required.

.PARAMETER DirectoryName
The ID or Name of the directory to return data on.

.PARAMETER MappingID
The ID or Name of the directory mapping to return information on.

.EXAMPLE
Get-PASDirectory |  Get-PASDirectoryMapping

Returns LDAP directory mappings configured for each directory.

.EXAMPLE
Get-PASDirectoryMapping -DirectoryName SomeDir -MappingID "User_Mapping"

Returns information on the User_Mapping for SomeDir

.INPUTS
WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
LDAP Directory Mapping Details

.NOTES

.LINK

#>
	[CmdletBinding(DefaultParameterSetName = "All")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "All"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Mapping"
		)]
		[Alias("DomainName")]
		[string]$DirectoryName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Mapping"
		)]
		[string]$MappingID

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.7"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/LDAP/Directories/$DirectoryName/Mappings"

		if($PSCmdlet.ParameterSetName -eq "Mapping") {

			#Update URL for request
			$URI = "$URI/$MappingID"

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If($result) {

			#Return Results
			$result |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.Directory.Mapping

		}

	}#process

	END {}#end
}