# .ExternalHelp psPAS-help.xml
function Get-PASPlatform {
	[CmdletBinding(DefaultParameterSetName = 'targets')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'platforms'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'targets'
		)]
		[boolean]$Active,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'platforms'
		)]
		[ValidateSet('Regular', 'Group')]
		[string]$PlatformType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'platforms'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'targets'
		)]
		[string]$Search,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'platform-details'
		)]
		[Alias('Name')]
		[string]$PlatformID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'dependents'
		)]
		[switch]$DependentPlatform,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'groups'
		)]
		[switch]$GroupPlatform,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'rotationalGroups'
		)]
		[switch]$RotationalGroup,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'targets'
		)]
		[string]$SystemType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'targets'
		)]
		[boolean]$PeriodicVerify,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'targets'
		)]
		[boolean]$ManualVerify,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'targets'
		)]
		[boolean]$PeriodicChange,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'targets'
		)]
		[boolean]$ManualChange,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'targets'
		)]
		[boolean]$AutomaticReconcile,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'targets'
		)]
		[boolean]$ManualReconcile

	)

	BEGIN {

	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			'platforms' {

				Assert-VersionRequirement -RequiredVersion 11.1

				#Create request URL
				$URI = "$($psPASSession.BaseURI)/API/Platforms"

				#Get Parameters to include in request
				$boundParameters = $PSBoundParameters | Get-PASParameter

				#Create Query String, escaped for inclusion in request URL
				$queryString = $boundParameters | ConvertTo-QueryString

				If ($null -ne $queryString) {
					#Build URL from base URL
					$URI = "$URI`?$queryString"
				}

				break

			}

			'platform-details' {

				Assert-VersionRequirement -RequiredVersion 9.10

				#Create request URL
				$URI = "$($psPASSession.BaseURI)/API/Platforms/$($PlatformID | Get-EscapedString)/"

				break

			}

			'targets' {

				Assert-VersionRequirement -RequiredVersion 11.4

				$URI = "$($psPASSession.BaseURI)/API/Platforms/$($PSCmdlet.ParameterSetName)"

				#Parameter to include parameter value in url
				$Parameters = [Collections.Generic.List[Object]]::New(@('Search'))

				#Get Parameters to include in request filter string
				$filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove $Parameters
				$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters
				$FilterString = $filterParameters | ConvertTo-FilterString

				If ($null -ne $FilterString) {

					$boundParameters = $boundParameters + $FilterString

				}

				#Create Query String, escaped for inclusion in request URL
				$queryString = $boundParameters | ConvertTo-QueryString

				If ($null -ne $queryString) {

					$URI = "$URI`?$queryString"

				}

				break

			}

			default {

				Assert-VersionRequirement -RequiredVersion 11.4

				$URI = "$($psPASSession.BaseURI)/API/Platforms/$($PSCmdlet.ParameterSetName)"

				break

			}

		}

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			#11.1+ returns result under "platforms" property
			If ($null -ne $result.Platforms) {

				$result = $result | Select-Object -ExpandProperty Platforms

				switch ($PSCmdlet.ParameterSetName) {

					'platforms' {
						$result = $result |
							Select-Object @{ Name = 'PlatformID'; Expression = { $_.general.id } }, @{ Name = 'Active'; Expression = { $_.general.active } }, @{ Name = 'Details'; Expression = { [pscustomobject]@{
										'General'                   = $_.general
										'properties'                = $_.properties
										'linkedAccounts'            = $_.linkedAccounts
										'credentialsManagement'     = $_.credentialsManagement
										'sessionManagement'         = $_.sessionManagement
										'privilegedAccessWorkflows' = $_.privilegedAccessWorkflows
									}
								}
							}

						break
					}

					'targets' {
						$result = $result |
							Select-Object PlatformID, Active, @{ Name = 'Details'; Expression = { [pscustomobject]@{
										'ID'                          = $_.ID
										'Name'                        = $_.Name
										'SystemType'                  = $_.SystemType
										'AllowedSafes'                = $_.AllowedSafes
										'CredentialsManagementPolicy' = $_.CredentialsManagementPolicy
										'PrivilegedAccessWorkflows'   = $_.PrivilegedAccessWorkflows
										'PrivilegedSessionManagement' = $_.PrivilegedSessionManagement
									}
								}
							}
						break
					}

					'groups' {
						$result = $result |
							Select-Object PlatformID, Active, @{ Name = 'Details'; Expression = { [pscustomobject]@{
										'ID'   = $_.ID
										'Name' = $_.Name
									}
								}
							}
						break
					}

					'dependents' {
						$result = $result |
							Select-Object PlatformID, @{ Name = 'Details'; Expression = { [pscustomobject]@{
										'ID'                            = $_.ID
										'Name'                          = $_.Name
										'NumberOfLinkedTargetPlatforms' = $_.NumberOfLinkedTargetPlatforms
										'CredentialsManagementPolicy'   = $_.CredentialsManagementPolicy
									}
								}
							}
						break
					}

					'rotationalGroups' {
						$result = $result |
							Select-Object PlatformID, Active, @{ Name = 'Details'; Expression = { [pscustomobject]@{
										'ID'          = $_.ID
										'Name'        = $_.Name
										'GracePeriod' = $_.GracePeriod
									}
								}
							}
						break
					}

				}

			}

			#Return Results
			$result | Add-ObjectDetail -typename 'psPAS.CyberArk.Vault.Platform'

		}

	}#process

	END { }#end

}