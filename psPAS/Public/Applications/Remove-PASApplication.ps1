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

	begin { }#begin

	process {

		#Request URL
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Applications/$($AppID | Get-EscapedString)/"

		if ($PSCmdlet.ShouldProcess($AppID, 'Delete Application')) {

			#Send Request
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	end { }#end

}