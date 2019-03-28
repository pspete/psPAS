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

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.PARAMETER ExternalVersion
The External CyberArk Version, returned automatically from the New-PASSession function from version 9.7 onwards.
If the minimum version requirement of this function is not satisfied, execution will be halted.
Omitting a value for this parameter, or supplying a version of "0.0" will skip the version check.

.EXAMPLE
$token | Get-PASDirectory |  Get-PASDirectoryMapping

Returns LDAP directory mappings configured for each directory.

.EXAMPLE
$token | Get-PASDirectoryMapping -DirectoryName SomeDir -MappingID "User_Mapping"

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
		[string]$MappingID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$sessionToken,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = "PasswordVault",

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[System.Version]$ExternalVersion = "0.0"
	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.7"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/api/Configuration/LDAP/Directories/$DirectoryName/Mappings"

		if($PSCmdlet.ParameterSetName -eq "Mapping") {

			#Update URL for request
			$URI = "$URI/$MappingID"

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

		If($result) {

			#Return Results
			$result |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.Directory.Mapping -PropertyToAdd @{

				"sessionToken"    = $sessionToken
				"WebSession"      = $WebSession
				"BaseURI"         = $BaseURI
				"PVWAAppName"     = $PVWAAppName
				"ExternalVersion" = $ExternalVersion

			}

		}

	}#process

	END {}#end
}