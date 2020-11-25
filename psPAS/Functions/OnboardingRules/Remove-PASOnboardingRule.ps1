# .ExternalHelp psPAS-help.xml
function Remove-PASOnboardingRule {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$RuleID
	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/AutomaticOnboardingRules/$($RuleID | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($RuleID, "Delete On-boarding Rule")) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}