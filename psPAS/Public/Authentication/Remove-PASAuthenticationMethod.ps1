# .ExternalHelp psPAS-help.xml
function Remove-PASAuthenticationMethod {

	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 50)]
		[string]$id
	)

	begin {

		Assert-VersionRequirement -RequiredVersion 11.7

	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/AuthenticationMethods/$($id | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($id, 'Delete Authentication Method')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method DELETE

			if ($null -ne $result) {

				$result

			}

		}

	}#process

	end { }#end

}