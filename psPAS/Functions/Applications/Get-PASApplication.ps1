function Get-PASApplication {
	<#
.SYNOPSIS
Returns details of applications in the Vault

.DESCRIPTION
Returns information on Applications from the Vault.
Results can be filtered by specifying additional parameters.
Applications can be found by name, or searched for.
Audit Users permission is required.

.PARAMETER AppID
Application Name

.PARAMETER ExactMatch
By Default, the function will search the vault.
All found applications (based on parameters supplied) will be returned.
When Specifying this parameter, the function will not search;
data for the supplied AppID will be returned.

.PARAMETER Location
Location of the application in the Vault hierarchy.
Default=\

.PARAMETER IncludeSubLocations
Will search be carried out in sublocations of specified location?
Boolean

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
$token | Get-PASApplication

Returns information on all defined applications

.EXAMPLE
$token | Get-PASApplication NewApp -ExactMatch

Gets details of the application "NewApp":

AppID  Description       Location Disabled
-----  -----------       -------- --------
NewApp A new application \        False

.EXAMPLE
$token | Get-PASApplication NewApp

Gets details of all application matching "NewApp":

AppID   Description       Location Disabled
-----   -----------       -------- --------
NewApp  A new application \        False
NewApp1 A new application \        False
NewApp7 A new application \        False

.INPUTS
All parameters can be piped by property name, except ExactMatch
Should accept pipeline objects from other *-PASApplication* functions

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Application
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK

#>
	[Alias("Get-PASApplications")]
	[CmdletBinding(DefaultParameterSetName = 'byQuery')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byAppID"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AppID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "byAppID"
		)]
		[switch]$ExactMatch,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[ValidateNotNullOrEmpty()]
		[string]$Location,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[boolean]$IncludeSublocations,

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

		#Base URL for Request
		$URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Applications"

		#If AppID specified
		If($($PSCmdlet.ParameterSetName) -eq "byAppID") {

			#Build URL from base URL
			$URI = "$URI/$($AppID | Get-EscapedString)"

		}

		#If search query specified
		ElseIf($($PSCmdlet.ParameterSetName) -eq "byQuery") {

			#Get Parameters to include in request
			$boundParameters = $PSBoundParameters | Get-PASParameter

			#Create query string
			$query = ($boundParameters.keys | ForEach-Object {

					"$_=$($boundParameters[$_] | Get-EscapedString)"

				}) -join '&'

			#Build URL from base URL
			$URI = "$URI`?$query"

		}

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

		if($result) {

			#Return results
			$result.application | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Application -PropertyToAdd @{

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