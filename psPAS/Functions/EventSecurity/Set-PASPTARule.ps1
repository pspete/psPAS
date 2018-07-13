Function Set-PASPTARule {
	<#
	.SYNOPSIS
	Updates an existing Risky Activity rule to PTA

	.DESCRIPTION
	Updates an existing Risky Activity rule in the PTA server configuration.

	.PARAMETER id
	The unique ID of the rule.

	.PARAMETER category
	The Category of the risky activity
	Valid values: SSH, WINDOWS, SCP, KEYSTROKES or SQL

	.PARAMETER regex
	Risky activity in regex form.
	Must support all characters (including "/" and escaping characters)

	.PARAMETER score
	Activity score.
	Number must be between 1 and 100

	.PARAMETER description
	Activity description.
	The field is mandatory but can be empty

	.PARAMETER response
	Automatic response to be executed
	Valid Values: NONE, TERMINATE or SUSPEND

	.PARAMETER active
	Indicate if the rule should be active or disbaled

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
	$token | Set-PASPTARule -id 66 -category KEYSTROKES -regex '(*.)risky cmd(.*)' -score 65 -description "Updated Rule" -response SUSPEND -active $true

	Updates rule 66 in PTA

	.NOTES
	Minimum Version CyberArk 10.4
	#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string][int]$id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("SSH", "WINDOWS", "SCP", "KEYSTROKES", "SQL")]
		[string]$category,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$regex,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateRange(1, 100)]
		[int]$score,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("NONE", "TERMINATE", "SUSPEND")]
		[string]$response,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$active,

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

	BEGIN {

		$MinimumVersion = [System.Version]"10.4"

	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#Create URL for Request
		$URI = "$baseURI/$PVWAAppName/API/pta/API/Settings/RiskyActivity/"


		#Create body of request
		$body = $boundParameters | ConvertTo-Json

		if($PSCmdlet.ShouldProcess($id, "Update Risky Activity Rule")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -Headers $sessionToken -WebSession $WebSession

		}

	}#process

	END {}#end
}