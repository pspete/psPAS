function Get-PASAccountACL {
	<#
.SYNOPSIS
Lists privileged commands rule for an account

.DESCRIPTION
Gets list of all privileged commands associated with an account

.PARAMETER AccountPolicyId
The PolicyID associated with account.

.PARAMETER AccountAddress
The address of the account whose privileged commands will be listed.

.PARAMETER AccountUserName
The name of the account's user.

.EXAMPLE
Get-PASAccount root | Get-PASAccountACL

Returns Privileged Account Rules for the account root found by Get-PASAccount:

PolicyId Command                       PermissionType UserName Type    IsGroup
-------- -------                       -------------- -------- ----    -------
UNIXSSH  ifconfig                      Allow          TestUser Account False
UNIXSSH  for /l %a in (0,0,0) do start Deny           TestUser Account False
UNIXSSH  for /l %a in (0,0,0) do xyz   Allow          TestUser Account False

.INPUTS
All parameters can be piped by property name
Should accept pipeline objects from other *-PASAccount functions

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.ACL
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.LINK
https://pspas.pspete.dev/commands/Get-PASAccountACL
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("PolicyID")]
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
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("UserName")]
		[ValidateNotNullOrEmpty()]
		[string]$AccountUserName
	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Account/$($AccountAddress |

            Get-EscapedString)|$($AccountUserName |

                Get-EscapedString)|$($AccountPolicyId |

                    Get-EscapedString)/PrivilegedCommands"

		#Send request to Web Service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession #DevSkim: ignore DS104456

		If ($null -ne $result) {

			$result.ListAccountPrivilegedCommandsResult |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.ACL.Account

		}

	}#process

	END { }#end

}