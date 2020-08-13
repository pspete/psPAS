Function Add-PASAuthenticationMethod {
	<#
.SYNOPSIS
Adds a new authentication method

.DESCRIPTION
Adds a new authentication method.
Membership of Vault admins group required.

.PARAMETER id
The authentication module unique identifier.

.PARAMETER displayName
The display name of the authentication method.

.PARAMETER enabled
Whether or not the authentication method is enabled for use.

.PARAMETER mobileEnabled
Whether or not the authentication method is available from the mobile application.

.PARAMETER logoffUrl
The logoff page URL of the third-party server.

.PARAMETER secondFactorAuth
Defines which second factor authentication to use when connecting to the Vault.
An empty value will disable the second factor authentication.

.PARAMETER signInLabel
Defines the sign-in text for this authentication method.
Relevant only for CyberArk, RADIUS and LDAP authentication methods.

.PARAMETER usernameFieldLabel
Defines the label of the username field for this authentication method.
Relevant only for CyberArk, RADIUS, and LDAP authentication methods.

.PARAMETER passwordFieldLabel
Defines the label of the password field for this authentication method.
Relevant only for CyberArk, RADIUS, and LDAP authentication methods.

.EXAMPLE
Add-PASAuthenticationMethod -id SomeID -displayName SomeAuth -enabled $true

Creates new authentication method.

#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '', Justification = "passwordFieldLabel not related to password value")]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '', Justification = "usernameFieldLabel & passwordFieldLabel not related to password value")]
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 50)]
		[string]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 50)]
		[string]$displayName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$enabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$mobileEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$logoffUrl,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("cyberark", "radius", "ldap")]
		[string]$secondFactorAuth,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 100)]
		[string]$signInLabel,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 50)]
		[string]$usernameFieldLabel,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 50)]
		[string]$passwordFieldLabel
	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/AuthenticationMethods"

		#Request body
		$Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession


		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}