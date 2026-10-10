# .ExternalHelp psPAS-help.xml
function Get-PASPublicSSHKey {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateScript( { $_ -notmatch '.*(%|\&|\+).*' })]
		[string]$UserName

	)

	begin { }#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)/AuthenticationMethods/SSHKeyAuthentication/AuthorizedKeys"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result.GetUserAuthorizedKeysResult |

				Add-ObjectDetail -typename psPAS.CyberArk.Vault.PublicSSHKey -PropertyToAdd @{

					'UserName' = $UserName

				}

		}

	}#process

	end { }#end

}