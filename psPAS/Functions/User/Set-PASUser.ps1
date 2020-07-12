function Set-PASUser {
	<#
.SYNOPSIS
Updates a vault user

.DESCRIPTION
Updates an existing user in the vault
Appears to require all properties set on a user to be passed with the request.
Not passing a value to an already set property will result in it being cleared.

.PARAMETER id
The numeric id of the user to update.
Requires CyberArk version 11.1+

.PARAMETER UserName
The name of the user to create in the vault

.PARAMETER NewPassword
A new password to set on the account, as a Secure String
Must meet the password complexity requirements

.PARAMETER userType
The user type
Requires CyberArk version 11.1+

.PARAMETER suspended
The user suspension status
Requires CyberArk version 11.1+

.PARAMETER unAuthorizedInterfaces
The CyberArk interfaces that this user is not authorized to use.
Requires CyberArk version 11.1+

.PARAMETER enableUser
Whether the user will be enabled upon creation.
Requires CyberArk version 11.1+

.PARAMETER authenticationMethod
The authentication method that the user will use to log on.
Valid Values:
"AuthTypePass", for CyberArk Authentication (default)
"AuthTypeLDAP", for LDAP authentication
"AuthTypeRADIUS", for RADIUS authentication
Requires CyberArk version 11.1+

.PARAMETER passwordNeverExpires
Whether or not the user's password will expire
Requires CyberArk version 11.1+

.PARAMETER distinguishedName
The distinguished name of the user.
Requires CyberArk version 11.1+

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
Requires CyberArk version 11.1+

.PARAMETER ChangePassOnNextLogon
Whether or not user will be forced to change password on first logon
Requires CyberArk version 11.1+

.PARAMETER workStreet
Business Address detail for the user
Requires CyberArk version 11.1+

.PARAMETER workCity
Business Address detail for the user
Requires CyberArk version 11.1+

.PARAMETER workState
Business Address detail for the user
Requires CyberArk version 11.1+

.PARAMETER workZip
Business Address detail for the user
Requires CyberArk version 11.1+

.PARAMETER workCountry
Business Address detail for the user
Requires CyberArk version 11.1+

.PARAMETER homePage
The user's email address
Requires CyberArk version 11.1+

.PARAMETER homeEmail
The user's email address
Requires CyberArk version 11.1+

.PARAMETER businessEmail
The user's email address
Requires CyberArk version 11.1+

.PARAMETER otherEmail
The user's email address
Requires CyberArk version 11.1+

.PARAMETER homeNumber
The user's phone number
Requires CyberArk version 11.1+

.PARAMETER businessNumber
The user's phone number
Requires CyberArk version 11.1+

.PARAMETER cellularNumber
The user's phone number
Requires CyberArk version 11.1+

.PARAMETER faxNumber
The user's phone number
Requires CyberArk version 11.1+

.PARAMETER pagerNumber
The user's phone number
Requires CyberArk version 11.1+

.PARAMETER description
Description Text
Requires CyberArk version 11.1+

.PARAMETER MiddleName
The User's Middle Name
Requires CyberArk version 11.1+

.PARAMETER street
Address detail for the user
Requires CyberArk version 11.1+

.PARAMETER city
Address detail for the user
Requires CyberArk version 11.1+

.PARAMETER state
Address detail for the user
Requires CyberArk version 11.1+

.PARAMETER zip
Address detail for the user
Requires CyberArk version 11.1+

.PARAMETER country
Address detail for the user
Requires CyberArk version 11.1+

.PARAMETER title
Personal detail for the user
Requires CyberArk version 11.1+

.PARAMETER organization
Personal detail for the user
Requires CyberArk version 11.1+

.PARAMETER department
Personal detail for the user
Requires CyberArk version 11.1+

.PARAMETER profession
Personal detail for the user
Requires CyberArk version 11.1+

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
set-pasuser -UserName Bill -Disabled $true

Disables vault user Bill

.LINK
https://pspas.pspete.dev/commands/Set-PASUser
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[int]$id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[ValidateLength(0, 128)]
		[string]$username,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[securestring]$NewPassword,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[string]$userType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[boolean]$suspended,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateSet("PIMSU", "PSM", "PSMP", "PVWA", "WINCLIENT", "PTA", "PACLI", "NAPI", "XAPI", "HTTPGW",
			"EVD", "PIMSu", "AIMApp", "CPM", "PVWAApp", "PSMApp", "AppPrv", "AIMApp", "PSMPApp")]
		[string[]]$unAuthorizedInterfaces,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[boolean]$enableUser,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
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
			ParameterSetName = "11_1"
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
			ParameterSetName = "11_1"
		)]
		[boolean]$passwordNeverExpires,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[string]$distinguishedName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateSet("AddSafes", "AuditUsers", "AddUpdateUsers", "ResetUsersPasswords", "ActivateUsers",
			"AddNetworkAreas", "ManageDirectoryMapping", "ManageServerFileCategories", "BackupAllSafes",
			"RestoreAllSafes")]
		[string[]]$vaultAuthorization,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
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
			ParameterSetName = "11_1"
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
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 29)]
		[string]$workStreet,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 19)]
		[string]$workCity,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 19)]
		[string]$workState,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 19)]
		[string]$workZip,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 19)]
		[string]$workCountry,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 319)]
		[string]$homePage,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 319)]
		[string]$homeEmail,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 319)]
		[string]$businessEmail,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 319)]
		[string]$otherEmail,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 24)]
		[string]$homeNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 24)]
		[string]$businessNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 24)]
		[string]$cellularNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 24)]
		[string]$faxNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 24)]
		[string]$pagerNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 99)]
		[string]$description,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
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
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 29)]
		[string]$MiddleName,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
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
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 29)]
		[string]$street,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 19)]
		[string]$city,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 19)]
		[string]$state,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 19)]
		[string]$zip,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 19)]
		[string]$country,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 49)]
		[string]$title,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 49)]
		[string]$organization,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateLength(0, 49)]
		[string]$department,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
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
		$MinimumVersion = [System.Version]"11.1"
		$businessAddressParams = @("workStreet", "workCity", "workState", "workZip", "workCountry")
		$internetParams = @("homePage", "homeEmail", "businessEmail", "otherEmail")
		$phonesParams = @("homeNumber", "businessNumber", "cellularNumber", "faxNumber", "pagerNumber")
		$personalDetailsParams = @("street", "city", "state", "zip", "country", "title", "organization",
			"department", "profession", "FirstName", "middleName", "LastName")
	}#begin

	PROCESS {

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#deal with newPassword SecureString
		If ($PSBoundParameters.ContainsKey("NewPassword")) {

			#Include decoded password in request
			$boundParameters["NewPassword"] = $(ConvertTo-InsecureString -SecureString $NewPassword)

		}

		If ($PSCmdlet.ParameterSetName -eq "11_1") {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for request
			$URI = "$Script:BaseURI/api/Users/$id"

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

			If ($businessAddress.keys -gt 0) {

				$boundParameters["businessAddress"] = $businessAddress

			}

			$boundParameters.keys | Where-Object { $internetParams -contains $_ } | ForEach-Object {

				#add key=value to hashtable
				$internet[$_] = $boundParameters[$_]

			}

			If ($internet.keys -gt 0) {

				$boundParameters["internet"] = $internet

			}

			$boundParameters.keys | Where-Object { $phonesParams -contains $_ } | ForEach-Object {

				#add key=value to hashtable
				$phones[$_] = $boundParameters[$_]


			}

			If ($phones.keys -gt 0) {

				$boundParameters["phones"] = $phones

			}

			$boundParameters.keys | Where-Object { $personalDetailsParams -contains $_ } | ForEach-Object {

				#add key=value to hashtable
				$personalDetails[$_] = $boundParameters[$_]

			}

			If ($personalDetails.keys -gt 0) {

				$boundParameters["personalDetails"] = $personalDetails

			}

			#Prepare Request Body
			$boundParameters = $boundParameters | Get-PASParameter -ParametersToRemove @("id", $businessAddressParams + $internetParams + $phonesParams + $personalDetailsParams)

			$TypeName = "psPAS.CyberArk.Vault.User.Extended"

		}

		ElseIf ($PSCmdlet.ParameterSetName -eq "legacy") {

			If ($PSBoundParameters.ContainsKey("ExpiryDate")) {

				#Convert ExpiryDate to string in Required format
				$Date = (Get-Date $ExpiryDate -Format MM/dd/yyyy).ToString()

				#Include date string in request
				$boundParameters["ExpiryDate"] = $Date

			}

			#Create URL for request
			$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)"

			$TypeName = "psPAS.CyberArk.Vault.User"

			#Prepare Request Body
			$boundParameters = $boundParameters | Get-PASParameter -ParametersToRemove UserName

		}

		#Construct Request Body
		$body = $boundParameters | ConvertTo-Json -depth 4

		if ($PSCmdlet.ShouldProcess($UserName, "Update User Properties")) {
			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -WebSession $Script:WebSession

			if ($result) {

				$result | Add-ObjectDetail -typename $TypeName

			}

		}

	}#process

	END { }#end

}