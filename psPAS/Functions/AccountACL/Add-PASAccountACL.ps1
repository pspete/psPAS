# .ExternalHelp psPAS-help.xml
function Add-PASAccountACL {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('PolicyID')]
		[Alias('PlatformID')]
		[ValidateNotNullOrEmpty()]
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
			ValueFromPipelinebyPropertyName = $false
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountUserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false
		)]
		[ValidateNotNullOrEmpty()]
		[string]$Command,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false
		)]
		[boolean]$CommandGroup,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false
		)]
		[ValidateSet('Allow', 'Deny')]
		[string]$PermissionType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[ValidateNotNullOrEmpty()]
		[string]$Restrictions,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false
		)]
		[ValidateNotNullOrEmpty()]
		[string]$UserName

	)

	BEGIN {
		Assert-VersionRequirement -SelfHosted
	}#begin

	PROCESS {

		#URL for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Account/$($AccountAddress |

            Get-EscapedString)|$($AccountUserName |

                Get-EscapedString)|$($AccountPolicyId |

                    Get-EscapedString)/PrivilegedCommands/"

		#Request body
		$Body = $PSBoundParameters |

			Get-PASParameter -ParametersToRemove AccountAddress, AccountUserName, AccountPolicyID |

			ConvertTo-Json

		#Send Request
		$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body

		If ($null -ne $result) {

			$result.AddAccountPrivilegedCommandResult |

				Add-ObjectDetail -typename psPAS.CyberArk.Vault.ACL.Account

		}

	}#process

	END { }#end

}