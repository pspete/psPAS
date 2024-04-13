# .ExternalHelp psPAS-help.xml
function Get-PASDirectory {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'id'
		)]
		[Alias('DomainName')]
		[string]$id

	)

	BEGIN {
		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 10.4

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/LDAP/Directories"

		switch ($PSCmdlet.ParameterSetName) {

			'id' {

				Assert-VersionRequirement -RequiredVersion 10.5

				#Update URL for request
				$URI = "$URI/$id/"

				$type = 'psPAS.CyberArk.Vault.Directory.Extended'

				break

			}

			default {

				$type = 'psPAS.CyberArk.Vault.Directory'

				break

			}

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename $type

		}

	}#process

	END { }#end

}