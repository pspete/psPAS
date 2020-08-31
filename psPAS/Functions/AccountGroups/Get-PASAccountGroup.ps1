# .ExternalHelp psPAS-help.xml
function Get-PASAccountGroup {
	[CmdletBinding(DefaultParameterSetName = "Gen2")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Gen2"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Gen1"
		)]
		[string]$Safe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Gen1"
		)]
		[Alias("UseClassicAPI")]
		[switch]$UseGen1API
	)

	BEGIN { }#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			"Gen1" {

				Assert-VersionRequirement -RequiredVersion 9.10
				#Create URL for Request
				$URI = "$Script:BaseURI/API/AccountGroups?$($PSBoundParameters | Get-PASParameter | ConvertTo-QueryString)"

				break

			}

			default {

				Assert-VersionRequirement -RequiredVersion 10.5
				#Create URL for Request
				$URI = "$Script:BaseURI/API/Safes/$($Safe | Get-EscapedString)/AccountGroups"

			}

		}


		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account.Group

		}

	}#process

	END { }#end

}