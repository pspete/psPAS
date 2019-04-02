function Get-PASSafe {
	<#
.SYNOPSIS
Returns safe details from the vault.

.DESCRIPTION
Gets safe by SafeName, by search query string, or, by default will return all safes.

.PARAMETER SafeName
The name of a specific safe to get details of.

.PARAMETER query
Query String for safe search in the vault

.PARAMETER FindAll
Specify to find all safes.
If SafeName or query are not specified, FindAll is the default behaviour.

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
$token | Get-PASSafe -SafeName SAFE1

Returns details of "Safe1"

.INPUTS
SafeName, SessionToken, WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Safe
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK

#>
	[CmdletBinding(DefaultParameterSetName = "byAll")]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byName"
		)]
		[ValidateNotNullOrEmpty()]
		[string]$SafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "byQuery"
		)]
		[string]$query,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "byAll"
		)]
		[switch]$FindAll,

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
		$URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Safes"

		#If SafeName specified
		If($($PSCmdlet.ParameterSetName) -eq "byName") {

			$returnProperty = "GetSafeResult"

			#Build URL from base URL
			$URI = "$URI/$($SafeName | Get-EscapedString)"

		}

		#If search query specified
		ElseIf($($PSCmdlet.ParameterSetName) -eq "byQuery") {

			$returnProperty = "SearchSafesResult"

			#Get Parameters to include in request
			$boundParameters = $PSBoundParameters | Get-PASParameter

			#Create Query String, escaped for inclusion in request URL
			$queryString = ($boundParameters.keys | ForEach-Object {

					"$_=$($boundParameters[$_] | Get-EscapedString)"

				}) -join '&'

			#Build URL from base URL
			$URI = "$URI`?$queryString"

		}

		ElseIf($($PSCmdlet.ParameterSetName) -eq "byAll") {

			$returnProperty = "GetSafesResult"

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession -TimeoutSec $TimeoutSec

		If($result) {

			$result.$returnProperty | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe -PropertyToAdd @{

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