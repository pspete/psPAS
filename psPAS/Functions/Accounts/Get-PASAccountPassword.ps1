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

.PARAMETER UseClassicAPI
Specify the UseClassicAPI to force usage the Classic (v9) API endpoint.

.PARAMETER Reason
The reason that is required to be specified to retrieve the password/SSH key.
Use of parameter requires version 10.1 at a minimum.

.PARAMETER TicketingSystem
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

.EXAMPLE
Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword

Will return the password value of the account found by Get-PASAccount:

Password
--------
Ra^D0MwM666*&U

.EXAMPLE
Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword -UseClassicAPI

Will retrieve the password value of the account found by Get-PASAccount using the classic (v9) API:

Password
--------
Ra^D0MwM666*&U

.EXAMPLE
Get-PASAccount -Keywords root -Safe Prod_Safe | Get-PASAccountPassword -Reason "Incident Investigation"

Will retrieve the password value of the account found by Get-PASAccount using the v10 API, and specify a reason for access.

Password
--------
Ra^D0MwM666*&U

.INPUTS
All parameters can be piped by property name
Accepts pipeline input from other Get-PASAccount

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Credential
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Minimum API version is 9.7 for password retrieval only.
From version 10.1 onwards both passwords and ssh keys can be retrieved.

.LINK
https://pspas.pspete.dev/commands/Get-PASAccountPassword
#>
	[CmdletBinding(DefaultParameterSetName = "10.1")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "ClassicAPI"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10.1"
		)]
		[Alias("id")]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "ClassicAPI"
		)]
		[switch]$UseClassicAPI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "10.1"
		)]
		[string]$Reason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "10.1"
		)]
		[string]$TicketingSystem,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "10.1"
		)]
		[string]$TicketId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "10.1"
		)]
		[int]$Version,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "10.1"
		)]
		[ValidateSet("show", "copy", "connect")]
		[string]$ActionType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "10.1"
		)]
		[boolean]$isUse,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "10.1"
		)]
		[switch]$Machine
	)

	BEGIN {

	}#begin

	PROCESS {

		#Build Request
		switch ($PSCmdlet.ParameterSetName) {

			"10.1" {

				Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName

				#For Version 10.1+
				$Request = @{

					"URI"    = "$Script:BaseURI/api/Accounts/$($AccountID |

            	Get-EscapedString)/Password/Retrieve"

					"Method" = "POST"

					#Get all parameters that will be sent in the request
					"Body"   = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID | ConvertTo-Json

				}

				break

			}

			"ClassicAPI" {

				#For Version 9.7+
				$Request = @{

					"URI"    = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$($AccountID | Get-EscapedString)/Credentials"

					"Method" = "GET"

				}

				break

			}

		}

		#Add default Request parameters
		$Request.Add("WebSession", $Script:WebSession)

		#splat request to web service
		$result = Invoke-PASRestMethod @Request

		If ($null -ne $result) {

			switch ($PSCmdlet.ParameterSetName) {

				"ClassicAPI" {

					$result = [System.Text.Encoding]::ASCII.GetString([PSCustomObject]$result.Content)

					break

				}

				"10.1" {

					#Unescape returned string and remove enclosing quotes.
					$result = $([System.Text.RegularExpressions.Regex]::Unescape($result) -replace '^"|"$', '')

					break

				}

			}

			[PSCustomObject] @{"Password" = $result } |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.Credential

		}

	}#process

	END { }#end

}