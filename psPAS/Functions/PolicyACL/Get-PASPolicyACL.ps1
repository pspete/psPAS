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

	begin {
		Assert-VersionRequirement -SelfHosted
	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Policy/$($PolicyID |

            Get-EscapedString)/PrivilegedCommands/"

		#Send Request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result.ListPolicyPrivilegedCommandsResult |

				Add-ObjectDetail -typename psPAS.CyberArk.Vault.ACL.Policy

		}

	}#process

	end { }#end

}