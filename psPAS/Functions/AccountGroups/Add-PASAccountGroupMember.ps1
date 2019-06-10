function Add-PASAccountGroupMember {
	<#
.SYNOPSIS
Adds an account as a member of an account group.

.DESCRIPTION
Adds an account as a member of an account group.
The account can contain either password or SSH key.
The account must be stored in the same safe as the account group.
The following permissions are required on the safe where the account group will be created:
 - Add Accounts
 - Update Account Content
 - Update Account Properties

.PARAMETER GroupID
The unique ID of the account group

.PARAMETER AccountID
The ID of the account to add as a member

.EXAMPLE
Add-PASAccountGroupMember -GroupID $groupID -AccountID $accID -sessionToken $ST -BaseURI $URL

Adds account with ID held in $accID to group with ID held in $groupID

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None

.NOTES
Minimum version 9.9.5

.LINK

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$GroupID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$AccountID
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.9.5"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for Request
		$URI = "$Script:BaseURI/API/AccountGroups/$($GroupID |

            Get-EscapedString)/Members"

		#Create body of request
		$body = $PSBoundParameters |

		Get-PASParameter -ParametersToRemove GroupID | ConvertTo-Json

		#send request to PAS web service
		Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

	}#process

	END {}#end

}