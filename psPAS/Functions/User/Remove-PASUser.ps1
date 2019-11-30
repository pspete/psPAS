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
Remove-PASUser This_User

Deletes vault user "This_User"

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None
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
			ParameterSetName = "legacy"
		)]
		[string]$UserName
	)

	BEGIN {
		$MinimumVersion = [System.Version]"11.1"
	}#begin

	PROCESS {

		If ($PSCmdlet.ParameterSetName -eq "11_1") {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

			$URI = "$Script:BaseURI/api/Users/$id"

		}

		Else {

			#Create URL for request
			$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Users/$($UserName |

				Get-EscapedString)"

		}

		if ($PSCmdlet.ShouldProcess($UserName, "Delete User")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}