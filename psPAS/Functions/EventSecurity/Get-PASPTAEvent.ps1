Function Get-PASPTAEvent {
	<#
	.SYNOPSIS
	Returns PTA security events

	.DESCRIPTION
	Returns PTA security events

	.PARAMETER lastUpdatedEventDate
	Parameter description

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

	.EXAMPLE
	$token | Get-PASPTAEvent

	Returns all PTA security events

	.NOTES
	Minimum Version CyberArk 10.3
	#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$lastUpdatedEventDate,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$sessionToken,

		[parameter(ValueFromPipelinebyPropertyName = $true)]
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
		$MinimumVersion = [System.Version]"10.3"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Create request URL
		$URI = "$baseURI/$PVWAAppName/API/pta/API/Events/"

		#Header is normally just session token
		$header = $SessionToken

		if($PSBoundParameters.ContainsKey("lastUpdatedEventDate")) {

			#add Unix Time Stamp of lastUpdatedEventDate to header as key=value pair
			$header["lastUpdatedEventDate"] = ($(Get-Date $(Get-Date $lastUpdatedEventDate) -UFormat %s))

		}

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $header -WebSession $WebSession

		If($result) {

			#Return Results
			$result |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Event -PropertyToAdd @{

				"sessionToken"    = $sessionToken
				"WebSession"      = $WebSession
				"BaseURI"         = $BaseURI
				"PVWAAppName"     = $PVWAAppName
				"ExternalVersion" = $ExternalVersion

			}

		}

	}#process

	END {}#end

}