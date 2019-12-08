function Get-PASPlatform {
	<#
	.SYNOPSIS
	Retrieves details of Vault platforms.

	.DESCRIPTION
	Request platform configuration information from the Vault.
	
	11.1+ can return details of all platforms.
	Filters can be used to retrieve a subset of the platforms

	For 9.10+, the "PlatformID" parameter must be used to retrieve details of a single 
	specified platform from the Vault.

	The output contained under the "Details" property differs depending 
	on which method (9.10+ or 11.1+) is used. 

	.PARAMETER Active
	Filter active/inactive platforms

	.PARAMETER PlatformType
	Filter regular/group platforms

	.PARAMETER Search
	Filter platform by search pattern

	.PARAMETER PlatformID
	The unique ID/Name of the platform.

	.EXAMPLE
	Get-PASPlatform

	Return details of all platforms

	.EXAMPLE
	Get-PASPlatform -Active $true

	Get all active platforms

	.EXAMPLE
	Get-PASPlatform -Active $true -Search "WIN_"

	Get active platforms matching search string "WIN_"

	.EXAMPLE
	Get-PASPlatform -PlatformID "CyberArk"

	Get details of specific platform CyberArk

	.NOTES
	Minimum CyberArk version 9.10
	CyberArk version 11.1 required for Active, PlatformType & Search paramters.
	#>

	[CmdletBinding(DefaultParameterSetName = "11_1")]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[boolean]$Active,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateSet("Regular", "Group")]
		[string]$PlatformType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[string]$Search,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[Alias("Name")]
		[string]$PlatformID
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.10"
		$RequiredVersion = [System.Version]"11.1"
	}#begin

	PROCESS {

		If ($PSCmdlet.ParameterSetName -eq "11_1") {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $RequiredVersion

			#Create request URL
			$URI = "$Script:BaseURI/API/Platforms"

			#Get Parameters to include in request
			$boundParameters = $PSBoundParameters | Get-PASParameter

			#Create Query String, escaped for inclusion in request URL
			$queryString = ($boundParameters.keys | ForEach-Object {

					"$_=$($boundParameters[$_] | Get-EscapedString)"

				}) -join '&'

			#Build URL from base URL
			$URI = "$URI`?$queryString"

		}

		ElseIf ($PSCmdlet.ParameterSetName -eq "legacy") {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

			#Create request URL
			$URI = "$Script:BaseURI/API/Platforms/$($PlatformID | Get-EscapedString)"

		}

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($result) {

			#11.1 returns result under "platforms" property
			If ($result.Platforms) {

				$result = $result | Select-Object -ExpandProperty Platforms | 
				Select-Object @{ Name = 'PlatformID'; Expression = { $_.general.id } }, @{ Name = 'Active'; Expression = { $_.general.active } }, @{ Name = 'Details'; Expression = { [pscustomobject]@{
							"General"                   = $_.general
							"properties"                = $_.properties
							"linkedAccounts"            = $_.linkedAccounts
							"credentialsManagement"     = $_.credentialsManagement
							"sessionManagement"         = $_.sessionManagement
							"privilegedAccessWorkflows" = $_.privilegedAccessWorkflows
						} 
					} 
    			}

			}

			#Return Results
			$result |

			Add-ObjectDetail -typename "psPAS.CyberArk.Vault.Platform"

		}

	}#process

	END { }#end

}