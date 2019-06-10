function Add-PASGroupMember {
	<#
.SYNOPSIS
Adds a vault user as a group member

.DESCRIPTION
Adds an existing user to an existing group in the vault

.PARAMETER groupId
The unique ID of the group to add the member to.

.PARAMETER memberId
The name of the user or group to add as a member.

.PARAMETER memberType
The type of user being added to the Vault group.
Valid values: domain/vault

.PARAMETER domainName
If memberType=domain, dns address of the domain

.PARAMETER GroupName
The name of the user

.PARAMETER UserName
The name of the user

.EXAMPLE
Add-PASGroupMember -GroupName PVWAMonitor -UserName TargetUser

Adds TargetUser to PVWAMonitor group

.EXAMPLE
Add-PASGroupMember -GroupName PVWAMonitor -UserName TargetUser

Adds TargetUser to PVWAMonitor group

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None

.NOTES

.LINK

#>
	[CmdletBinding(DefaultParameterSetName = "post_10_6")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_10_6"
		)]
		[int]$groupId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_10_6"
		)]
		[string]$memberId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_10_6"
		)]
		[ValidateSet("domain", "vault")]
		[string]$memberType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_10_6"
		)]
		[string]$domainName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "pre_10_6"
		)]
		[string]$GroupName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "pre_10_6"
		)]
		[string]$UserName
	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.6"
	}#begin

	PROCESS {

		If ($PSCmdlet.ParameterSetName -eq "pre_10_6") {
			#Create URL for request
			$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Groups/$($GroupName |

            Get-EscapedString)/Users"

		}

		ElseIf ($PSCmdlet.ParameterSetName -eq "post_10_6") {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for request
			$URI = "$Script:BaseURI/API/UserGroups/$groupId/Members"

		}

		#create request body
		$Body = $PSBoundParameters |

		Get-PASParameter -ParametersToRemove GroupName, groupId |

		ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		if ($result) {

			$result

		}

	}#process

	END { }#end

}