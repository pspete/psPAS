function Add-PASGroupMember {
	<#
.SYNOPSIS
Adds a vault user as a group member

.DESCRIPTION
Adds an existing user to an existing group in the vault

.PARAMETER groupId
The unique ID of the group to add the member to.
Requires CyberArk version 10.6+

.PARAMETER memberId
The name of the user or group to add as a member.
Requires CyberArk version 10.6+

.PARAMETER memberType
The type of user being added to the Vault group.
Valid values: domain/vault
Requires CyberArk version 10.6+

.PARAMETER domainName
If memberType=domain, dns address of the domain
Requires CyberArk version 10.6+

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

.LINK
https://pspas.pspete.dev/commands/Add-PASGroupMember
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

	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			"pre_10_6" {

				#Create URL for request
				$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Groups/$($GroupName | Get-EscapedString)/Users"

				break

			}

			"post_10_6" {

				Assert-VersionRequirement -RequiredVersion 10.6

				#Create URL for request
				$URI = "$Script:BaseURI/API/UserGroups/$groupId/Members"

				break

			}

		}

		#create request body
		$Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove GroupName, groupId | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}