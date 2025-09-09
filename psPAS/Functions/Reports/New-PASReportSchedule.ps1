# .ExternalHelp psPAS-help.xml
Function New-PASReportSchedule {
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
		[AllowEmptyString()]
		[string]$subType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyString()]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyString()]
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
		[boolean]$notifyOnFailure
    )

    Begin {

        Assert-VersionRequirement -RequiredVersion 14.6
        #array for parameter names which appear in the top-tier of the JSON object
		$keysToKeep = [Collections.Generic.List[String]]@(
			'version','type', 'subType', 'name', 'keepTaskDefinition', 'Subscribers', 'notifyOnFailure'
		)
        $scheduleParams = [Collections.Generic.List[String]]@(
			'startTime', 'recurrenceType', 'recurrenceValue', 'daysOfWeek', 'weekNumber'
		)

    }

    Process {

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

			}

            'startTime' {

				#Transform startTime
				$boundParameters['schedule']['startTime'] = $PSBoundParameters['startTime'].ToString("yyyy-MM-ddTHH:mm:ss.fffffffZ")
				Continue

			}

            'recurrenceType' {

				#Transform recurrenceType
				$boundParameters['schedule']['recurrence']['type'] = $PSBoundParameters['recurrenceType']
				Continue

			}

            'recurrenceValue' {

				#Transform recurrenceValue
				$boundParameters['schedule']['recurrence']['recurrenceValue'] = $PSBoundParameters['recurrenceValue']
				Continue

			}

            'daysOfWeek' {

				#Transform daysOfWeek
				$boundParameters['schedule']['recurrence']['daysOfWeek'] = $PSBoundParameters['daysOfWeek'] -split ',' | ForEach-Object { [int]$_ }
				Continue

			}

            'weekNumber' {

				#Transform weekNumber
				$boundParameters['schedule']['recurrence']['weekNumber'] = $PSBoundParameters['weekNumber']
				Continue

			}

        }

        $Body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($name, 'Create New Report Schedule')) {
			#Send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body
		}

        If ($null -ne $Result) {

            #Return result
            $Result

        }

    }

    End {}

}