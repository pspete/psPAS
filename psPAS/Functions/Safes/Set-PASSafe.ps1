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
		[ValidateRange(0, 999)]
		[int]$NumberOfVersionsRetention,

		[Parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-NumberOfDaysRetention'
		)]
		[ValidateRange(0, 3650)]
		[int]$NumberOfDaysRetention,

		[Parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[int]$Quota
	)

	begin {
		Assert-VersionRequirement -RequiredVersion 12.2
	}#begin

	process {

		$typename = 'psPAS.CyberArk.Vault.Safe'

		$BoundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove NewSafeName

		$SafeObject = Get-PASSafe -SafeName $SafeName
		if ($null -ne $SafeObject) {
			Format-PutRequestObject -InputObject $SafeObject -boundParameters $BoundParameters -ParametersToKeep ManagingCPM, location, Description,
			NumberOfVersionsRetention, NumberOfDaysRetention, Quota
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
			'Quota' {
				Assert-VersionRequirement -SelfHosted
				Assert-VersionRequirement -RequiredVersion 15.2
				continue
			}
		}


		$typename = "$typename.Gen2"

		# Convert quota values with an MB suffix to numeric values in the request body
		if ($BoundParameters.ContainsKey('Quota')) {
			$quotaValue = $BoundParameters['Quota']
			if ($quotaValue -is [string]) {
				$BoundParameters['Quota'] = [int]$Matches.value
			}
		}

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/api/Safes/$($SafeName | Get-EscapedString)"

		#Create Request Body
		$body = $BoundParameters | ConvertTo-Json


		if ($PSCmdlet.ShouldProcess($SafeName, 'Update Safe Properties')) {

			#Send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body

			if ($null -ne $result) {

				$return = $result

				$return | Add-ObjectDetail -typename $typename

			}

		}

	}#process

	end { }#end

}