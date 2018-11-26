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

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.PARAMETER ExternalVersion
The External CyberArk Version, returned automatically from the New-PASSession function from version 9.7 onwards.
If the minimum version requirement of this function is not satisfied, execution will be halted.
Omitting a value for this parameter, or supplying a version of "0.0" will skip the version check.

.EXAMPLE
$token | Add-PASGroupMember -GroupName PVWAMonitor -UserName TargetUser

Adds TargetUser to PVWAMonitor group

.EXAMPLE
$token | Add-PASGroupMember -GroupName PVWAMonitor -UserName TargetUser

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
		[string]$UserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$sessionToken,

		[parameter(
			ValueFromPipelinebyPropertyName = $true
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = "PasswordVault",

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[System.Version]$ExternalVersion = "0.0"

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.6"
	}#begin

	PROCESS {

		If($PSCmdlet.ParameterSetName -eq "pre_10_6") {
			#Create URL for request
			$URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Groups/$($GroupName |

            Get-EscapedString)/Users"

		}

		ElseIf($PSCmdlet.ParameterSetName -eq "post_10_6") {

			Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for request
			$URI = "$baseURI/$PVWAAppName/API/UserGroups/$groupId/Members"

		}

		#create request body
		$Body = $PSBoundParameters |

		Get-PASParameter -ParametersToRemove GroupName, groupId |

		ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

		if($result) {

			$result

		}

	}#process

	END {}#end

}