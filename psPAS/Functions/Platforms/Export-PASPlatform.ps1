function Export-PASPlatform {
	<#
	.SYNOPSIS
	Export a platform

	.DESCRIPTION
	Export a platform to a zip file in order to import it to a different Vault environment.
	Vault Admin group membership required.

	.PARAMETER PlatformID
	The name of the platform.

	.PARAMETER Path
	The output zip file to save the platform configuration in.

	.PARAMETER sessionToken
	Hashtable containing the session token returned from New-PASSession

	.PARAMETER WebSession
	WebRequestSession object returned from New-PASSession

	.PARAMETER BaseURI
	PVWA Web Address
	Do not include "/PasswordVault/"

	.PARAMETER PVWAAppName
	The name of the CyberArk PVWA Virtual Directory.
	Defaults to PasswordVault

	.PARAMETER ExternalVersion
	The External CyberArk Version, returned automatically from the New-PASSession function from version 9.7 onwards.
	If the minimum version requirement of this function is not satisfied, execution will be halted.
	Omitting a value for this parameter, or supplying a version of "0.0" will skip the version check.

	.EXAMPLE
Export-PASPlatform -PlatformID YourPlatform -Path C:\Platform.zip

	Exports UnixSSH to Platform.zip platform package.

	.INPUTS
	SessionToken, ImportFile, WebSession & BaseURI can be piped by  property name

	.OUTPUTS
	None

	.NOTES
	Minimum CyberArk version 10.4

	#>
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
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { Test-Path -Path $_ -PathType Leaf -IsValid})]
		[ValidatePattern( '\.zip$' )]
		[string]$path
	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.4"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/API/Platforms/$PlatformID/Export?platformID=$PlatformID"

		if($PSCmdlet.ShouldProcess($PlatformID, "Exports Platform Package")) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $WebSession -Debug:$false

			#if we get a platform byte array
			if($result) {

				try {

					$output = @{
						Path     = $path
						Value    = $result
						Encoding = "Byte"
					}

					If($IsCoreCLR) {

						#amend parameters for splatting if we are in Core
						$output.Add("AsByteStream", $true)
						$output.Remove("Encoding")

					}

					#write it to a file
					Set-Content @output -ErrorAction Stop

				} catch {throw "Error Saving $path"}

			}

		}

	}#process

	END {}#end

}