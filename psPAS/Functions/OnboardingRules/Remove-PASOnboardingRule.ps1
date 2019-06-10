function Remove-PASOnboardingRule {
	<#
.SYNOPSIS
Deletes an automatic on-boarding rule


.DESCRIPTION
Deletes an automatic on-boarding rulefrom the Vault.
Vault Admin membership required.

.PARAMETER RuleID
The unique ID of the rule to delete.

.EXAMPLE
Remove-PASOnboardingRule -RuleID 5

Removes specified on-boarding rule.

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
		[string]$RuleID
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/AutomaticOnboardingRules/$($RuleID |

            Get-EscapedString)"

		if($PSCmdlet.ShouldProcess($RuleID, "Delete On-boarding Rule")) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END {}#end
}