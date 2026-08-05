# .ExternalHelp psPAS-help.xml
function Remove-PASOAuthProvider {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$id

	)

	begin { 
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 15.0
    }#begin

	process {

		#Create URL string for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/OAuth/Providers/$($id | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($id, 'Delete OAuth Provider')) {

			#Send Request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	end { }#end

}