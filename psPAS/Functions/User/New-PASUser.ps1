function New-PASUser {
	<#
.SYNOPSIS
Creates a new vault user

.DESCRIPTION
Adds a new user to the vault

.PARAMETER UserName
The name of the user to create in the vault


.PARAMETER InitialPassword
The password to set on the account, as a Secure String
Must meet the password complexity requirements

.PARAMETER userType
The user type

.PARAMETER unAuthorizedInterfaces
The CyberArk interfaces that this user is not authorized to use.

.PARAMETER enableUser
Whether the user will be enabled upon creation.

.PARAMETER authenticationMethod
The authentication method that the user will use to log on.
Valid Values:
"AuthTypePass", for CyberArk Authentication (default)
"AuthTypeLDAP", for LDAP authentication
"AuthTypeRADIUS", for RADIUS authentication

.PARAMETER passwordNeverExpires
Whether or not the user's password will expire

.PARAMETER distinguishedName
The distinguished name of the user.

.PARAMETER vaultAuthorization
The user permissions in the vault.
To grant authorization to a user, the same authorization must be held by the account logged on to the API.
Valid values:
• AddSafes
• AuditUsers
• AddUpdateUsers
• ResetUsersPasswords
• ActivateUsers
• AddNetworkAreas
• ManageDirectoryMapping
• ManageServerFileCategories
• BackupAllSafes
• RestoreAllSafes

.PARAMETER workStreet
Business Address detail for the user

.PARAMETER workCity
Business Address detail for the user

.PARAMETER workState
Business Address detail for the user

.PARAMETER workZip
Business Address detail for the user

.PARAMETER workCountry
Business Address detail for the user

.PARAMETER homePage
The user's email address

.PARAMETER homeEmail
The user's email address

.PARAMETER businessEmail
The user's email address

.PARAMETER otherEmail
The user's email address

.PARAMETER homeNumber
The user's phone number

.PARAMETER businessNumber
The user's phone number

.PARAMETER cellularNumber
The user's phone number

.PARAMETER faxNumber
The user's phone number

.PARAMETER pagerNumber
The user's phone number

.PARAMETER description
Description Text

.PARAMETER MiddleName
The User's Middle Name

.PARAMETER street
Address detail for the user

.PARAMETER city
Address detail for the user

.PARAMETER state
Address detail for the user

.PARAMETER zip
Address detail for the user

.PARAMETER country
Address detail for the user

.PARAMETER title
Personal detail for the user

.PARAMETER organization
Personal detail for the user

.PARAMETER department
Personal detail for the user

.PARAMETER profession
Personal detail for the user

.PARAMETER Email
The user's email address

.PARAMETER FirstName
The user's first name

.PARAMETER LastName
The user's last name

.PARAMETER ChangePasswordOnTheNextLogon
Whether or not user will be forced to change password on first logon

.PARAMETER ExpiryDate
Expiry Date to set on account.
Default is Never

.PARAMETER UserTypeName
The Type of User to create.
EPVUser type will be created by default.

.PARAMETER Disabled
Whether or not the user will be created as a disbaled user
Default is Enabled

.PARAMETER Location
The Vault Location where the user will be created
Default location is "Root"

.PARAMETER UseV9API
Specify the UseV9API to send the authentication request via the v9 API endpoint.

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
$token | New-PASUser -UserName NewUser -InitialPassword $securePWD -UseV9API

Creates a Vault user named NewUser, with password set to securestring value from $securePWD, using the v9 (classic) API

.EXAMPLE
$token | New-PASUser -UserName NewUser -InitialPassword $securePWD

Creates a Vault user named NewUser, with password set to securestring value from $securePWD

.EXAMPLE
$token | New-PASUser -UserName NewUser -InitialPassword $securePWD -unAuthorizedInterfaces "PACLI" -vaultAuthorization ManageDirectoryMapping

Creates a Vault user as per the provided parameter values

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.User
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK

#>
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "10_9")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[ValidateLength(0, 128)]
		[string]$UserName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[securestring]$InitialPassword,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[string]$userType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateSet("PIMSU", "PSM", "PSMP", "PVWA", "WINCLIENT", "PTA", "PACLI", "NAPI", "XAPI", "HTTPGW",
			"EVD", "PIMSu", "AIMApp", "CPM", "PVWAApp", "PSMApp", "AppPrv", "AIMApp", "PSMPApp")]
		[string[]]$unAuthorizedInterfaces,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[boolean]$enableUser,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateSet("AuthTypePass", "AuthTypeLDAP", "AuthTypeRADIUS")]
		[string[]]$authenticationMethod,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[string]$Email,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[boolean]$ChangePasswordOnTheNextLogon,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[boolean]$passwordNeverExpires,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[string]$distinguishedName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateSet("AddSafes", "AuditUsers", "AddUpdateUsers", "ResetUsersPasswords", "ActivateUsers",
			"AddNetworkAreas", "ManageDirectoryMapping", "ManageServerFileCategories", "BackupAllSafes",
			"RestoreAllSafes")]
		[string[]]$vaultAuthorization,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[datetime]$ExpiryDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[string]$UserTypeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[boolean]$Disabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[string]$Location,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 29)]
		[string]$workStreet,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 19)]
		[string]$workCity,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 19)]
		[string]$workState,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 19)]
		[string]$workZip,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 19)]
		[string]$workCountry,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 319)]
		[string]$homePage,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 319)]
		[string]$homeEmail,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 319)]
		[string]$businessEmail,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 319)]
		[string]$otherEmail,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 24)]
		[string]$homeNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 24)]
		[string]$businessNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 24)]
		[string]$cellularNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 24)]
		[string]$faxNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 24)]
		[string]$pagerNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 99)]
		[string]$description,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[ValidateLength(0, 29)]
		[string]$FirstName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 29)]
		[string]$MiddleName,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[ValidateLength(0, 29)]
		[string]$LastName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 29)]
		[string]$street,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 19)]
		[string]$city,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 19)]
		[string]$state,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 19)]
		[string]$zip,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 19)]
		[string]$country,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 49)]
		[string]$title,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 49)]
		[string]$organization,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 49)]
		[string]$department,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[ValidateLength(0, 49)]
		[string]$profession,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "legacy"
		)]
		[switch]$UseV9API,

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
		$MinimumVersion = [System.Version]"10.9"
		$businessAddressParams = @("workStreet", "workCity", "workState", "workZip", "workCountry")
		$internetParams = @("homePage", "homeEmail", "businessEmail", "otherEmail")
		$phonesParams = @("homeNumber", "businessNumber", "cellularNumber", "faxNumber", "pagerNumber")
		$personalDetailsParams = @("street", "city", "state", "zip", "country", "title", "organization",
			"department", "profession", "FirstName", "middleName", "LastName")
	}#begin

	PROCESS {

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter

		If ($PSBoundParameters.ContainsKey("InitialPassword")) {

			#Include decoded password in request
			$boundParameters["InitialPassword"] = $(ConvertTo-InsecureString -SecureString $InitialPassword)

		}

		If ($PSCmdlet.ParameterSetName -eq "10_9") {

			Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for request
			$URI = "$baseURI/$PVWAAppName/api/Users"

			If ($PSBoundParameters.ContainsKey("ExpiryDate")) {

				#Convert ExpiryDate to string in Required format
				$Date = $([math]::Round($(New-TimeSpan -Start $(Get-Date 1/1/1970) -End $ExpiryDate | Select-Object -ExpandProperty TotalSeconds))).ToString()

				#Include date string in request
				$boundParameters["ExpiryDate"] = $Date

			}

			$businessAddress = @{ }
			$internet = @{ }
			$phones = @{ }
			$personalDetails = @{ }

			$boundParameters.keys | Where-Object { $businessAddressParams -contains $_ } | ForEach-Object {

				#add key=value to hashtable
				$businessAddress[$_] = $boundParameters[$_]


			}

			$boundParameters.keys | Where-Object { $internetParams -contains $_ } | ForEach-Object {

				#add key=value to hashtable
				$internet[$_] = $boundParameters[$_]

			}

			$boundParameters.keys | Where-Object { $phonesParams -contains $_ } | ForEach-Object {

				#add key=value to hashtable
				$phones[$_] = $boundParameters[$_]


			}

			$boundParameters.keys | Where-Object { $personalDetailsParams -contains $_ } | ForEach-Object {

				#add key=value to hashtable
				$personalDetails[$_] = $boundParameters[$_]

			}

			$boundParameters["businessAddress"] = $businessAddress
			$boundParameters["internet"] = $internet
			$boundParameters["phones"] = $phones
			$boundParameters["personalDetails"] = $personalDetails

			#Construct Request Body
			$body = $boundParameters |
			Get-PASParameter -ParametersToRemove @($businessAddressParams + $internetParams + $phonesParams + $personalDetailsParams) |
			ConvertTo-Json -depth 4

			$TypeName = "psPAS.CyberArk.Vault.User.Extended"

		}

		ElseIf ($PSCmdlet.ParameterSetName -eq "legacy") {

			#Create URL for request
			$URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Users"

			If ($PSBoundParameters.ContainsKey("ExpiryDate")) {

				#Convert ExpiryDate to string in Required format
				$Date = (Get-Date $ExpiryDate -Format MM/dd/yyyy).ToString()

				#Include date string in request
				$boundParameters["ExpiryDate"] = $Date

			}

			#Construct Request Body
			$body = $boundParameters | ConvertTo-Json

			$TypeName = "psPAS.CyberArk.Vault.User"

		}

		if ($PSCmdlet.ShouldProcess($UserName, "Create User")) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

			if ($result) {


				$result | Add-ObjectDetail -typename $typeName -PropertyToAdd @{

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