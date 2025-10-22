# .ExternalHelp psPAS-help.xml
function Get-PASDiscoveryScanDefinition {
    [CmdletBinding()]
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
            'creationTime - asc', 'creationTime - desc', 'updateTime - asc',
            'updateTime - desc', 'name - asc', 'name - desc', 'type - asc',
            'type - desc', 'recurrenceType - asc', 'recurrenceType - desc',
            'lastInstanceStatus - asc', 'lastInstanceStatus - desc',
            'lastInstanceCreationTime - asc', 'lastInstanceCreationTime - desc'
        )]
        [string]$sort,

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
        [bool]$extendedDetails

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

                #Get Parameters to include in request
                $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove $Parameters
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