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

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.6
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/Recordings/$($RecordingID | Get-EscapedString)/activities"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			#Return Results
			$result.Activities | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Recording.Activity

		} #process

	}

	END { }#end

}