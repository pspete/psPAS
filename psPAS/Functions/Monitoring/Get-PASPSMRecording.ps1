# .ExternalHelp psPAS-help.xml
function Get-PASPSMRecording {
	[CmdletBinding(DefaultParameterSetName = 'byQuery')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byRecordingID'
		)]
		[string]$RecordingID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[ValidateNotNullOrEmpty()]
		[int]$Limit,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[ValidateSet('RiskScore', 'FileName', 'SafeName', 'FolderName', 'PSMVaultUserName', 'FromIP', 'RemoteMachine',
			'Client', 'Protocol', 'AccountUserName', 'AccountAddress', 'AccountPlatformID', 'PSMStartTime', 'TicketID',
			'-RiskScore', '-FileName', '-SafeName', '-FolderName', '-PSMVaultUserName', '-FromIP', '-RemoteMachine',
			'-Client', '-Protocol', '-AccountUserName', '-AccountAddress', '-AccountPlatformID', '-PSMStartTime',
			'-TicketID'
		)]
		[string]$Sort,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[string]$Search,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[string]$Safe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[datetime]$FromTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[datetime]$ToTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[string]$Activities
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/Recordings"

		switch ($PSCmdlet.ParameterSetName) {

			'byRecordingID' {
				Assert-VersionRequirement -RequiredVersion 10.6

				$URI = "$URI/$RecordingID"

				break

			}

			'byQuery' {

				#Get Parameters to include in request
				$boundParameters = $PSBoundParameters | Get-PASParameter

				#If no arguments initialise boundparameters
				if ($null -eq $boundparameters) {
					$boundparameters = @{ }
				}

				#* fetch last 24 hours by default.
				#Set ToTime to provided value or now
				If ($PSBoundParameters.ContainsKey('ToTime')) {
					$boundParameters['ToTime'] = $ToTime
				} Else {
					#ToTime is now
					$boundParameters['ToTime'] = Get-Date
				}

				#Set FromTime to provided value or 24 hours before ToTime
				If ($PSBoundParameters.ContainsKey('FromTime')) {
					$boundParameters['FromTime'] = $FromTime | ConvertTo-UnixTime
				} Else {
					#If ToTime specified get previous 24 hours
					$boundParameters['FromTime'] = (Get-Date $boundParameters['ToTime']).AddDays(-2) | ConvertTo-UnixTime
				}

				#Convert ToTime to UnixTime
				$boundParameters['ToTime'] = $boundParameters['ToTime'] | ConvertTo-UnixTime

				If ($PSBoundParameters.Keys -notcontains 'Limit') {
					$Limit = 100   #default if you call the API with no value
					$boundParameters.Add('Limit', $Limit) # Add to boundparameters for inclusion in query string
				}

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
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		$Total = $result.Total

		If ($Total -gt 0) {

			#Set events as output collection
			$Recordings = [Collections.Generic.List[Object]]::New(@($result.Recordings))

			#Split Request URL into baseURI & any query string value
			$URLString = $URI.Split('?')
			$URI = $URLString[0]
			$queryString = $URLString[1]

			For ( $Offset = $Limit ; $Offset -lt $Total ; $Offset += $Limit ) {

				#While more recordings to return, create nextLink query value
				$nextLink = "OffSet=$Offset"

				if ($null -ne $queryString) {

					#If original request contained a queryString, concatenate with nextLink value.
					$nextLink = "$queryString&$nextLink"

				}
				$result = (Invoke-PASRestMethod -Uri "$URI`?$nextLink" -Method GET).Recordings

				#Request nextLink. Add recordingss to output collection.
				$Null = $Recordings.AddRange($result)
			}

			$Output = $Recordings

		}

		If ($null -ne $Output) {

			#Return Results
			$Output | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Recording

		} #process

	}

	END { }#end

}