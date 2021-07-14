# .ExternalHelp psPAS-help.xml
function Request-PASJustInTimeAccess {
	[CmdletBinding()]
	[Alias('Request-PASAdHocAccess')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('id')]
		[string]$AccountID
	)

	BEGIN {
		#check minimum version
		Assert-VersionRequirement -RequiredVersion 10.6
	}#begin

	PROCESS {

		#Create URL for request (Version 10.4 onwards)
		$URI = "$Script:BaseURI/api/Accounts/$AccountID/grantAdministrativeAccess"

		#Send request to webservice
		Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

	}#process

	END { }#end

}