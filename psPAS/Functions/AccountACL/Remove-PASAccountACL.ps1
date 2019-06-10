function Remove-PASAccountACL {
	<#
.SYNOPSIS
Deletes privileged commands rule from an account

.DESCRIPTION
Deletes privileged commands rule associated with account

.PARAMETER AccountPolicyID
ID of account from which the commands will be deleted

.PARAMETER AccountAddress
The address of the account for which the privileged command will be deleted.

.PARAMETER AccountUserName
The name of the account's user.

.PARAMETER Id
The ID of the command that will be deleted

.EXAMPLE
Remove-PASAccountACL -AccountPolicyId UNIXSSH -AccountAddress machine -AccountUserName root -Id 12

Removes matching Privileged Account Rule from the account root

.EXAMPLE
Get-PASAccount root | Get-PASAccountACL | Where-Object{$_.Command -eq "ifconfig"} | Remove-PASAccountACL

Removes matching Privileged Account Rule from account.

.INPUTS
All parameters can be piped by property name
Should accept pipeline objects from Get-PASAccountACL function

.OUTPUTS
None

.NOTES

.LINK

#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("PolicyID")]
		[ValidateNotNullOrEmpty()]
		[string]$AccountPolicyId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountAddress,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountUserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Id
	)

	BEGIN {}#begin

	PROCESS {

		#URL for request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/WebServices/PIMServices.svc/Account/$($AccountAddress |

            Get-EscapedString)|$($AccountUserName |

                Get-EscapedString)|$($AccountPolicyId |

                    Get-EscapedString)/PrivilegedCommands/$Id"

		#Request Body
		$Body = @{}

		if($PSCmdlet.ShouldProcess("$AccountAddress|$AccountUserName|$AccountPolicyId",
				"Delete Privileged Command '$Id'")) {

			#Send Request to Web Service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -Body $Body -WebSession $Script:WebSession

		}

	}#process

	END {}#end

}