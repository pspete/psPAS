function Get-PASOnboardingRule {
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

.EXAMPLE
Get-PASOnboardingRule

List information on all On-boarding rules

.EXAMPLE
Get-PASOnboardingRule -Names Rule1,Rule2

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
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_2"
		)]
		[ValidateNotNullOrEmpty()]
		[string]$Names
	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.2"
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/api/AutomaticOnboardingRules"

		If($PSBoundParameters.ContainsKey("Names")) {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

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
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $WebSession

		if($result) {

			Write-Debug "Rules Found: $($result.Total)"

			$result.AutomaticOnboardingRules |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.OnboardingRule

		}

	}#process

	END {}#end

}