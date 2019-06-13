function Remove-PASPolicyACL {
	<#
.SYNOPSIS
Delete all privileged commands on policy

.DESCRIPTION
Deletes all privileged command rules associated with the policy

.PARAMETER PolicyID
String value of Policy ID

.PARAMETER Id
The Rule Id that will be deleted

.EXAMPLE
Remove-PASPolicyACL -PolicyID UNIXSSH -Id 13

Deletes Rule with ID of 13 from UNIXSSH platform.

.INPUTS
All parameters can be piped by property name

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
		[ValidateNotNullOrEmpty()]
		[string]$PolicyID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Id

	)

	BEGIN {}#begin

	PROCESS {

		#Create base URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Policy/$($PolicyID |

            Get-EscapedString)/PrivilegedCommands/$($Id |

                Get-EscapedString)"

		if($PSCmdlet.ShouldProcess($PolicyID, "Delete Rule $Id")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END {}#end

}