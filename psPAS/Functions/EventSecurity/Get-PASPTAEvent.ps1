# .ExternalHelp psPAS-help.xml
Function Get-PASPTAEvent {
	[CmdletBinding(DefaultParameterSetName = '11.3')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '11.4'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '11.3'
		)]
		[datetime]$fromUpdateDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '11.3'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '11.4'
		)]
		[ValidateSet('OPEN', 'CLOSED')]
		[string]$status,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '11.4'
		)]
		[string]$accountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = '10.3'
		)]
		[datetime]$lastUpdatedEventDate

	)

	BEGIN {
		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName
	}#begin

	PROCESS {

		#Create request URL
		$URI = "$($psPASSession.BaseURI)/API/pta/API/Events/"

		#Get Parameters to include in request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		$ThisSession = $psPASSession.WebSession

		switch ($PSCmdlet.ParameterSetName) {

			'10.3' {

				if ($PSBoundParameters.ContainsKey('lastUpdatedEventDate')) {

					#add Unix Time Stamp of lastUpdatedEventDate to header as key=value pair
					$boundParameters['lastUpdatedEventDate'] = $lastUpdatedEventDate | ConvertTo-UnixTime

					$ThisSession.Headers['lastUpdatedEventDate'] = $boundParameters['lastUpdatedEventDate']

				}

				break

			}

			default {

				if ($PSBoundParameters.ContainsKey('fromUpdateDate')) {

					#Include time as unixtimestamp in milliseconds
					$boundParameters['fromUpdateDate'] = $fromUpdateDate | ConvertTo-UnixTime -Milliseconds

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

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $ThisSession

		If ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Event

		}

	}#process

	END { }#end

}