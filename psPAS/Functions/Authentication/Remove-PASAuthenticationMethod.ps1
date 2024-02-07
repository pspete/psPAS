# .ExternalHelp psPAS-help.xml
Function Remove-PASAuthenticationMethod {

	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 50)]
		[string]$id
	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.7

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/AuthenticationMethods/$($id | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($id, 'Delete Authentication Method')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method DELETE

			If ($null -ne $result) {

				$result

			}

		}

	}#process

	END { }#end

}