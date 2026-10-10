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

	begin {
		Assert-VersionRequirement -RequiredVersion 10.6
	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/LiveSessions/$($LiveSessionId | Get-EscapedString)/activities"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			#Return Results
			$result.Activities | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Session.Activity

		} #process

	}

	end { }#end

}