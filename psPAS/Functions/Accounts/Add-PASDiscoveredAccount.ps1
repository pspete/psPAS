function Add-PASDiscoveredAccount {
	<#
.SYNOPSIS
Adds discovered account or SSH key as a pending account in the accounts feed.

.DESCRIPTION
Enables an account or SSH key that is discovered by an external scanner to be added
as a pending account to the Accounts Feed.
Users can identify privileged accounts and determine which are on-boarded to the vault.

.PARAMETER userName
The name of the account user.

.PARAMETER address
The name or address of the machine where the account is located.

.PARAMETER discoveryDate
The date the account was discovered.

.PARAMETER accountEnabled
The state of the account, defined in the discovery source.

.PARAMETER osGroups
The name of the group the account belongs to, such as Administrators or Operators.

.PARAMETER platformType
The platform where the discovered account is located.

.PARAMETER domain
The domain of the account.

.PARAMETER lastLogonDateTime
The date this account was last logged into, defined in the discovery source.

.PARAMETER lastPasswordSetDateTime
The date this password was last set, defined in the discovery source.

.PARAMETER passwordNeverExpires
Whether or not this password expires, defined in the discovery source.

.PARAMETER osVersion
The version of the OS where the account was discovered.

.PARAMETER privileged
Whether the discovered account is privileged or non-privileged.

.PARAMETER privilegedCriteria
The criteria that determines whether or not the discovered account is privileged. For example, the user or group name.

.PARAMETER userDisplayName
The user's display name.

.PARAMETER description
A description of the account, defined in the discovery source.

.PARAMETER passwordExpirationDateTime
The expiration date of the account, defined in the discovery source.

.PARAMETER osFamily
The type of machine where the account was discovered.

.PARAMETER additionalProperties
List of name=value pairs for additional properties added to the account.

.PARAMETER organizationalUnit
The organizational unit where the account is defined.

.PARAMETER SID
Security ID. This parameter is relevant only for Windows accounts.

.PARAMETER uid
The unique user ID. This parameter is relevant only for Unix accounts.

.PARAMETER gid
The unique group ID. This parameter is relevant only for Unix accounts.

.PARAMETER uid
The unique user ID. This parameter is relevant only for Unix SSH Key.

.PARAMETER gid
The unique group ID. This parameter is relevant only for Unix SSH Key.

.PARAMETER fingerprint
The fingerprint of the discovered SSH key. The public and private keys of the same trust have the same fingerprint. This is relevant for SSH keys only.

.PARAMETER size
The size in bits of the generated key.

.PARAMETER path
The path of the public key on the target machine.

.PARAMETER format
The format of the private SSH key.

.PARAMETER comment
Any text added when the key was created.

.PARAMETER encryption
The type of encryption used to generate the SSH key.

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

.EXAMPLE
$token | Add-PASDiscoveredAccount -UserName Discovered23 -Address domain.com -discoveryDate $(Get-Date "29/10/2018") -AccountEnabled $true -platformType "Windows Domain" -SID 12355

Adds matching discovered account as pending account.

.INPUTS
All parameters can be piped by property name

.OUTPUTS

.NOTES

.LINK

#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPassWordParams', '', Justification = "Username not used for authentication")]
	[CmdletBinding(DefaultParameterSetName = "Windows")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$UserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Address,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$discoveryDate,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$AccountEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$osGroups,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("Windows Server Local", "Windows Desktop Local", "Windows Domain", "Unix", "Unix SSH Key")]
		[string]$platformType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Domain,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$lastLogonDateTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$lastPasswordSetDateTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$passwordNeverExpires,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$OSVersion,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("Privileged", "Non-privileged")]
		[string]$privileged,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$privilegedCriteria,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$UserDisplayName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$passwordExpirationDateTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("Workstation", "Server")]
		[string]$osFamily,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[hashtable]$additionalProperties,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$organizationalUnit,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Windows"
		)]
		[string]$SID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Unix"
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "UnixSSHKey"
		)]
		[string]$uid,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Unix"
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "UnixSSHKey"
		)]
		[string]$gid,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "UnixSSHKey"
		)]
		[string]$fingerprint,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "UnixSSHKey"
		)]
		[ValidateSet(1024, 2048, 4096, 8192)]
		[int]$size,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "UnixSSHKey"
		)]
		[string]$path,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "UnixSSHKey"
		)]
		[string]$format,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "UnixSSHKey"
		)]
		[string]$comment,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "UnixSSHKey"
		)]
		[ValidateSet("RSA", "DSA")]
		[string]$encryption,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$sessionToken,

		[parameter(
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
		$MinimumVersion = [System.Version]"10.5"

		$AccountProperties = @("SID", "uid", "gid", "fingerprint", "size", "path", "format", "comment", "encryption")

		$DateTimes = @("discoveryDate", "lastLogonDateTime", "lastPasswordSetDateTime", "passwordExpirationDateTime")

	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$baseURI/$PVWAAppName/api/DiscoveredAccounts"

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		Foreach($DateTime in $DateTimes) {

			if($PSBoundParameters.ContainsKey($DateTime)) {

				Write-Debug "Converting $DateTime to UnixTime"

				#convert to unix time
				$boundParameters["$DateTime"] = Get-Date $PSBoundParameters["$DateTime"] -UFormat %s

			}

		}

		$platformTypeAccountProperties = @{}
		$boundParameters.keys | Where-Object {$AccountProperties -contains $_} | ForEach-Object {

			#add key=value to hashtable
			$platformTypeAccountProperties[$_] = $boundParameters[$_]


		}

		If($platformTypeAccountProperties.Count -gt 0) {

			$boundParameters["platformTypeAccountProperties"] = $platformTypeAccountProperties

		}

		$body = $boundParameters |
			Get-PASParameter -ParametersToRemove $AccountProperties  |
			ConvertTo-Json

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

		if($result) {

			#Return Results
			$result | Add-ObjectDetail -DefaultProperties id, status -PropertyToAdd @{

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