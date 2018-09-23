function Get-PASAccountPassword {
	<#
.SYNOPSIS
Returns password for an account.

.DESCRIPTION
Returns password for an account identified by its AccountID.

If using version 9.7+ of the API:
 - Will not return SSH Keys.
 - Cannot be used if a reason for password access must be specified.

If using version 10.1+ of the API:
 - Will return SSH key of an existing account
 - Can be used if a reason and/or ticket ID must be specified.

.PARAMETER AccountID
The ID of the account whose password will be retrieved.

.PARAMETER UseV10API
Specify switch to explicitly use the version 10 api when only providing AccountID.

.PARAMETER Reason
The reason that is required to be specified to retrieve the password/SSH key.
Use of parameter requires version 10.1 at a minimum.

.PARAMETER TicketingSystemName
The name of the Ticketing System.
Use of parameter requires version 10.1 at a minimum.

.PARAMETER TicketId
The ticket ID of the ticketing system.
Use of parameter requires version 10.1 at a minimum.

.PARAMETER Version
The version number of the required password.
If there are no previous versions, the current password/key version is returned.
Use of parameter requires version 10.1 at a minimum.

.PARAMETER ActionType
The action this password will be used for.
Use of parameter requires version 10.1 at a minimum.

.PARAMETER isUse
Internal parameter (for PSMP only).
Use of parameter requires version 10.1 at a minimum.

.PARAMETER Machine
The address of the remote machine to connect to.
Use of parameter requires version 10.1 at a minimum.

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
If the minimum version requirement of this function is not satisfied, execution will be halted.
Omitting a value for this parameter, or supplying a version of "0.0" will skip the version check.

.EXAMPLE
$token | Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword

Will return the password value of the account found by Get-PASAccount:

Password
--------
Ra^D0MwM666*&U

.EXAMPLE
$token | Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword -UseV10API

Will retrieve the password value of the account found by Get-PASAccount using the v10 API:

Password
--------
Ra^D0MwM666*&U

.EXAMPLE
$token | Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword -Reason "Incident Investigation"

Will retrieve the password value of the account found by Get-PASAccount using the v10 API, and specify a reason for access.

Password
--------
Ra^D0MwM666*&U

.INPUTS
All parameters can be piped by property name
Accepts pipeline input from other Get-PASAccount

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Credential
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Minimum API version is 9.7 for password retrieval only.
From version 10.1 onwards both passwords and ssh keys can be retrieved.

.LINK
#>
	[Alias("Get-PASAccountCredentials")]
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("id")]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v10"
		)]
		[switch]$UseV10API,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v10"
		)]
		[string]$Reason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v10"
		)]
		[string]$TicketingSystemName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v10"
		)]
		[string]$TicketId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v10"
		)]
		[int]$Version,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v10"
		)]
		[ValidateSet("show", "copy", "connect")]
		[string]$ActionType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v10"
		)]
		[boolean]$isUse,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v10"
		)]
		[switch]$Machine,

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
		$MinimumVersion = [System.Version]"10.1"
	}#begin

	PROCESS {

		#Build Request
		if($($PSCmdlet.ParameterSetName) -eq "v10") {

			Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

			#For Version 10.1+
			$Request = @{

				"URI"    = "$baseURI/$PVWAAppName/api/Accounts/$($AccountID |

            	Get-EscapedString)/Password/Retrieve"

				"Method" = "POST"

				#Get all parameters that will be sent in the request
				"Body"   = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID, UseV10API | ConvertTo-Json

			}

		}

		Else {

			#For Version 9.7+
			$Request = @{

				"URI"    = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Accounts/$($AccountID |

				Get-EscapedString)/Credentials"

				"Method" = "GET"

			}

		}

		#Add default Request parameters
		$Request.Add("Headers", $sessionToken)
		$Request.Add("WebSession", $WebSession)

		#splat request to web service
		$result = Invoke-PASRestMethod @Request

		If($result) {

			If($result.GetType().Name -eq "Object[]") {

				$result = [System.Text.Encoding]::ASCII.GetString($result)

			}

			[PSCustomObject] @{"Password" = $result} |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.Credential -PropertyToAdd @{

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