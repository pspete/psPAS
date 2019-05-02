function Get-PASUser {
	<#
.SYNOPSIS
Returns details of a user

.DESCRIPTION
Returns information on specific vault user.

.PARAMETER Search
Search string.

.PARAMETER UserType
The type of the user.

.PARAMETER ComponentUser
Whether the user is a known component or not.

.PARAMETER UserName
The user's name

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
$token | Get-PASUser

Returns information for all found Users

.EXAMPLE
$token | Get-PASUser -search SearchTerm -ComponentUser $False

Returns information for all matching Users

.EXAMPLE
$token | Get-PASUser -UserName Target_User

Displays information on Target_User

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.User
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK

#>
	[CmdletBinding(DefaultParameterSetName = "10_9")]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[string]$Search,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[string]$UserType,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_9"
		)]
		[boolean]$ComponentUser,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[string]$UserName,

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
		$MinimumVersion = [System.Version]"10.9"
	}#begin

	PROCESS {

		If ($PSCmdlet.ParameterSetName -eq "10_9") {

			Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

			#Create URL for request
			$URI = "$baseURI/$PVWAAppName/api/Users"

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

			#Create URL for request
			$URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)"

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

		#Handle V10 return
		if ($result.Users) {

			$result.Users | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User.Extended -PropertyToAdd @{

				"sessionToken"    = $sessionToken
				"WebSession"      = $WebSession
				"BaseURI"         = $BaseURI
				"PVWAAppName"     = $PVWAAppName
				"ExternalVersion" = $ExternalVersion

			}

		}

		#Handle legacy return
		ElseIf ($result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User -PropertyToAdd @{

				"sessionToken"    = $sessionToken
				"WebSession"      = $WebSession
				"BaseURI"         = $BaseURI
				"PVWAAppName"     = $PVWAAppName
				"ExternalVersion" = $ExternalVersion

			}

		}



	}#process

	END { }#end

}