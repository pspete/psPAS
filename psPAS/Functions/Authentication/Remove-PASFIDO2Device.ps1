# .ExternalHelp psPAS-help.xml
Function Remove-PASFIDO2Device {

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

		Assert-VersionRequirement -RequiredVersion 14.6

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/fido2/keys/$($id | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($id, 'Delete FIDO2 Device')) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	END { }#end

}
