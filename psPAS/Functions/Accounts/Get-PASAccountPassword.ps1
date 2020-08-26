# .ExternalHelp psPAS-help.xml
function Get-PASAccountPassword {
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