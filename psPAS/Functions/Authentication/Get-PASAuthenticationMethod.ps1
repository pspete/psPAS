# .ExternalHelp psPAS-help.xml
Function Get-PASAuthenticationMethod {
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

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/AuthenticationMethods/$($ID | Get-EscapedString)"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession


		If ($null -ne $result) {

			if ($null -ne $result.Methods) {

				$result = $result | Select-Object -ExpandProperty Methods

			}

			$result

		}

	}#process

	END { }#end


}