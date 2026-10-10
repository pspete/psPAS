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

	begin {
		Assert-VersionRequirement -RequiredVersion 10.6
	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/LiveSessions/$($liveSessionId | Get-EscapedString)/properties"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Session.Property

		} #process

	}

	end { }#end

}