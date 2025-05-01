# .ExternalHelp psPAS-help.xml
function Add-PASPolicyACL {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$Command,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$CommandGroup,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('Allow', 'Deny')]
		[string]$PermissionType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$PolicyId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$Restrictions,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$UserName
	)

	BEGIN {
		Assert-VersionRequirement -SelfHosted
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Policy/$($PolicyID |

            Get-EscapedString)/PrivilegedCommands/"

		#Create request body
		$body = $PSBoundParameters |

			Get-PASParameter -ParametersToRemove PolicyId |

			ConvertTo-Json

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body

		If ($null -ne $result) {

			$result.AddPolicyPrivilegedCommandResult |

				Add-ObjectDetail -typename psPAS.CyberArk.Vault.ACL.Policy

		}

	}#process

	END { }#end

}