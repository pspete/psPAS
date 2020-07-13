function Get-PASPlatform {
	<#
.SYNOPSIS
Retrieves details of Vault platforms.

.DESCRIPTION
Request platform configuration information from the Vault.

11.4+ can return detials of target, dependent, group & rotational group platforms,
with additional filters available for target group queries.
11.1+ can return details of all target platforms.
Limited filters can be used to retrieve a subset of the platforms

For 9.10+, the "PlatformID" parameter must be used to retrieve details of a single
specified platform from the Vault.

The output contained under the "Details" property differs depending
on which method (9.10+,11.1+ or 11.4) is used, and which platform type is queried.

.PARAMETER Active
Filter active/inactive platforms

.PARAMETER PlatformType
Filter regular/group platforms

.PARAMETER Search
Filter platform by search pattern

.PARAMETER PlatformID
The unique ID/Name of the platform.

.PARAMETER DependentPlatform
Specify to return details of dependent platforms

.PARAMETER GroupPlatform
Specify to return details of group platforms

.PARAMETER RotationalGroup
Specify to return details of rotational group platforms

.PARAMETER SystemType
Filter target platforms for specific system type

.PARAMETER PeriodicVerify
Filter target platforms by periodic verification configuration

.PARAMETER ManualVerify
Filter target platforms by manual verification configuration

.PARAMETER PeriodicChange
Filter target platforms by periodic change configuration

.PARAMETER ManualChange
Filter target platforms by manual change configuration

.PARAMETER AutomaticReconcile
Filter target platforms by automatic reconciliation configuration

.PARAMETER ManualReconcile
Filter target platforms by manual reconciliation configuration

.EXAMPLE
Get-PASPlatform

Return details of all platforms

.EXAMPLE
Get-PASPlatform -Active $true

Get all active platforms

.EXAMPLE
Get-PASPlatform -Active $true -Search "WIN_"

Get active platforms matching search string "WIN_"

.EXAMPLE
Get-PASPlatform -PlatformID "CyberArk"

Get details of specific platform CyberArk

.EXAMPLE
Get-PASPlatform -GroupPlatform

Get details of all group platfoms

.EXAMPLE
Get-PASPlatform -RotationalGroup

Get details of all rotational group platforms

.EXAMPLE
Get-PASPlatform -DependentPlatform

Get details of all dependent platforms

.EXAMPLE
Get-PASPlatform -Active $false -SystemType Windows

Get details of all deactivated Windows platforms

.EXAMPLE
Get-PASPlatform -Active $true -SystemType '*NIX' -AutomaticReconcile $true

Get details of all active Unix platforms configured for automatic reconciliation.

.NOTES
Minimum CyberArk version 9.10
CyberArk version 11.1 required for Active, PlatformType & Search paramters.
CyberArk version 11.4 required for extended filters for target platforms,
and requests for  dependent, group & rotational group platforms

.LINK
https://pspas.pspete.dev/commands/Get-PASPlatform
#>

	[CmdletBinding(DefaultParameterSetName = "targets")]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "targets"
		)]
		[boolean]$Active,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[ValidateSet("Regular", "Group")]
		[string]$PlatformType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_1"
		)]
		[string]$Search,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[Alias("Name")]
		[string]$PlatformID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "dependents"
		)]
		[switch]$DependentPlatform,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "groups"
		)]
		[switch]$GroupPlatform,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "rotationalGroups"
		)]
		[switch]$RotationalGroup,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "targets"
		)]
		[string]$SystemType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "targets"
		)]
		[boolean]$PeriodicVerify,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "targets"
		)]
		[boolean]$ManualVerify,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "targets"
		)]
		[boolean]$PeriodicChange,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "targets"
		)]
		[boolean]$ManualChange,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "targets"
		)]
		[boolean]$AutomaticReconcile,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "targets"
		)]
		[boolean]$ManualReconcile

	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.10"
		$RequiredVersion = [System.Version]"11.1"
		$Version114 = [System.Version]"11.4"
	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			"11_1" {
				Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $RequiredVersion

				#Create request URL
				$URI = "$Script:BaseURI/API/Platforms"

				#Get Parameters to include in request
				$boundParameters = $PSBoundParameters | Get-PASParameter

				#Create Query String, escaped for inclusion in request URL
				$queryString = $boundParameters | ConvertTo-QueryString

				If ($queryString) {
					#Build URL from base URL
					$URI = "$URI`?$queryString"
				}

				break

			}

			"legacy" {
				Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

				#Create request URL
				$URI = "$Script:BaseURI/API/Platforms/$($PlatformID | Get-EscapedString)"
				break
			}

			"targets" {
				Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $Version114

				$URI = "$Script:BaseURI/API/Platforms/$($PSCmdlet.ParameterSetName)"

				#Get Parameters to include in request
				$boundParameters = $PSBoundParameters | Get-PASParameter

				$queryString = $boundParameters | ConvertTo-QueryString -Format Filter

				If ($queryString) {
					$URI = "$URI`?filter=$queryString"
				}

				break
			}

			default {
				Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $Version114

				$URI = "$Script:BaseURI/API/Platforms/$($PSCmdlet.ParameterSetName)"
				break
			}

		}

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($result) {

			#11.1+ returns result under "platforms" property
			If ($result.Platforms) {
				$Global:Object = $result
				$result = $result | Select-Object -ExpandProperty Platforms
				switch ($PSCmdlet.ParameterSetName) {

					"11_1" {
						$result = $result |
						Select-Object @{ Name = 'PlatformID'; Expression = { $_.general.id } }, @{ Name = 'Active'; Expression = { $_.general.active } }, @{ Name = 'Details'; Expression = { [pscustomobject]@{
									"General"                   = $_.general
									"properties"                = $_.properties
									"linkedAccounts"            = $_.linkedAccounts
									"credentialsManagement"     = $_.credentialsManagement
									"sessionManagement"         = $_.sessionManagement
									"privilegedAccessWorkflows" = $_.privilegedAccessWorkflows
								}
							}
						}

						break
					}

					"targets" {
						$result = $result |
						Select-Object PlatformID, Active, @{ Name = 'Details'; Expression = { [pscustomobject]@{
									"ID"                          = $_.ID
									"Name"                        = $_.Name
									"SystemType"                  = $_.SystemType
									"AllowedSafes"                = $_.AllowedSafes
									"CredentialsManagementPolicy" = $_.CredentialsManagementPolicy
									"PrivilegedAccessWorkflows"   = $_.PrivilegedAccessWorkflows
									"PrivilegedSessionManagement" = $_.PrivilegedSessionManagement
								}
							}
						}
						break
					}

					"groups" {
						$result = $result |
						Select-Object PlatformID, Active, @{ Name = 'Details'; Expression = { [pscustomobject]@{
									"ID"   = $_.ID
									"Name" = $_.Name
								}
							}
						}
						break
					}

					"dependents" {
						$result = $result |
						Select-Object PlatformID, @{ Name = 'Details'; Expression = { [pscustomobject]@{
									"ID"                            = $_.ID
									"Name"                          = $_.Name
									"NumberOfLinkedTargetPlatforms" = $_.NumberOfLinkedTargetPlatforms
									"CredentialsManagementPolicy"   = $_.CredentialsManagementPolicy
								}
							}
						}
						break
					}

					"rotationalGroups" {
						$result = $result |
						Select-Object PlatformID, Active, @{ Name = 'Details'; Expression = { [pscustomobject]@{
									"ID"          = $_.ID
									"Name"        = $_.Name
									"GracePeriod" = $_.GracePeriod
								}
							}
						}
						break
					}

				}

			}

			#Return Results
			$result |

			Add-ObjectDetail -typename "psPAS.CyberArk.Vault.Platform"

		}

	}#process

	END { }#end

}