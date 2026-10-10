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

	begin { }#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/AutomaticOnboardingRules/$($RuleID | Get-EscapedString)/"

		if ($PSCmdlet.ShouldProcess($RuleID, 'Delete On-boarding Rule')) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	end { }#end

}