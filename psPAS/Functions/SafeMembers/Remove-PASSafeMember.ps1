function Remove-PASSafeMember {
	<#
.SYNOPSIS
Removes a member from a safe

.DESCRIPTION
Removes a specific member from a Safe.
The user who runs this function requires the ManageSafeMembers
permission.

.PARAMETER SafeName
The name of the safe from which to remove the member.

.PARAMETER MemberName
The name of the safe member to remove from the safes list of members.

.EXAMPLE
Remove-PASSafeMember -SafeName TargetSafe -MemberName TargetUser

Removes TargetUser as safe member from TargetSafe

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
		[string]$SafeName,

		[Alias("UserName")]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$MemberName
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Safes/$($SafeName |

            Get-EscapedString)/Members/$($MemberName |

                Get-EscapedString)"

		if($PSCmdlet.ShouldProcess($SafeName, "Remove Safe Member '$MemberName'")) {

			#Send Delete request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END {}#end

}