function Get-PASPolicyACL {
	<#
.SYNOPSIS
Lists OPM Rules for a policy

.DESCRIPTION
Gets a list of the privileged commands (OPM Rules)
associated with this policy

.PARAMETER PolicyID
The ID of the Policy for which the privileged commands will be listed.

.EXAMPLE
Get-PASPolicyACL -PolicyID unixssh

Lists rules for UNIXSSH platform.

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.ACL
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$PolicyID

	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Policy/$($PolicyID |

            Get-EscapedString)/PrivilegedCommands"

		#Send Request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		if($result) {

			$result.ListPolicyPrivilegedCommandsResult |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.ACL.Policy

		}

	}#process

	END {}#end

}