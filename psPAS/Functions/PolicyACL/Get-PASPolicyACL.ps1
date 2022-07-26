# .ExternalHelp psPAS-help.xml
function Get-PASPolicyACL {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$PolicyID

	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Policy/$($PolicyID |

            Get-EscapedString)/PrivilegedCommands/"

		#Send Request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result.ListPolicyPrivilegedCommandsResult |

				Add-ObjectDetail -typename psPAS.CyberArk.Vault.ACL.Policy

		}

	}#process

	END { }#end

}