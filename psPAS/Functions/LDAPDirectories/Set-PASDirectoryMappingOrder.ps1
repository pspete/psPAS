# .ExternalHelp psPAS-help.xml
function Set-PASDirectoryMappingOrder {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$DirectoryName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int[]]$MappingsOrder
	)

	begin {

		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 10.10

	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/LDAP/Directories/$DirectoryName/Mappings/Reorder/"

		#Get request parameters
		$body = $($PSBoundParameters | Get-PASParameter -ParametersToRemove DirectoryName) | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($DirectoryName, 'Update Directory Mapping Order')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	end { }#end

}