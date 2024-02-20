# .ExternalHelp psPAS-help.xml
function Remove-PASGroupMember {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('ID')]
		[string]$GroupID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('UserName')]
		[string]$Member
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.5
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/UserGroups/$GroupID/members/$Member/"

		if ($PSCmdlet.ShouldProcess($GroupID, "Remove Group Member $Member")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	END { }#end

}