# .ExternalHelp psPAS-help.xml
function Get-PASDiscoveryScanDefinition {
    [CmdletBinding(DefaultParameterSetName = 'GetAllScanDefinitions')]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byID'
        )]
        [string]$id,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'GetAllScanDefinitions'
        )]
        [string]$search,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'GetAllScanDefinitions'
        )]
        [ValidateSet(
            'creationTime', 'updateTime', 'name', 'type', 'recurrenceType',
            'lastInstanceStatus', 'lastInstanceCreationTime'
        )]
        [string]$sort,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'GetAllScanDefinitions'
        )]
        [ValidateSet('asc', 'desc')]
        [string]$sortDirection,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'GetAllScanDefinitions'
        )]
        [string]$type,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'GetAllScanDefinitions'
        )]
        [string]$recurrenceType,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'GetAllScanDefinitions'
        )]
        [string]$lastInstanceStatus,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'GetAllScanDefinitions'
        )]
        [bool]$extendedDetails,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'GetAllScanDefinitions'
        )]
        [ValidateSet(
            'ACTIVE', 'INACTIVE'
        )]
        [string]$State

    )

    begin {

        Assert-VersionRequirement -PrivilegeCloud

        #Parameter to include as filter value in url
        $Parameters = [Collections.Generic.List[String]]@('lastInstanceStatus', 'recurrenceType', 'type')

    }

    process {

        #Create URL for Request
        $URI = "$($psPASSession.ApiURI)/api/scan-definitions"

        switch ($PSCmdlet.ParameterSetName) {

            'byID' {

                $URI = "$URI/$id"

                break

            }

            'GetAllScanDefinitions' {

                #Sort properties which are only valid when extendedDetails is requested
                $ExtendedOnlySortProperties = @('lastInstanceStatus', 'lastInstanceCreationTime')

                if ($PSBoundParameters.ContainsKey('sort') -and ($ExtendedOnlySortProperties -contains $sort) -and ($extendedDetails -ne $true)) {

                    throw "Sort property '$sort' is only valid when -extendedDetails is set to `$true"

                }

                if ($PSBoundParameters.ContainsKey('sort') -or $PSBoundParameters.ContainsKey('sortDirection')) {

                    if ($PSBoundParameters.ContainsKey('sort')) {
                        $sortProperty = $sort
                    } else {
                        $sortProperty = 'creationTime'   #default sort property
                    }

                    if ($PSBoundParameters.ContainsKey('sortDirection')) {
                        $direction = $sortDirection
                    } else {
                        $direction = 'asc'   #default sort direction
                    }

                    #Append sort direction to sort property for correct query string creation
                    $PSBoundParameters['sort'] = "$sortProperty - $direction"

                }

                #Get Parameters to include in request
                $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove ($Parameters + 'sortDirection')
                $filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters
                $FilterString = $filterParameters | ConvertTo-FilterString

                # Append filter string if present
                if ($null -ne $FilterString) {

                    $boundParameters = $boundParameters + $FilterString

                }

                #Create Query String, escaped for inclusion in request URL
                $queryString = $boundParameters | ConvertTo-QueryString

                if ($null -ne $queryString) {

                    #Build URL from base URL
                    $URI = "$URI`?$queryString"

                }

            }

        }

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $Result) {

            switch ( $PSCmdlet.ParameterSetName ) {

                'byID' {

                    #Single ruleset returned
                    $Output = $result

                    break

                }

                'GetAllScanDefinitions' {

                    #Multiple rulesets returned
                    $Output = $result.Items

                    break
                }

            }

            $Output

        }

    }

    end {}

}