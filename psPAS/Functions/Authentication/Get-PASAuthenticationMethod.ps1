Function Get-PASAuthenticationMethod {
	<#
.SYNOPSIS
List authentication methods

.DESCRIPTION
Returns a list of all existing authentication methods.
Membership of ault admins group required

.PARAMETER ID
The ID of a specific authentication method to return details of

.EXAMPLE
Get-PASAuthenticationMethod

Returns list of all authentication methods.
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateLength(1, 50)]
		[string]$ID

	)

	BEGIN {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/AuthenticationMethods/$($ID | Get-EscapedString)"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession


		If ($null -ne $result) {

			if ($result.Methods) {

				$result = $result | Select-Object -ExpandProperty Methods

			}

			$result

		}

	}#process

	END { }#end


}