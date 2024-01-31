# .ExternalHelp psPAS-help.xml
function Set-PASDirectoryMapping {
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
		[ValidateLength(1, 28)]
		[string]$MappingID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$MappingName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$LDAPBranch,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string[]]$DomainGroups,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string[]]$VaultGroups,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Location,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$LDAPQuery,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[Authorizations]$MappingAuthorizations,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateRange(1, 3650)]
		[int]$UserActivityLogPeriod,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$UsedQuota,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('PIMSU', 'PSM', 'PSMP', 'PVWA', 'WINCLIENT', 'PTA', 'PACLI', 'NAPI', 'XAPI', 'HTTPGW',
			'EVD', 'PIMSu', 'AIMApp', 'CPM', 'PVWAApp', 'PSMApp', 'AppPrv', 'AIMApp', 'PSMPApp', 'GUI')]
		[string[]]$AuthorizedInterfaces,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$EnableENEWhenDisconnected

	)

	BEGIN {

		#10.7 functionality
		Assert-VersionRequirement -RequiredVersion 10.7

	}#begin

	PROCESS {

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove DirectoryName, MappingID, MappingAuthorizations

		#Ensure minimum required version is being used.
		switch ($PSBoundParameters.Keys) {

			'MappingAuthorizations' {

				#Transform MappingAuthorizations
				$boundParameters.Add('MappingAuthorizations', [array][int]$MappingAuthorizations)
				Continue

			}

			'UserActivityLogPeriod' {

				#v10.10
				Assert-VersionRequirement -RequiredVersion 10.10
				Continue

			}

			{ $_ -match 'UsedQuota|AuthorizedInterfaces|EnableENEWhenDisconnected' } {

				#v10.7
				Assert-VersionRequirement -RequiredVersion 14.0
				Continue

			}

		}

		#Create URL for request
		$URI = "$Script:BaseURI/api/Configuration/LDAP/Directories/$DirectoryName/Mappings/$MappingID/"

		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($MappingID, 'Update Directory Mapping')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -WebSession $Script:WebSession

			If ($null -ne $result) {

				#Return Results
				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Directory.Mapping

			}

		}

	}#process

	END { }#end

}