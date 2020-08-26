# .ExternalHelp psPAS-help.xml
function Get-PASAccountGroup {
	[CmdletBinding(DefaultParameterSetName = "10.5")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10.5"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "9.10"
		)]
		[string]$Safe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "9.10"
		)]
		[switch]$UseClassicAPI
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName
	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			"9.10" {

				#Create URL for Request
				$URI = "$Script:BaseURI/API/AccountGroups?$($PSBoundParameters | Get-PASParameter | ConvertTo-QueryString)"

				break

			}

			default {

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