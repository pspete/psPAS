# .ExternalHelp psPAS-help.xml
function Export-PASPlatform {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PlatformID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateScript( { Test-Path -Path $_ -IsValid })]
		[string]$path
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.4
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/Platforms/$PlatformID/Export?platformID=$PlatformID"

		if ($PSCmdlet.ShouldProcess($PlatformID, 'Exports Platform Package')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Debug:$false

			#if we get a platform byte array
			If ($null -ne $result) {

				Out-PASFile -InputObject $result -Path $path

			}

		}

	}#process

	END { }#end

}