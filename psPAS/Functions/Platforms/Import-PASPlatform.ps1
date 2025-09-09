# .ExternalHelp psPAS-help.xml
function Import-PASPlatform {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'PlatformName', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'Description', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'Force', Justification = 'False Positive')]
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Import'
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { Test-Path -Path $_ -PathType Leaf })]
		[ValidatePattern( '\.zip$' )]
		[string]$ImportFile,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Update'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SideBySide'
		)]
		[string]$PlatformId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SideBySide'
		)]
		[string]$PlatformName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SideBySide'
		)]
		[string]$Description,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Update'
		)]
		[switch]$Force
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.2
		$Request = @{}
		$Request['Method'] = 'POST'
		#Create URL for request
		$Request['URI'] = "$($psPASSession.BaseURI)/API/Platforms/Import"

		$MessageItem = $null
		$MessageText = $null
	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			'Import' {
				#Convert File to byte array
				$FileBytes = $ImportFile | Get-ByteArray

				$Request['Body'] = @{'ImportFile' = $FileBytes } | ConvertTo-Json
				$Request['Debug'] = $false

				$MessageItem = $ImportFile
				$MessageText = 'Imports Platform Package'

			}
			'SideBySide' {
				# Check if version is 14.6 or higher for update support
				Assert-VersionRequirement -RequiredVersion 14.6
				$Request['Method'] = 'PATCH'
				$Request['Body'] = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

				$MessageItem = $PlatformId
				$MessageText = 'Side By Side Import'
			}
			'Update' {
				# Check if version is 14.2 or higher for update support
				Assert-VersionRequirement -RequiredVersion 14.2
				# Update existing platform
				$Request['URI'] = "$($psPASSession.BaseURI)/API/Platforms/$PlatformId/Update"

				$MessageItem = $PlatformId
				$MessageText = 'Update Platform'
			}

		}

		if ($PSCmdlet.ShouldProcess($MessageItem, $MessageText)) {

			try {
				#send request to web service
				Invoke-PASRestMethod @Request
			} catch {
				throw $_
			}
		}

	}#process

	END { }#end

}