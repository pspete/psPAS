# .ExternalHelp psPAS-help.xml
function Request-PASJustInTimeAccess {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('id')]
		[string]$AccountID
	)

	begin {
		#check minimum version
		Assert-VersionRequirement -RequiredVersion 10.6
	}#begin

	process {

		#Create URL for request (Version 10.4 onwards)
		$URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/grantAdministrativeAccess"

		#Send request to webservice
		Invoke-PASRestMethod -Uri $URI -Method POST

	}#process

	end { }#end

}