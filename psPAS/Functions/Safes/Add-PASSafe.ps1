# .ExternalHelp psPAS-help.xml
function Add-PASSafe {
	[CmdletBinding(DefaultParameterSetName = 'NumberOfVersionsRetention')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { $_ -notmatch ".*(\\|\/|:|\*|<|>|`"|\.|\||^\s).*" })]
		[ValidateLength(0, 28)]
		[string]$SafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 100)]
		[string]$Description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$location,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$OLACEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$ManagingCPM,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1-NumberOfVersionsRetention'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'NumberOfVersionsRetention'
		)]
		[ValidateRange(1, 999)]
		[int]$NumberOfVersionsRetention,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1-NumberOfDaysRetention'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'NumberOfDaysRetention'
		)]
		[ValidateRange(1, 3650)]
		[int]$NumberOfDaysRetention,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'NumberOfVersionsRetention'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'NumberOfDaysRetention'
		)]
		[boolean]$AutoPurgeEnabled,

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

	BEGIN {
		$typename = 'psPAS.CyberArk.Vault.Safe'
	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			( { $PSItem -match '^Gen1-' } ) {

				#Create URL for request
				$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Safes"

				#create request body
				$body = @{

					#add parameters to safe node
					'safe' = $PSBoundParameters | Get-PASParameter

				} | ConvertTo-Json

				break

			}

			default {

				Assert-VersionRequirement -RequiredVersion 12.0

				#Create URL for request
				$URI = "$Script:BaseURI/API/Safes"

				$typename = "$typename.Gen2"

				$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

				break

			}

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		If ($null -ne $result) {

			switch ($PSCmdlet.ParameterSetName) {

				( { $PSItem -match '^Gen1-' } ) {

					$return = $result.AddSafeResult

					break

				}

				default {

					$return = $result

					break

				}

			}

			$return | Add-ObjectDetail -typename $typename
		}

	}#process

	END { }#end

}