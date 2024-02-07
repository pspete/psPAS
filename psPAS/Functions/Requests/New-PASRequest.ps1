# .ExternalHelp psPAS-help.xml
function New-PASRequest {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'ConnectionParams')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ManualParams'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkSearch'
		)]
		[string]$Search,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkFilter'
		)]
		[ValidateSet('Regular', 'Recently', 'Locked', 'Favorites')]
		[string]$SavedFilter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkFilter'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkSearch'
		)]
		[string[]]$ExcludedEntities,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ManualParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkFilter'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkSearch'
		)]
		[string]$Reason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ManualParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkFilter'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkSearch'
		)]
		[string]$TicketingSystemName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ManualParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkFilter'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkSearch'
		)]
		[string]$TicketID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ManualParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkFilter'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkSearch'
		)]
		[boolean]$MultipleAccessRequired,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ManualParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkFilter'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkSearch'
		)]
		[datetime]$FromDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ManualParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkFilter'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkSearch'
		)]
		[datetime]$ToDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ManualParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkFilter'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkSearch'
		)]
		[hashtable]$AdditionalInfo,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ManualParams'
		)]
		[boolean]$UseConnect,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ManualParams'
		)]
		[string]$ConnectionComponent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[ValidateSet('Yes', 'No')]
		[string]$AllowMappingLocalDrives,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[ValidateSet('Yes', 'No')]
		[string]$AllowConnectToConsole,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[ValidateSet('Yes', 'No')]
		[string]$RedirectSmartCards,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[string]$PSMRemoteMachine,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[string]$LogonDomain,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
		)]
		[ValidateSet('Yes', 'No')]
		[string]$AllowSelectHTML5,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ManualParams'
		)]
		[hashtable]$ConnectionParams,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BulkItems'
		)]
		[object[]]$BulkItems

	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.10
		$Target = $PSCmdlet.ParameterSetName
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/MyRequests"

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		switch ($PSCmdlet.ParameterSetName) {

			'BulkSearch' {

				#Filter Parameters for Bulk Search Request
				$FilterParams = @{
					'SearchParam' = $boundParameters | Get-PASParameter -ParametersToKeep Search
				}
			}


			'BulkFilter' {

				#Filter Parameters for Saved Filter Request
				$FilterParams = @{
					'AccountsFilters' = $boundParameters | Get-PASParameter -ParametersToKeep SavedFilter
				}
			}

			{ $PSItem -match 'BulkSearch|BulkFilter' } {

				Assert-VersionRequirement -RequiredVersion 13.2

				#request for bulk search/filter request
				$Item = $boundParameters | Get-PASParameter -ParametersToRemove Search, SavedFilter, ExcludedEntities

				#Format Request
				$Request = @{
					'BulkFilter' = [ordered]@{
						'CommonEntityProperties' = @{
							'Operation' = 'Add'
							'Item'      = New-PASRequestObject @Item | ConvertTo-BulkFilterItem
						}
						'ExcludedEntities'       = $ExcludedEntities
						'FilterParams'           = $FilterParams
					}
				}

				break

			}

			'BulkItems' {

				Assert-VersionRequirement -RequiredVersion 13.2

				#New Bulk Item Array
				$Items = [Collections.Generic.List[Object]]::New()

				$BulkItems | ForEach-Object {

					#Add Operation and Item details For each Bulk Item
					$Items.Add(
						@{
							'Operation' = 'Add'
							'Item'      = $PSItem
						}
					)
				}

				$Request = @{'BulkItems' = $Items }
				break

			}

			default {

				#create request object
				$Request = New-PASRequestObject @boundParameters
				$Target = $AccountId
			}

		}

		#Create body of request
		$body = $Request | ConvertTo-Json -Depth 3

		if ($PSCmdlet.ShouldProcess($Target, 'Request Account Access')) {

			#send request to PAS web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

			If ($null -ne $result) {
				switch ($PSCmdlet.ParameterSetName) {

					{ $PSItem -match '^Bulk' } {
						[pscustomobject]@{'Id' = $result } | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request.Bulk
						break
					}

					default {
						$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request
						break
					}
				}

			}

		}

	}#process

	END { }#end

}