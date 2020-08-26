# .ExternalHelp psPAS-help.xml
function Remove-PASAccountGroupMember {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$AccountID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$GroupID
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$Script:BaseURI/API/AccountGroups/$GroupID/Members/$AccountID"

		if ($PSCmdlet.ShouldProcess($AccountID, "Delete Member from Account Group $($GroupID)")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}