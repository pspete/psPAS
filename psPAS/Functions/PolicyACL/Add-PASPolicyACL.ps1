function Add-PASPolicyACL {
	<#
.SYNOPSIS
Adds a new privileged command rule

.DESCRIPTION
Adds a new privileged command rule to a policy.

.PARAMETER Command
The Command to Add

.PARAMETER CommandGroup
Boolean to define if commandgroup

.PARAMETER PermissionType
Allow or Deny Permission

.PARAMETER PolicyId
String value of Policy ID

.PARAMETER Restrictions
A restrictions string

.PARAMETER UserName
The user this rule applies to.
Specify "*" for all users

.EXAMPLE
Add-PASPolicyACL -Command "chmod" -CommandGroup $false -PermissionType Allow -PolicyId UNIXSSH -UserName user1

Adds Rule to UNIXSSH platform

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.ACL
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.LINK
https://pspas.pspete.dev/commands/Add-PASPolicyACL
#>
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
		[ValidateSet("Allow", "Deny")]
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

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Policy/$($PolicyID |

            Get-EscapedString)/PrivilegedCommands"

		#Create request body
		$body = $PSBoundParameters |

		Get-PASParameter -ParametersToRemove PolicyId |

		ConvertTo-Json

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result.AddPolicyPrivilegedCommandResult |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.ACL.Policy

		}

	}#process

	END { }#end

}