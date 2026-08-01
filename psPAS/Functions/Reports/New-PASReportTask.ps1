# .ExternalHelp psPAS-help.xml
function New-PASReportTask {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$version,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyString()]
		[string]$type,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('InventoryReports.InventoryReportUI', 'CyberArk.Reports.ApplicationReports.ApplicationReportUI', 'InventoryReports.ComplianceReportUI', 'CyberArk.Reports.EntitlementReport.EntitlementReportUI',
			'CyberArk.Reports.ActivitiesReport.ActivitiesReportUI', 'CyberArk.Reports.LicenseCapacityReport.LicenseCapacityReportUI', 'CyberArk.Reports.UsersReport.UsersListReportUI', 'CyberArk.Reports.ActiveNonActiveSafesReport.ActiveNonActiveSafesReportUI',
			'CyberArk.Reports.OwnersListReport.OwnersListReportUI')]
		[string]$subType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$keepTaskDefinition,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyString()]
		[datetime]$startTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyString()]
		[string]$recurrenceType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyString()]
		[string]$recurrenceValue,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyString()]
		[string]$daysOfWeek,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyString()]
		[string]$weekNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[Subscriber[]]$Subscribers, #!<Subscriber> Class Examples need testing/documenting

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyString()]
		[boolean]$notifyOnFailure,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[TaskFilter[]]$Filters
	)

	begin {

		Assert-VersionRequirement -RequiredVersion 14.6
		#array for parameter names which appear in the top-tier of the JSON object
		$keysToKeep = [Collections.Generic.List[String]]@(
			'version', 'type', 'subType', 'name', 'keepTaskDefinition', 'Subscribers', 'notifyOnFailure', 'Filters'
		)
		$scheduleParams = [Collections.Generic.List[String]]@(
			'startTime', 'recurrenceType', 'recurrenceValue', 'daysOfWeek', 'weekNumber'
		)

	}

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/Tasks"

		#Get Parameters for request body
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $keysToKeep

		#Determine which parameters belong to the schedule section
		switch ($PSBoundParameters.keys) {

			{ $scheduleParams -contains $PSItem } {

				#Current parameter relates to schedule section of report object
				if (-not($boundParameters.ContainsKey('schedule'))) {
					#create the schedule key
					$boundParameters.Add('schedule', @{})
				}

				if (($PSItem -ne 'startTime') -and (-not($boundParameters['schedule'].ContainsKey('recurrence')))) {
					#create the recurrence key
					$boundParameters['schedule'].Add('recurrence', @{})
				}

			}

			'startTime' {

				#Transform startTime
				$boundParameters['schedule']['startTime'] = $PSBoundParameters['startTime'].ToString('yyyy-MM-ddTHH:mm:ss.fffffffZ')
				continue

			}

			'recurrenceType' {

				#Transform recurrenceType
				$boundParameters['schedule']['recurrence']['type'] = $PSBoundParameters['recurrenceType']
				continue

			}

			'recurrenceValue' {

				#Transform recurrenceValue
				$boundParameters['schedule']['recurrence']['recurrenceValue'] = $PSBoundParameters['recurrenceValue']
				continue

			}

			'daysOfWeek' {

				#Transform daysOfWeek
				$boundParameters['schedule']['recurrence']['daysOfWeek'] = $PSBoundParameters['daysOfWeek'] -split ',' | ForEach-Object { [int]$_ }
				continue

			}

			'weekNumber' {

				#Transform weekNumber
				$boundParameters['schedule']['recurrence']['weekNumber'] = $PSBoundParameters['weekNumber']
				continue

			}

		}

		if ($PSBoundParameters.ContainsKey('Filters')) {

			#Filters parameter requires a later version than the base endpoint
			Assert-VersionRequirement -RequiredVersion 15.0

			#Filter names accepted vary by subType; warn (do not block) on names not documented for it,
			#since CyberArk may support filters here which are not yet reflected in this reference list
			$KnownFilterNames = Get-PASReportFilterName -SubType $subType

			foreach ($FilterItem in $Filters) {

				if ($KnownFilterNames -notcontains $FilterItem.name) {

					Write-Warning "Filter name '$($FilterItem.name)' is not documented as a valid filter for subType '$subType'. It will still be sent to the API."

				}

			}

		}

		$Body = $boundParameters | ConvertTo-Json -Depth 4

		if ($PSCmdlet.ShouldProcess($name, 'Create New Report Task')) {
			#Send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body
		}

		if ($null -ne $Result) {

			#Return result
			$Result

		}

	}

	end {}

}