# .ExternalHelp psPAS-help.xml
function Get-PASAccountGroupMember {
	[CmdletBinding()]
	param(
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
		$URI = "$Script:BaseURI/API/AccountGroups/$GroupID/Members"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account.Group.Member

		}

	}#process

	END { }#end

}