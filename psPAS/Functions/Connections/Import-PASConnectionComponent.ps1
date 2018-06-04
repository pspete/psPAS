function Import-PASConnectionComponent {
	<#
	.SYNOPSIS
	Import a new connection component.

	.DESCRIPTION
	Import a new connection component.

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
		[string]$PVWAAppName = "PasswordVault"
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/API/ConnectionComponents/Import"

		#Convert File to byte array
		$FileBytes = [System.IO.File]::ReadAllBytes($ImportFile)

		#Create Request Body
		$Body = @{"ImportFile" = $FileBytes} | ConvertTo-Json

		if($PSCmdlet.ShouldProcess($ImportFile, "Imports Connection Component")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $SessionToken -WebSession $WebSession

		}

	}#process

	END {}#end

}