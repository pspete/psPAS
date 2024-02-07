# .ExternalHelp psPAS-help.xml
Function Remove-PASOpenIDConnectProvider {

	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$id

	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.7

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/OIDC/Providers/$($id | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($id, 'Delete OIDC Provider')) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	END { }#end

}