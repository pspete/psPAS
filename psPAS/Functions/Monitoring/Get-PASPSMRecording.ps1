# .ExternalHelp psPAS-help.xml
function Get-PASPSMRecording {
	[CmdletBinding(DefaultParameterSetName = "byQuery")]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byRecordingID"
		)]
		[string]$RecordingID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[ValidateNotNullOrEmpty()]
		[int]$Limit,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[ValidateSet("RiskScore", "FileName", "SafeName", "FolderName", "PSMVaultUserName", "FromIP", "RemoteMachine",
			"Client", "Protocol", "AccountUserName", "AccountAddress", "AccountPlatformID", "PSMStartTime", "TicketID",
			"-RiskScore", "-FileName", "-SafeName", "-FolderName", "-PSMVaultUserName", "-FromIP", "-RemoteMachine",
			"-Client", "-Protocol", "-AccountUserName", "-AccountAddress", "-AccountPlatformID", "-PSMStartTime",
			"-TicketID"
		)]
		[string]$Sort,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[int]$Offset,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[string]$Search,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[string]$Safe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[int]$FromTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[int]$ToTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[string]$Activities
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$Script:BaseURI/API/Recordings"

		switch ($PSCmdlet.ParameterSetName) {

			"byRecordingID" {
				Assert-VersionRequirement -RequiredVersion 10.6

				$URI = "$URI/$RecordingID"

				break

			}

			"byQuery" {
				#Get Parameters to include in request
				$boundParameters = $PSBoundParameters | Get-PASParameter

				#Create Query String, escaped for inclusion in request URL
				$queryString = $boundParameters | ConvertTo-QueryString

				if ($null -ne $queryString) {

					#Build URL from base URL
					$URI = "$URI`?$queryString"

				}

				break

			}

		}

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			#Return Results
			$result.Recordings | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Recording

		} #process

	}

	END { }#end

}