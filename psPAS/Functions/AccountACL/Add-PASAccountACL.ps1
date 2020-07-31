function Add-PASAccountACL {
	<#
.SYNOPSIS
Adds a new privileged command rule to an account.

.DESCRIPTION
Adds a new privileged command rule to an account.

.PARAMETER AccountPolicyId
The PolicyID associated with account.

.PARAMETER AccountAddress
The address of the account whose privileged commands will be listed.

.PARAMETER AccountUserName
The name of the account's user.

.PARAMETER Command
The Command

.PARAMETER CommandGroup
Boolean for Command Group

.PARAMETER PermissionType
Allow or Deny permission

.PARAMETER Restrictions
A restriction string

.PARAMETER UserName
The user this rule applies to

.EXAMPLE
Add-PASAccountACL -AccountPolicyID UNIXSSH -AccountAddress ServerA.domain.com -AccountUserName root `
        -Command 'for /l %a in (0,0,0) do xyz' -CommandGroup $false -PermissionType Deny -UserName TestUser

This will add a new Privileged Command Rule to root for user TestUser

.LINK
https://pspas.pspete.dev/commands/Add-PASAccountACL
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("PolicyID")]
		[Alias("PlatformID")]
		[ValidateNotNullOrEmpty()]
		[string]$AccountPolicyId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("Address")]
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
		[ValidateSet("Allow", "Deny")]
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

	BEGIN { }#begin

	PROCESS {

		#URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Account/$($AccountAddress |

            Get-EscapedString)|$($AccountUserName |

                Get-EscapedString)|$($AccountPolicyId |

                    Get-EscapedString)/PrivilegedCommands"

		#Request body
		$Body = $PSBoundParameters |

		Get-PASParameter -ParametersToRemove AccountAddress, AccountUserName, AccountPolicyID |

		ConvertTo-Json

		#Send Request
		$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result.AddAccountPrivilegedCommandResult |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.ACL.Account

		}

	}#process

	END { }#end

}