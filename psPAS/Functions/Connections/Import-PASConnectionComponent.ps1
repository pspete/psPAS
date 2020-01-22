function Import-PASConnectionComponent {
	<#
.SYNOPSIS
Import a new connection component.

.DESCRIPTION
Allows administrators to import a new connection component, such as those available to download from the
CyberArk Marketplace.

.PARAMETER ImportFile
The zip file that contains the connection component.

.EXAMPLE
Import-PASConnectionComponent -ImportFile ConnectionComponent.zip

Imports ConnectionComponent.zip Connection Component

.NOTES
Minimum CyberArk version 10.3

.LINK
https://pspas.pspete.dev/commands/Import-PASConnectionComponent
#>
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
		$MinimumVersion = [System.Version]"10.2"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/API/ConnectionComponents/Import"

		#Convert File to byte array
		$FileBytes = $ImportFile | Get-ByteArray

		#Create Request Body
		$Body = @{"ImportFile" = $FileBytes } | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($ImportFile, "Imports Connection Component")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession -Debug:$false

		}

	}#process

	END { }#end

}