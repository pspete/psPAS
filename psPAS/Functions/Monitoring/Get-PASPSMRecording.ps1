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
		[ValidateLength(1, 500)]
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

	begin {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	process {

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
				if ($PSBoundParameters.ContainsKey('ToTime')) {
					$boundParameters['ToTime'] = $ToTime
				} else {
					#ToTime is now
					$boundParameters['ToTime'] = Get-Date
				}

				#Set FromTime to provided value or 24 hours before ToTime
				if ($PSBoundParameters.ContainsKey('FromTime')) {
					$boundParameters['FromTime'] = $FromTime | ConvertTo-UnixTime
				} else {
					#If ToTime specified get previous 24 hours
					$boundParameters['FromTime'] = (Get-Date $boundParameters['ToTime']).AddDays(-2) | ConvertTo-UnixTime
				}

				#Convert ToTime to UnixTime
				$boundParameters['ToTime'] = $boundParameters['ToTime'] | ConvertTo-UnixTime

				if ($PSBoundParameters.Keys -notcontains 'Limit') {
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

		if ($null -ne $result) {

			switch ($PSCmdlet.ParameterSetName) {

				'byRecordingID' {

					$Output = $result

					break

				}

				'byQuery' {

					#API only provides a Total value; page via Get-NextLink's offset support
					$Output = $result | Get-NextLink -RequestUri $URI

					break

				}

			}

		}

		if ($null -ne $Output) {

			#Return Results
			$Output | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Recording

		} #process

	}

	end { }#end

}