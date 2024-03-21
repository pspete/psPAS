# .ExternalHelp psPAS-help.xml
function Set-PASSafe {
	[CmdletBinding(SupportsShouldProcess,
		DefaultParameterSetName = 'Gen2-NumberOfDaysRetention')]
	param(
		[Parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { $_ -notmatch ".*(\\|\/|:|\*|<|>|`"|\.|\||^\s).*" })]
		[ValidateLength(0, 28)]
		[string]$SafeName,

		[Parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { $_ -notmatch ".*(\\|\/|:|\*|<|>|`"|\.|\||^\s).*" })]
		[ValidateLength(0, 28)]
		[string]$NewSafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 100)]
		[string]$Description,

		[Parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-NumberOfDaysRetention'
		)]
		[Parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-NumberOfVersionsRetention'
		)]
		[string]$location,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[boolean]$OLACEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$ManagingCPM,

		[Parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-NumberOfVersionsRetention'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1-NumberOfVersionsRetention'
		)]
		[ValidateRange(1, 999)]
		[int]$NumberOfVersionsRetention,

		[Parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-NumberOfDaysRetention'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1-NumberOfDaysRetention'
		)]
		[ValidateRange(0, 3650)]
		[int]$NumberOfDaysRetention,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1-NumberOfVersionsRetention'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1-NumberOfDaysRetention'
		)]
		[switch]$UseGen1API

	)

	BEGIN { }#begin

	PROCESS {

		$typename = 'psPAS.CyberArk.Vault.Safe'

		$BoundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove NewSafeName

		$SafeObject = Get-PASSafe -SafeName $SafeName
		if ($null -ne $SafeObject) {
			Format-PutRequestObject -InputObject $SafeObject -boundParameters $BoundParameters -ParametersToKeep ManagingCPM, location, Description,
			NumberOfVersionsRetention, NumberOfDaysRetention
		}

		switch ($PSBoundParameters.Keys) {
			'NewSafeName' {
				$BoundParameters['SafeName'] = $PSBoundParameters['NewSafeName']
			}
			'NumberOfDaysRetention' {
				$BoundParameters.Remove('NumberOfVersionsRetention')
			}
			'NumberOfVersionsRetention' {
				$BoundParameters.Remove('NumberOfDaysRetention')
			}
		}

		switch ($PSCmdlet.ParameterSetName) {

			( { $PSItem -match '^Gen2-' } ) {

				Assert-VersionRequirement -RequiredVersion 12.2

				$typename = "$typename.Gen2"

				#Create URL for Request
				$URI = "$($psPASSession.BaseURI)/api/Safes/$($SafeName | Get-EscapedString)"

				#Create Request Body
				$body = $BoundParameters | ConvertTo-Json

				break

			}

			( { $PSItem -match '^Gen1-' } ) {

				Assert-VersionRequirement -MaximumVersion 12.3

				#Create URL for Request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Safes/$($SafeName | Get-EscapedString)"

				#Create Request Body
				$body = @{

					'safe' = $BoundParameters

				} | ConvertTo-Json

				break

			}

		}

		if ($PSCmdlet.ShouldProcess($SafeName, 'Update Safe Properties')) {

			#Send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body

			If ($null -ne $result) {

				switch ($PSCmdlet.ParameterSetName) {

					( { $PSItem -match '^Gen1-' } ) {

						$return = $result.UpdateSafeResult

						break

					}

					default {

						$return = $result

						break

					}

				}

				$return | Add-ObjectDetail -typename $typename

			}

		}

	}#process

	END { }#end

}
