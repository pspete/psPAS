﻿function Get-PASOnboardingRule {
	<#
.SYNOPSIS
Gets all automatic on-boarding rules

.DESCRIPTION
Returns information on defined on-boarding rules.
Vault Admin membership required.

.PARAMETER Names
A filter that specifies the rule name.
Separate a list of rules with commas.
If not specified, all rules will be returned.
For version 10.2 onwards (not a supported parameter on earlier versions)

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
$token | Get-PASOnboardingRule

List information on all On-boarding rules

.EXAMPLE
$token | Get-PASOnboardingRule -Names Rule1,Rule2

List information on On-boarding rules "Rule1" & "Rule2"

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.OnboardingRule
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Not Tested

.LINK

#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$Names,

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
		[string]$PVWAAppName = "PasswordVault"
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/api/AutomaticOnboardingRules"

		If($PSBoundParameters.ContainsKey("Names")) {

			#Get Parameters to include in request
			$boundParameters = $PSBoundParameters | Get-PASParameter

			#Create Query String, escaped for inclusion in request URL
			$queryString = ($boundParameters.keys | ForEach-Object {

					"$_=$($boundParameters[$_])"

				})

			#Build URL from base URL
			$URI = "$URI`?$queryString"

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

		Write-Debug "Rules Found: $($result.Total)"

		$result.AutomaticOnboardingRules |

		Add-ObjectDetail -typename psPAS.CyberArk.Vault.OnboardingRule -PropertyToAdd @{

			"sessionToken" = $sessionToken
			"WebSession"   = $WebSession
			"BaseURI"      = $BaseURI
			"PVWAAppName"  = $PVWAAppName

		}

	}#process

	END {}#end

}