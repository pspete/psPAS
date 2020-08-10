function Remove-PASUser {
	<#
.SYNOPSIS
Deletes a vault user

.DESCRIPTION
Deletes an existing user from the vault

.PARAMETER id
The numeric id of the user to delete.
Requires CyberArk version 11.1+

.PARAMETER UserName
The name of the user to delete from the vault

.EXAMPLE
Remove-PASUser -id 1234

Deletes vault user with id 1234

.EXAMPLE
Remove-PASUser -UserName This_User

Deletes vault user "This_User"

.INPUTS
All parameters can be piped by property name

.LINK
https://pspas.pspete.dev/commands/Remove-PASUser
#>
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "11.1")]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11.1"
		)]
		[int]$id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[string]$UserName
	)

	BEGIN {

		If ($PSCmdlet.ParameterSetName -ne "legacy") {

			Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName

		}

	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			"11.1" {

				$URI = "$Script:BaseURI/api/Users/$id"

				break

			}

			default {

				#Create URL for request
				$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Users/$($UserName | Get-EscapedString)"

				break

			}

		}

		if ($PSCmdlet.ShouldProcess($UserName, "Delete User")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}