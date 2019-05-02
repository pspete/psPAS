function Add-PASAccount {
	<#
.SYNOPSIS
Adds a new privileged account to the Vault
Uses either the API present from 10.4 onwards, or the version 9 API endpoint.

.DESCRIPTION
Adds a new privileged account to the Vault.
Parameters are processed to create request object from passed parameters in the required format.

.PARAMETER name
The name of the account.
A version 10.4 onward specific parameter

.PARAMETER secretType
The type of password.
A version 10.4 onward specific parameter

.PARAMETER secret
The password value
A version 10.4 onward specific parameter

.PARAMETER platformAccountProperties
key-value pairs to associate with the account, as defined by the account platform.
These properties are validated against the mandatory and optional properties of the specified platform's definition.
A version 10.4 onward specific parameter

.PARAMETER automaticManagementEnabled
Whether CPM Password Management should be enabled
A version 10.4 onward specific parameter

.PARAMETER manualManagementReason
A reason for disabling CPM Password Management
A version 10.4 onward specific parameter

.PARAMETER remoteMachines
For supported platforms, a list of remote machines the account can connect to.
A version 10.4 onward specific parameter

.PARAMETER accessRestrictedToRemoteMachines
Whether access is restricted to the defined remote machines.
A version 10.4 onward specific parameter

.PARAMETER SafeName
The safe where the account will be created

.PARAMETER PlatformID
The CyberArk platform to assign to the account

.PARAMETER Address
The Address of the machine where the account will be used

.PARAMETER AccountName
The name of the account

.PARAMETER Password
The password value as a secure string

.PARAMETER Username
Username on the target machine

.PARAMETER DisableAutoMgmt
Whether or not automatic management wll be disabled for the account

.PARAMETER DisableAutoMgmtReason
The reason why automatic management wll be disabled for the account

.PARAMETER GroupName
A groupname with which the account will be associated

.PARAMETER GroupPlatformID
Group platform to base created group ID on, if ID doesn't exist

.PARAMETER Port
Port number over which the account will be used

.PARAMETER ExtraPass1Name
Logon account name

.PARAMETER ExtraPass1Folder
Folder where logon account is stored

.PARAMETER ExtraPass1Safe
Safe where logon account is stored

.PARAMETER ExtraPass3Name
Reconcile account name

.PARAMETER ExtraPass3Folder
Folder where reconcile account is stored

.PARAMETER ExtraPass3Safe
Safe where reconcile account is stored

.PARAMETER DynamicProperties
Hashtable of name=value pairs

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
$token | Add-PASAccount -address ThisServer -userName ThisUser -platformID UNIXSSH -SafeName UNIXSafe -automaticManagementEnabled $false

Using the version 10 API, adds an account which is disbaled for automatic password management

.EXAMPLE
$token | Add-PASAccount -safe Prod_Access -PlatformID WINDOMAIN -Address domain.com -Password $secureString -username domainUser

Using the "version 9" API, adds account domain.com\domainuser to the Prod_Access Safe using the WINDOMAIN platform.
The contents of $secureString will be set as the password value.

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None for v9
v10.4 outputs th details of the created account.

.NOTES

.LINK

#>
	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[string]$address,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[string]$userName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[Alias("PolicyID")]
		[string]$platformID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("safe")]
		[string]$SafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[ValidateSet("Password", "Key")]
		[string]$secretType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[securestring]$secret,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[hashtable]$platformAccountProperties,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[boolean]$automaticManagementEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[string]$manualManagementReason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[string]$remoteMachines,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[boolean]$accessRestrictedToRemoteMachines,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$accountName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[securestring]$password,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[boolean]$disableAutoMgmt,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$disableAutoMgmtReason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$groupName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$groupPlatformID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[int]$Port,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[ValidateNotNullOrEmpty()]
		[string]$ExtraPass1Name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$ExtraPass1Folder,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[ValidateNotNullOrEmpty()]
		[string]$ExtraPass1Safe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[ValidateNotNullOrEmpty()]
		[string]$ExtraPass3Name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$ExtraPass3Folder,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[ValidateNotNullOrEmpty()]
		[string]$ExtraPass3Safe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[hashtable]$DynamicProperties,

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

		$MinimumVersion = [System.Version]"10.4"

		#The (version 9 API) Add Account JSON object requires specific formatting.
		#Different parameters are contained within the JSON at different depths.
		#Programmatic processing is required to format the JSON as required.

		#V9 baseparameters are contained in JSON object at the same depth
		$baseParameters = @("Safe", "PlatformID", "Address", "AccountName", "Password", "Username",
			"DisableAutoMgmt", "DisableAutoMgmtReason", "GroupName", "GroupPlatformID")

		#V10 parameters are nested under JSON object properties
		$remoteMachine = @("remoteMachines", "accessRestrictedToRemoteMachines")
		$SecretMgmt = @("automaticManagementEnabled", "manualManagementReason")

	}#begin

	PROCESS {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#declare empty array to hold keys to remove from bound parameters
		[array]$keysToRemove = @()

		if ($PSCmdlet.ParameterSetName -eq "V10") {

			Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for Request
			$URI = "$baseURI/$PVWAAppName/api/Accounts"

			#deal with "secret" SecureString
			If ($PSBoundParameters.ContainsKey("secret")) {

				#Include decoded password in request
				$boundParameters["secret"] = $(ConvertTo-InsecureString -SecureString $secret)

			}

			$remoteMachinesAccess = @{ }
			$boundParameters.keys | Where-Object { $remoteMachine -contains $_ } | ForEach-Object {

				#add key=value to hashtable
				$remoteMachinesAccess[$_] = $boundParameters[$_]


			}

			$secretManagement = @{ }
			$boundParameters.keys | Where-Object { $SecretMgmt -contains $_ } | ForEach-Object {

				#add key=value to hashtable
				$secretManagement[$_] = $boundParameters[$_]

			}

			$boundParameters["remoteMachinesAccess"] = $remoteMachinesAccess
			$boundParameters["secretManagement"] = $secretManagement

			$body = $boundParameters |
			Get-PASParameter -ParametersToRemove @($remoteMachine + $SecretMgmt) |
			ConvertTo-Json -depth 4

		}

		if ($PSCmdlet.ParameterSetName -eq "V9") {

			#Create URL for Request
			$URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Account"

			#deal with Password SecureString
			If ($PSBoundParameters.ContainsKey("password")) {

				#Include decoded password in request
				$boundParameters["password"] = $(ConvertTo-InsecureString -SecureString $password)

			}

			#Process for required formatting - fix V10 specific parameter names
			$boundParameters["safe"] = $SafeName
			$boundParameters["username"] = $userName

			$boundParameters.remove("SafeName")
			$boundParameters.remove("userName")
			#declare empty hashtable to hold "non-base" parameters
			$properties = @{ }

			#Get "non-base" parameters
			$boundParameters.keys | Where-Object { $baseParameters -notcontains $_ } | ForEach-Object {

				#For all "non-base" parameters except "DynamicProperties"
				if ($_ -ne "DynamicProperties") {

					#Add key/Value to "properties" hashtable
					$properties[$_] = $boundParameters[$_]

				}

				Else {
					#for DynamicProperties key=value pairs

					#Enumerate DynamicProperties object
					$boundParameters[$_].getenumerator() | ForEach-Object {

						#add key=value to "properties" hashtable
						$properties[$_.name] = $_.value

					}
				}

				#add the "non-base" parameter key to array
				$keysToRemove = $keysToRemove + $_

			}

			#Add "non-base" parameter hashtable as value of "properties" on boundparameters object
			$boundParameters["properties"] = @($properties.getenumerator() | ForEach-Object { $_ })

			#Create body of request
			$body = @{

				#account node does not contain non-base parameters
				"account" = $boundParameters | Get-PASParameter -ParametersToRemove $keysToRemove

				#ensure nodes at all required depths are included in the JSON object
			} | ConvertTo-Json -Depth 4

		}

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

		if ($PSCmdlet.ParameterSetName -eq "V10") {

			if ($result) {

				#Return Results
				$result | Add-ObjectDetail -typename "psPAS.CyberArk.Vault.Account.V10" -PropertyToAdd @{

					"sessionToken"    = $sessionToken
					"WebSession"      = $WebSession
					"BaseURI"         = $BaseURI
					"PVWAAppName"     = $PVWAAppName
					"ExternalVersion" = $ExternalVersion

				}

			}

		}

	}#process

	END { }#end
}