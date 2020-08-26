# .ExternalHelp psPAS-help.xml
function Get-PASAccount {
	[CmdletBinding(DefaultParameterSetName = "v10ByQuery")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10ByID"
		)]
		[Alias("AccountID")]
		[string]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10ByFilter"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10ByQuery"
		)]
		[string]$search,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10ByFilter"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10ByQuery"
		)]
		[ValidateSet("startswith", "contains")]
		[string]$searchType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10ByQuery"
		)]
		[string]$safeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10ByQuery"
		)]
		[datetime]$modificationTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10ByFilter"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10ByQuery"
		)]
		[string[]]$sort,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10ByFilter"
		)]
		[int]$offset,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10ByFilter"
		)]
		[ValidateRange(1, 1000)]
		[int]$limit,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v10ByFilter"
		)]
		[string]$filter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9"
		)]
		[ValidateLength(0, 500)]
		[string]$Keywords,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "v9"
		)]
		[ValidateLength(0, 28)]
		[string]$Safe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[int]$TimeoutSec

	)

	BEGIN {

	}#begin

	PROCESS {

		#Get Parameters to include in request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove modificationTime, SafeName
		$filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep modificationTime, SafeName
		$FilterString = $filterParameters | ConvertTo-FilterString

		switch ($PSCmdlet.ParameterSetName) {

			( { $PSItem -match "v10" } ) {

				switch ($PSBoundParameters) {

					( { $PSItem.ContainsKey("modificationTime") }) {
						#check required version
						Assert-VersionRequirement -RequiredVersion 11.4

					}

					( { $PSItem.ContainsKey("searchType") }) {
						#check required version
						Assert-VersionRequirement -RequiredVersion 11.2

					}

					default {
						#check minimum version
						Assert-VersionRequirement -RequiredVersion 10.4
					}

				}

				#assign new type name
				$typeName = "psPAS.CyberArk.Vault.Account.V10"

				#define base URL
				$URI = "$Script:BaseURI/api/Accounts"

			}

			"v9" {

				#assign type name
				$typeName = "psPAS.CyberArk.Vault.Account"

				#Create request URL
				$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts"

			}

			"v10ByID" {

				#define "by ID" URL
				$URI = "$URI/$id"

				break

			}

			( { $PSItem -ne "v10ByID" } ) {

				If ($null -ne $FilterString) {

					$boundParameters = $boundParameters + $FilterString

				}

				#Create Query String, escaped for inclusion in request URL
				$queryString = $boundParameters | ConvertTo-QueryString

				If ($null -ne $queryString) {

					#Build URL from base URL
					$URI = "$URI`?$queryString"

				}

				break

			}

		}

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession -TimeoutSec $TimeoutSec

		If ($null -ne $result) {

			switch ($PSCmdlet.ParameterSetName) {

				"v10ByID" {

					#return expected single result
					$return = $result

					break

				}

				"v9" {

					$count = $($result.count)

					switch ($count) {

						{ $count -gt 1 } {

							#Alert that web service only displays information on first result
							Write-Warning "$count matching accounts found. Only the first result will be returned"

						}

						{ $count -gt 0 } {

							#Get account details from search result
							$account = ($result | Select-Object accounts).accounts

							#Get account properties from found account
							$properties = ($account | Select-Object -ExpandProperty properties)

							If ($null -ne $account.InternalProperties) {

								#Get internal properties from found account
								$InternalProperties = ($account | Select-Object -ExpandProperty InternalProperties)

								$InternalProps = New-Object -TypeName PSObject

								#For every account property
								For ($int = 0; $int -lt $InternalProperties.length; $int++) {

									$InternalProps |

									#Add each property name and value as object property of $InternalProps
									Add-ObjectDetail -PropertyToAdd @{$InternalProperties[$int].key = $InternalProperties[$int].value } -Passthru $false

								}

							}

							#Create output object
							$return = New-object -TypeName PSObject -Property @{

								#Internal Unique ID of Account
								"AccountID"          = $($account | Select-Object -ExpandProperty AccountID)

								#InternalProperties object
								"InternalProperties" = $InternalProps

							}

							#For every account property
							For ($int = 0; $int -lt $properties.length; $int++) {

								#Add each property name and value to results
								$return | Add-ObjectDetail -PropertyToAdd @{$properties[$int].key = $properties[$int].value } -Passthru $false

							}

						}

						default { break }

					}

					break

				}

				default {

					#return list
					$return = $Result | Get-NextLink -TimeoutSec $TimeoutSec

					break

				}

			}

			if ($return) {

				#Return Results
				$return | Add-ObjectDetail -typename $typeName

			}

		}

	}#process

	END { }#end

}