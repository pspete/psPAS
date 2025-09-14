# .ExternalHelp psPAS-help.xml
function Get-PASPSMRecordingActivity {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('SessionID')]
		[string]$RecordingID
	)

	begin {
		Assert-VersionRequirement -RequiredVersion 10.6
	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/Recordings/$($RecordingID | Get-EscapedString)/activities"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			#Return Results
			$result.Activities | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Recording.Activity

		} #process

	}

	end { }#end

}