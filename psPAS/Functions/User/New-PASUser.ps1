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
Requires CyberArk version 10.9+

.PARAMETER unAuthorizedInterfaces
The CyberArk interfaces that this user is not authorized to use.
Requires CyberArk version 10.9+

.PARAMETER enableUser
Whether the user will be enabled upon creation.
Requires CyberArk version 10.9+

.PARAMETER authenticationMethod
The authentication method that the user will use to log on.
Valid Values:
"AuthTypePass", for CyberArk Authentication (default)
"AuthTypeLDAP", for LDAP authentication
"AuthTypeRADIUS", for RADIUS authentication
Requires CyberArk version 10.9+

.PARAMETER passwordNeverExpires
Whether or not the user's password will expire
Requires CyberArk version 10.9+

.PARAMETER distinguishedName
The distinguished name of the user.
Requires CyberArk version 10.9+

.PARAMETER vaultAuthorization
The user permissions in the vault.
To grant authorization to a user, the same authorization must be held by the account logged on to the API.
Valid values:
� AddSafes
� AuditUsers
� AddUpdateUsers
� ResetUsersPasswords
� ActivateUsers
� AddNetworkAreas
� ManageDirectoryMapping
� ManageServerFileCategories
� BackupAllSafes
� RestoreAllSafes
Requires CyberArk version 10.9+

.PARAMETER ChangePassOnNextLogon
Whether or not user will be forced to change password on first logon
Requires CyberArk version 10.9+

.PARAMETER workStreet
Business Address detail for the user
Requires CyberArk version 10.9+

.PARAMETER workCity
Business Address detail for the user
Requires CyberArk version 10.9+

.PARAMETER workState
Business Address detail for the user
Requires CyberArk version 10.9+

.PARAMETER workZip
Business Address detail for the user
Requires CyberArk version 10.9+

.PARAMETER workCountry
Business Address detail for the user
Requires CyberArk version 10.9+

.PARAMETER homePage
The user's email address
Requires CyberArk version 10.9+

.PARAMETER homeEmail
The user's email address
Requires CyberArk version 10.9+

.PARAMETER businessEmail
The user's email address
Requires CyberArk version 10.9+

.PARAMETER otherEmail
The user's email address
Requires CyberArk version 10.9+

.PARAMETER homeNumber
The user's phone number
Requires CyberArk version 10.9+

.PARAMETER businessNumber
The user's phone number
Requires CyberArk version 10.9+

.PARAMETER cellularNumber
The user's phone number
Requires CyberArk version 10.9+

.PARAMETER faxNumber
The user's phone number
Requires CyberArk version 10.9+

.PARAMETER pagerNumber
The user's phone number
Requires CyberArk version 10.9+

.PARAMETER description
Description Text
Requires CyberArk version 10.9+

.PARAMETER MiddleName
The User's Middle Name
Requires CyberArk version 10.9+

.PARAMETER street
Address detail for the user
Requires CyberArk version 10.9+

.PARAMETER city
Address detail for the user
Requires CyberArk version 10.9+

.PARAMETER state
Address detail for the user
Requires CyberArk version 10.9+

.PARAMETER zip
Address detail for the user
Requires CyberArk version 10.9+

.PARAMETER country
Address detail for the user
Requires CyberArk version 10.9+

.PARAMETER title
Personal detail for the user
Requires CyberArk version 10.9+

.PARAMETER organization
Personal detail for the user
Requires CyberArk version 10.9+

.PARAMETER department
Personal detail for the user
Requires CyberArk version 10.9+

.PARAMETER profession
Personal detail for the user
Requires CyberArk version 10.9+

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
Whether or not the user will be created as a disabled user
Default is Enabled

.PARAMETER Location
The Vault Location where the user will be created
Default location is "Root"

.PARAMETER UseClassicAPI
Specify the UseClassicAPI to force usage the Classic (v9) API endpoint.

.EXAMPLE
New-PASUser -UserName NewUser -InitialPassword $securePWD -UseClassicAPI

Creates a Vault user named NewUser, with password set to securestring value from $securePWD, using the v9 (classic) API

.EXAMPLE
New-PASUser -UserName NewUser -InitialPassword $securePWD

Creates a Vault user named NewUser, with password set to securestring value from $securePWD

.EXAMPLE
New-PASUser -UserName NewUser -InitialPassword $securePWD -unAuthorizedInterfaces "PACLI" -vaultAuthorization ManageDirectoryMapping

Creates a Vault user as per the provided parameter values

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.User
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.LINK
https://pspas.pspete.dev/commands/New-PASUser
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
		[boolean]$ChangePassOnNextLogon,

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
		[switch]$UseClassicAPI
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

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for request
			$URI = "$Script:BaseURI/api/Users"

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
			$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Users"

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
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

			if ($result) {


				$result | Add-ObjectDetail -typename $typeName

			}

		}

	}#process

	END { }#end

}