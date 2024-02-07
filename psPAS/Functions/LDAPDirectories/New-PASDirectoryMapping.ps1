# .ExternalHelp psPAS-help.xml
function New-PASDirectoryMapping {
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
		[string]$MappingName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$LDAPBranch,

		[parameter(
			Mandatory = $true,
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
			ValueFromPipelinebyPropertyName = $true
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

	}#begin

	PROCESS {

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove DirectoryName, MappingAuthorizations

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

			{ $_ -match 'VaultGroups|Location|LDAPQuery' } {

				#v10.7
				Assert-VersionRequirement -RequiredVersion 10.7
				Continue

			}

			{ $_ -match 'UsedQuota|AuthorizedInterfaces|EnableENEWhenDisconnected' } {

				#v10.7
				Assert-VersionRequirement -RequiredVersion 14.0
				Continue

			}

			Default {

				#v10.4
				Assert-VersionRequirement -RequiredVersion 10.4

			}

		}

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/LDAP/Directories/$DirectoryName/Mappings/"

		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($MappingName, 'Create Directory Mapping')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

			If ($null -ne $result) {

				#Return Results
				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Directory.Mapping

			}

		}

	}#process

	END { }#end

}