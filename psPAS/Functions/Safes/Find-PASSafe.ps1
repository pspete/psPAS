function Find-PASSafe {
<#
.SYNOPSIS
Returns safe list from the vault.

.DESCRIPTION
Returns abbreviated details for all safes

.PARAMETER search
List of keywords, separated with a space.

.PARAMETER TimeoutSec
See Invoke-WebRequest
Specify a timeout value in seconds

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
$token | Find-PASSafe
$token | Find-PASSafe -search "xyz abc"

.INPUTS
SafeName, SessionToken, WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

.NOTES
This API is largly undocumented, but appears to be available since V10
The documentation mentions no body parameters, but search/offset/limit/sort(NYI)/filter(NYI) seem to work
It returns results faster than the v9 API (invoked with Get-PASSafe) but has a vastly different return object
Recommended Use:  Use this to search for safes many quickly, then use Get-PASSafe to get full details about individual accounts

.LINK
https://cyberarkdocu.azurewebsites.net/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Safes%20Web%20Services%20-%20List%20Safes.htm

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[string]$search,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[int]$TimeoutSec,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$sessionToken,

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

	BEGIN {}#begin

	PROCESS {

		#Create base URL for request
		$URI = "$baseURI/$PVWAAppName/api/Safes"
		$SearchQuery = $null
		$Limit = 25   #default if you call the API with no value

		If ( -Not [string]::IsNullOrEmpty($search) ) {
			$SearchQuery = "&search=$($search | Get-EscapedString)"
		}

		$Safes = @()

		$InitialResponse = Invoke-PASRestMethod -Uri "$URI`?limit=$Limit$SearchQuery" -Method GET -Headers $sessionToken -WebSession $WebSession -TimeoutSec $TimeoutSec
		$Total = $InitialResponse.Total

		$Safes += $InitialResponse.Safes

		For ( $Offset = $Limit ; $Offset -lt $Total ; $Offset += $Limit ) {
			Write-Verbose "Getting next result set: ?limit=$Limit&OffSet=$Offset$searchQuery"
			$Safes += (Invoke-PASRestMethod -Uri "$URI`?limit=$Limit&OffSet=$Offset$searchQuery" -Method GET -Headers $sessionToken -WebSession $WebSession -TimeoutSec $TimeoutSec).Safes
		}

		If($Safes) {

			$Safes | Add-ObjectDetail -PropertyToAdd @{

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