function Add-PASDirectory {
	<#
.SYNOPSIS
Adds an LDAP directory to the Vault

.DESCRIPTION
Adds an LDAP directory to the Vault.
Membership of the Vault Admins group required.

.PARAMETER DirectoryType
The name of the directory profile file that the Vault will use when working with the specified LDAP directory.

.PARAMETER HostAddresses
List of IP addresses of the host servers where the External Directories exist.
If the Vault will use an SSL connection to connect to the External Directory, this name must match the subject
that appears in the Directory certificate

.PARAMETER BindUsername
The username of the account used to bind to the directory

.PARAMETER BindPassword
A SecureString containing the password for the Bind User

.PARAMETER DCList
Applies to 10.7+; an array of hashtables containing
LDAPDomainController information.

.PARAMETER Port
The port that will be used to access the specified server.
The standard port for SSL LDAP connections is 636, and for non-SSL LDAP connections is 389

.PARAMETER DomainName
The address of the domain

.PARAMETER DomainBaseContext
The base context of the External Directory.

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
$token | Add-PASDirectory -DirectoryType "MicrosoftADProfile.ini" -HostAddresses "192.168.60.1","192.168.60.100" -BindUsername "CABind" -BindPassword $pw -Port 389 -DomainName "DOMAIN.COM" -DomainBaseContext "DC=DOMAIN,DC=COM"

Adds the Domain.Com directory to the vault

.EXAMPLE
$token | Add-PASDirectory -DirectoryType "MicrosoftADProfile.ini" -BindUsername "bind@domain.com" -BindPassword $pw -DomainName DOMAIN `
-DomainBaseContext "DC=DOMAIN,DC=COM" -DCList @(@{"Name"="192.168.99.1";"Port"=389;"SSLConnect"=$false},@{"Name"="192.168.99.1";"Port"=389;"SSLConnect"=$false}) -Port 389

(For 10.7+) - Adds the Domain.Com directory to the vault

.INPUTS
All parameters can be piped to the function by propertyname

.OUTPUTS
LDAP Directory Details

.NOTES

.LINK

#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlaintextForPassword', '', Justification = "It's a path to password object")]
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$DirectoryType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10_4"
		)]
		[string[]]$HostAddresses,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BindUsername,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[securestring]$BindPassword,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateRange(1, 65535)]
		[int]$Port,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10_7"
		)]
		[hashtable[]]$DCList,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$DomainName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$DomainBaseContext,

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
		$MinimumVersion = [System.Version]"10.4"
		$RequiredVersion = [System.Version]"10.7"
	}#begin

	PROCESS {

		if ($PSCmdlet.ParameterSetName -eq "v10_7") {

			Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $RequiredVersion

		} Elseif ($PSCmdlet.ParameterSetName -eq "v10_4") {

			Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		}

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/api/Configuration/LDAP/Directories"

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#deal with BindPassword SecureString
		If ($PSBoundParameters.ContainsKey("BindPassword")) {

			#Include decoded bind password in request
			$boundParameters["BindPassword"] = $(ConvertTo-InsecureString -SecureString $BindPassword)

		}

		$body = $boundParameters | ConvertTo-Json
		write-debug $body
		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

		If ($result) {

			#Return Results
			$result |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.Directory.Extended -PropertyToAdd @{

				"sessionToken"    = $sessionToken
				"WebSession"      = $WebSession
				"BaseURI"         = $BaseURI
				"PVWAAppName"     = $PVWAAppName
				"ExternalVersion" = $ExternalVersion

			}

		}

	}#process

	END { }#end
}