# .ExternalHelp psPAS-help.xml
function Get-PASDirectoryMapping {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'All'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Mapping'
		)]
		[Alias('DomainName')]
		[string]$DirectoryName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Mapping'
		)]
		[string]$MappingID

	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.7
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/LDAP/Directories/$DirectoryName/Mappings"

		if ($PSCmdlet.ParameterSetName -eq 'Mapping') {

			#Update URL for request
			$URI = "$URI/$MappingID"

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Directory.Mapping

		}

	}#process

	END { }#end

}