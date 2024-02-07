# .ExternalHelp psPAS-help.xml
function Get-PASPSMSessionProperty {
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
		$URI = "$($psPASSession.BaseURI)/API/LiveSessions/$($liveSessionId | Get-EscapedString)/properties"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Session.Property

		} #process

	}

	END { }#end

}