# .ExternalHelp psPAS-help.xml
function Get-PASPSMSessionActivity {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('SessionID')]
		[string]$liveSessionId
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.6
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$Script:BaseURI/API/LiveSessions/$($LiveSessionId | Get-EscapedString)/activities"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			#Return Results
			$result.Activities | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Session.Activity

		} #process

	}

	END { }#end

}