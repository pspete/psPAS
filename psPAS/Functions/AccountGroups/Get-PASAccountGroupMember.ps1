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

	begin {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/AccountGroups/$GroupID/Members"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account.Group.Member

		}

	}#process

	end { }#end

}