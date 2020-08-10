function Set-PASUserPassword {
	<#
.SYNOPSIS
Updates a vault user

.DESCRIPTION
Updates an existing user in the vault

.PARAMETER id
The name of the user to update in the vault

.PARAMETER NewPassword
The password to set on the account.
Must meet the password complexity requirements

.EXAMPLE
Set-PASUserPassword -id 123 -NewPassword $SecureString

Resets password on account with id 123

.LINK
https://pspas.pspete.dev/commands/Set-PASUserPassword
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[securestring]$NewPassword
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.10
	}#begin

	PROCESS {

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove id

		$Password = ConvertTo-InsecureString -SecureString $NewPassword

		If ($Password.length -gt 39) {
			throw "Password must not exceed 39 characters"
		}

		#Include decoded password in request
		$boundParameters["NewPassword"] = $Password

		#Create URL for request
		$URI = "$Script:BaseURI/api/Users/$id/ResetPassword"

		#create request body
		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($id, "Reset Password")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}