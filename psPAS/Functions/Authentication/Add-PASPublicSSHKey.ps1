# .ExternalHelp psPAS-help.xml
function Add-PASPublicSSHKey {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateScript( { $_ -notmatch '.*(%|\&|\+).*' })]
		[string]$UserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateScript( { $_ -notmatch "`n" })]
		[string]$PublicSSHKey

	)

	BEGIN { }#begin

	PROCESS {

		#Create URL to endpoint for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)/AuthenticationMethods/SSHKeyAuthentication/AuthorizedKeys/"

		#create request body
		$Body = @{

			'PublicSSHKey' = $PublicSSHKey

		} | ConvertTo-Json

		#send request to webservice
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		If ($null -ne $result) {

			$result.AddUserAuthorizedKeyResult |

				Add-ObjectDetail -typename psPAS.CyberArk.Vault.PublicSSHKey -PropertyToAdd @{

					'UserName' = $UserName

				}

		}

	}#process

	END { }#end

}