# .ExternalHelp psPAS-help.xml
function Add-PASDiscoveryScan {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '', Justification = 'The API requires the scan credential object, including its password field, as JSON.')]
	[CmdletBinding(SupportsShouldProcess)]
	[OutputType([pscustomobject])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('ActiveDirectory', 'CsvFile')]
		[string]$scanType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[object[]]$scanCredentials,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$discoveryName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$managingScanner,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[object]$scheduleInformation,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateScript( { Test-Path -Path $_ -IsValid })]
		[string]$csvFile,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$fileName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[hashtable]$scanProperties
	)

	begin {

		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 12.2

	}#begin

	process {

		#Create request URL
		$URI = "$($psPASSession.BaseURI)/api/DiscoveryScans"

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		if ($scanType -eq 'CsvFile') {
			if (-not $PSBoundParameters.ContainsKey('csvFile')) {
				throw 'The csvFile parameter is required when scanType is CsvFile.'
			}

			if (-not $PSBoundParameters.ContainsKey('fileName')) {
				throw 'The fileName parameter is required when scanType is CsvFile.'
			}
		}

		if ($PSBoundParameters.ContainsKey('scanProperties')) {
			$boundParameters.Remove('scanProperties')

			foreach ($property in $scanProperties.GetEnumerator()) {
				$boundParameters[$property.Key] = $property.Value
			}
		}

		#Create body of request
		$Body = $boundParameters | ConvertTo-Json -Depth 4

		#Send as raw UTF8 bytes rather than a String so ParameterBinding/module logging of this
		#call records a non-revealing type name instead of the literal request content.
		$Body = [System.Text.Encoding]::UTF8.GetBytes($Body)

		if ($PSCmdlet.ShouldProcess($discoveryName, 'Add Discovery Scan')) {

			#Send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $result) {

				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.DiscoveryScan

			}

		}

	}#process

	end { }#end

}
