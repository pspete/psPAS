function Import-PASConnectionComponent {
	<#
	.SYNOPSIS
	Import a new connection component.

	.DESCRIPTION
	Allows administrators to import a new connection component, such as those available to download from the
	CyberArk Marketplace.

	.PARAMETER ImportFile
	The zip file that contains the connection component.

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
	$token | Import-PASConnectionComponent -ImportFile ConnectionComponent.zip

	Imports ConnectionComponent.zip Connection Component

	.INPUTS
	SessionToken, ImportFile, WebSession & BaseURI can be piped by  property name

	.OUTPUTS
	None

	.NOTES
	Minimum CyberArk version 10.3

	#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { Test-Path -Path $_ -PathType Leaf})]
		[ValidatePattern( '\.zip$' )]
		[string]$ImportFile,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$SessionToken,

		[parameter(
			ValueFromPipelinebyPropertyName = $true
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = "PasswordVault",

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[System.Version]$ExternalVersion = "0.0"

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.2"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/API/ConnectionComponents/Import"

		#Convert File to byte array
		$FileBytes = $ImportFile | Get-ByteArray

		#Create Request Body
		$Body = @{"ImportFile" = $FileBytes} | ConvertTo-Json

		if($PSCmdlet.ShouldProcess($ImportFile, "Imports Connection Component")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $SessionToken -WebSession $WebSession -Debug:$false

		}

	}#process

	END {}#end

}