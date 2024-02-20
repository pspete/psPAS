# .ExternalHelp psPAS-help.xml
function Import-PASPlatform {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { Test-Path -Path $_ -PathType Leaf })]
		[ValidatePattern( '\.zip$' )]
		[string]$ImportFile
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.2
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/Platforms/Import"

		#Convert File to byte array
		$FileBytes = $ImportFile | Get-ByteArray

		$Body = @{'ImportFile' = $FileBytes } | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($ImportFile, 'Imports Platform Package')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Debug:$false

		}

	}#process

	END { }#end

}