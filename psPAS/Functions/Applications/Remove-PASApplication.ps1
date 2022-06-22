# .ExternalHelp psPAS-help.xml
function Remove-PASApplication {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AppID
	)

	BEGIN { }#begin

	PROCESS {

		#Request URL
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Applications/$($AppID | Get-EscapedString)/"

		if ($PSCmdlet.ShouldProcess($AppID, 'Delete Application')) {

			#Send Request
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}