# .ExternalHelp psPAS-help.xml
function Get-PASPSMSession {
	[CmdletBinding(DefaultParameterSetName = 'byQuery')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'bySessionID'
		)]
		[string]$liveSessionId,

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
		$URI = "$($psPASSession.BaseURI)/API/LiveSessions"

		switch ($PSCmdlet.ParameterSetName) {

			'bySessionID' {
				Assert-VersionRequirement -RequiredVersion 10.6

				$URI = "$URI/$liveSessionId"

				break

			}

			'byQuery' {
				#Get Parameters to include in request
				$boundParameters = $PSBoundParameters | Get-PASParameter

				switch ($PSBoundParameters) {

					{ $PSItem.ContainsKey('FromTime') } {

						$boundParameters['FromTime'] = $FromTime | ConvertTo-UnixTime

					}

					{ $PSItem.ContainsKey('ToTime') } {

						$boundParameters['ToTime'] = $ToTime | ConvertTo-UnixTime

					}

					{ $PSBoundParameters.Keys -notcontains 'Limit' } {
						$Limit = 25   #default if you call the API with no value
						$boundParameters.Add('Limit', $Limit) # Add to boundparameters for inclusion in query string
					}

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

				'bySessionID' {

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
			$Output | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PSM.Session

		} #process

	}

	end { }#end

}