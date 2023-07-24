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
		[ValidateSet('Regular', 'Recently', 'New', 'Link', 'Deleted', 'PolicyFailures',
			'AccessedByUsers', 'ModifiedByUsers', 'ModifiedByCPM', 'DisabledPasswordByUser',
			'DisabledPasswordByCPM', 'ScheduledForChange', 'ScheduledForVerify', 'ScheduledForReconcile',
			'SuccessfullyReconciled', 'FailedChange', 'FailedVerify', 'FailedReconcile', 'LockedOrNew',
			'Locked', 'Favorites')]
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
		[string]$ConnectionComponent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
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
		[ValidateSet('Yes', 'No')]
		[string]$AllowMappingLocalDrives,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
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
		[ValidateSet('Yes', 'No')]
		[string]$AllowConnectToConsole,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
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
		[ValidateSet('Yes', 'No')]
		[string]$RedirectSmartCards,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
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
		[string]$PSMRemoteMachine,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
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
		[string]$LogonDomain,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'ConnectionParams'
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
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$Script:BaseURI/API/MyRequests"

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		switch ($PSCmdlet.ParameterSetName) {

			'BulkSearch' {

				$FilterParams = @{
					'SearchParam' = $boundParameters | Get-PASParameter -ParametersToKeep Search
				}
			}


			'BulkFilter' {

				$FilterParams = @{
					'AccountsFilters' = $boundParameters | Get-PASParameter -ParametersToKeep SavedFilter
				}
			}

			{ $PSItem -match 'BulkSearch|BulkFilter' } {

				Assert-VersionRequirement -RequiredVersion 13.2

				$Item = $boundParameters | Get-PASParameter -ParametersToRemove Search, SavedFilter, ExcludedEntities

				$Request = @{
					'BulkFilter' = @{
						'CommonEntityProperties' = @{
							'Operation' = 'Add'
							'Item'      = New-PASRequestObject @Item
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

			}

		}

		#Create body of request
		$body = $Request | ConvertTo-Json -Depth 6

		if ($PSCmdlet.ShouldProcess($AccountId, 'Create Request for Account Access')) {

			#send request to PAS web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

			If ($null -ne $result) {

				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request

			}

		}

	}#process

	END { }#end

}