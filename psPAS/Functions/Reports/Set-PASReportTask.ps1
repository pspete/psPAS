# .ExternalHelp psPAS-help.xml
function Set-PASReportTask {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$id,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 256)]
        [string]$name,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$keepTaskDefinition,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$notifyOnFailure,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [AllowEmptyCollection()]
        [Subscriber[]]$Subscribers,

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
        [TaskFilter[]]$filters
    )

    begin {

        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.6

        $scheduleParams = [Collections.Generic.List[String]]@(
            'startTime', 'recurrenceType', 'recurrenceValue', 'daysOfWeek', 'weekNumber'
        )

        #Properties of the current task definition which cannot be sent in the PUT request body
        $readOnlyParams = [Collections.Generic.List[String]]@(
            'id', 'folder', 'createdAt', 'createdBy', 'lastModifiedAt', 'lastModifiedBy'
        )

    }#begin

    process {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/Tasks/$($id | Get-EscapedString)"

        #Get existing task definition
        $TaskObject = Get-PASReportTask -id $id

        if ($null -eq $TaskObject) {
            throw "Report task with id '$id' was not found."
        }

        #Get Parameters for request body
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove ($readOnlyParams + $scheduleParams)

        #Add current values for any property not being explicitly updated
        #* schedule is excluded as it is sent as a nested object, and is processed separately
        $TaskObject.PSObject.Properties | Where-Object {
            ($readOnlyParams -notcontains $PSItem.Name) -and ($PSItem.Name -ne 'schedule')
        } | ForEach-Object {

            if (-not($boundParameters.ContainsKey($PSItem.Name))) {
                $boundParameters[$PSItem.Name] = $PSItem.Value
            }

        }

        if ($null -ne $TaskObject.schedule) {

            #Copy the current schedule into hashtables so the nested values remain updatable
            $schedule = @{ recurrence = @{} }

            $TaskObject.schedule.PSObject.Properties | Where-Object { $PSItem.Name -ne 'recurrence' } | ForEach-Object {
                $schedule[$PSItem.Name] = $PSItem.Value
            }

            if ($null -ne $TaskObject.schedule.recurrence) {

                $TaskObject.schedule.recurrence.PSObject.Properties | ForEach-Object {
                    $schedule['recurrence'][$PSItem.Name] = $PSItem.Value
                }

            }

            $boundParameters['schedule'] = $schedule

        }

        #Nest any explicitly supplied schedule parameters as required by the API
        switch ($PSBoundParameters.Keys) {

            { $scheduleParams -contains $PSItem } {

                if (-not($boundParameters.ContainsKey('schedule'))) {
                    $boundParameters['schedule'] = @{ recurrence = @{} }
                }

                $schedule = $boundParameters['schedule']

            }

            'startTime' {
                $schedule['startTime'] = $startTime.ToString('yyyy-MM-ddTHH:mm:ss.fffffffZ')
                continue
            }

            'recurrenceType' {
                $schedule['recurrence']['type'] = $recurrenceType
                continue
            }

            'recurrenceValue' {
                $schedule['recurrence']['recurrenceValue'] = $recurrenceValue
                continue
            }

            'daysOfWeek' {
                $schedule['recurrence']['daysOfWeek'] = @($daysOfWeek -split ',' | ForEach-Object { [int]$PSItem })
                continue
            }

            'weekNumber' {
                $schedule['recurrence']['weekNumber'] = $weekNumber
                continue
            }

        }

        if ($PSBoundParameters.ContainsKey('filters')) {

            #filters parameter requires a later version than the base endpoint
            Assert-VersionRequirement -RequiredVersion 15.0

            #Filter names accepted vary by subType; warn (do not block) on names not documented for it,
            #since CyberArk may support filters here which are not yet reflected in this reference list
            $KnownFilterNames = Get-PASReportFilterName -SubType $TaskObject.subType

            foreach ($FilterItem in $filters) {

                if ($KnownFilterNames -notcontains $FilterItem.name) {

                    Write-Warning "Filter name '$($FilterItem.name)' is not documented as a valid filter for subType '$($TaskObject.subType)'. It will still be sent to the API."

                }

            }

        }

        #Create body of request
        $Body = $boundParameters | ConvertTo-Json -Depth 4

        if ($PSCmdlet.ShouldProcess($id, 'Update Report Task')) {

            #Send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body

            if ($null -ne $result) {

                $result | Add-ObjectDetail -TypeName psPAS.CyberArk.Vault.Task

            }

        }

    }#process

    end { }

}
