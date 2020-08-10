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
The folder to export the platform configuration to.

.EXAMPLE
Export-PASPlatform -PlatformID YourPlatform -Path C:\Platform.zip

Exports UnixSSH to Platform.zip platform package.

.NOTES
Minimum CyberArk version 10.4

.LINK
https://pspas.pspete.dev/commands/Export-PASPlatform
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
		[ValidateScript( { Test-Path -Path $_ -IsValid })]
		[string]$path
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.4
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/API/Platforms/$PlatformID/Export?platformID=$PlatformID"

		if ($PSCmdlet.ShouldProcess($PlatformID, "Exports Platform Package")) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession -Debug:$false

			#if we get a platform byte array
			If ($null -ne $result) {

				Out-PASFile -InputObject $result -Path $path

			}

		}

	}#process

	END { }#end

}