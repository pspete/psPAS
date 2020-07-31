﻿function Get-PASPublicSSHKey {
	<#
.SYNOPSIS
Retrieves a user's SSH Keys.

.DESCRIPTION
Retrieves all public SSH keys that are authorized for a specific user.
The "Reset User Passwords" Vault permission is required to query public SSH Keys.
The authenticated user who runs the function must be in the same Vault
Location or higher as the user whose public SSH keys are retrieved.
A user cannot manage their own public SSH keys.

.PARAMETER UserName
The username of the Vault user whose public SSH keys will be added
A username cannot contain te follwing characters: "%", "&", "+" or ".".

.EXAMPLE
Get-PASPublicSSHKey -UserName user1

Lists all SSH Keys for vault user - user1:

UserName KeyID                            PublicSSHKey
-------- -----                            ------------
user1    415161FE8F2B408BB76BC244258C3697 ACABB3NzaC1kc3MAAACBAJ3hA...............
user1    B6DCA4D54B2E93380F42DDCDB23EE52A AgreatNzaC1kc3MAAACBAJ3hB...............
user1    D6374740D11A5F45992D80D80E97387A PHil0soPh3rkc3MAAACBAJ3hC...............

.LINK
https://pspas.pspete.dev/commands/Get-PASPublicSSHKey
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateScript( { $_ -notmatch ".*(%|\&|\+|\.).*" })]
		[string]$UserName

	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)/AuthenticationMethods/SSHKeyAuthentication/AuthorizedKeys"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result.GetUserAuthorizedKeysResult |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.PublicSSHKey -PropertyToAdd @{

				"UserName" = $UserName

			}

		}

	}#process

	END { }#end

}