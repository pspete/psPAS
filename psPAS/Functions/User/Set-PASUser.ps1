function Set-PASUser {
	<#
.SYNOPSIS
Updates a vault user

.DESCRIPTION
Updates an existing user in the vault

.PARAMETER UserName
The name of the user to update in the vault

.PARAMETER NewPassword
The password to set on the account.
Must meet the password complexity requirements

.PARAMETER Email
The user's email address

.PARAMETER FirstName
The user's first name

.PARAMETER LastName
The user's last name

.PARAMETER ChangePasswordOnTheNextLogon
Whether or not user will be forced to change password on next logon

.PARAMETER ExpiryDate
Expiry Date to set on account.

.PARAMETER UserTypeName
The User Type

.PARAMETER Disabled
Whether or not the user will be enabled or disabled.

.PARAMETER Location
The Vault Location for the user

.EXAMPLE
set-pasuser -UserName Bill -Disabled $true

Disables vault user Bill
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$UserName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[securestring]$NewPassword,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[string]$Email,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[string]$FirstName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[string]$LastName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[boolean]$ChangePasswordOnTheNextLogon,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[datetime]$ExpiryDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[string]$UserTypeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[boolean]$Disabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[string]$Location
	)

	BEGIN { }#begin

	PROCESS {

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove UserName

		#deal with newPassword SecureString
		If ($PSBoundParameters.ContainsKey("NewPassword")) {

			#Include decoded password in request
			$boundParameters["NewPassword"] = $(ConvertTo-InsecureString -SecureString $NewPassword)

		}

		If ($PSBoundParameters.ContainsKey("ExpiryDate")) {

			#Convert ExpiryDate to string in Required format
			$Date = (Get-Date $ExpiryDate -Format MM/dd/yyyy).ToString()

			#Include date string in request
			$boundParameters["ExpiryDate"] = $Date

		}

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)"

		#create request body
		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($UserName, "Update User Properties")) {
			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -WebSession $Script:WebSession

			if ($result) {

				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User

			}

		}

	}#process

	END { }#end

}