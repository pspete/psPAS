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

.EXAMPLE
Get-PASSafe -SafeName SAFE1

Returns details of "Safe1"

.LINK
https://pspas.pspete.dev/commands/Get-PASSafe
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
		[int]$TimeoutSec
	)

	BEGIN { }#begin

	PROCESS {

		#Create base URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Safes"

		#If SafeName specified
		If ($($PSCmdlet.ParameterSetName) -eq "byName") {

			$returnProperty = "GetSafeResult"

			#Build URL from base URL
			$URI = "$URI/$($SafeName | Get-EscapedString)"

		}

		#If search query specified
		ElseIf ($($PSCmdlet.ParameterSetName) -eq "byQuery") {

			$returnProperty = "SearchSafesResult"

			#Get Parameters to include in request
			$boundParameters = $PSBoundParameters | Get-PASParameter

			#Create Query String, escaped for inclusion in request URL
			$queryString = $boundParameters | ConvertTo-QueryString

			if ($queryString) {

				#Build URL from base URL
				$URI = "$URI`?$queryString"

			}

		}

		ElseIf ($($PSCmdlet.ParameterSetName) -eq "byAll") {

			$returnProperty = "GetSafesResult"

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession -TimeoutSec $TimeoutSec

		If ($result) {

			$result.$returnProperty | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe

		}

	}#process

	END { }#end

}