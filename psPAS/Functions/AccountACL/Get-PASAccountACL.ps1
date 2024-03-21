# .ExternalHelp psPAS-help.xml
function Get-PASAccountACL {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('PolicyID')]
		[string]$AccountPolicyId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('Address')]
		[ValidateNotNullOrEmpty()]
		[string]$AccountAddress,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('UserName')]
		[ValidateNotNullOrEmpty()]
		[string]$AccountUserName
	)

	BEGIN {
		Assert-VersionRequirement -SelfHosted
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Account/$($AccountAddress |

            Get-EscapedString)|$($AccountUserName |

                Get-EscapedString)|$($AccountPolicyId |

                    Get-EscapedString)/PrivilegedCommands/"

		#Send request to Web Service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET #DevSkim: ignore DS104456

		If ($null -ne $result) {

			$result.ListAccountPrivilegedCommandsResult |

				Add-ObjectDetail -typename psPAS.CyberArk.Vault.ACL.Account

		}

	}#process

	END { }#end

}