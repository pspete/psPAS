# .ExternalHelp psPAS-help.xml
function Get-PASReport {
    [CmdletBinding()]
    param(

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [int]$limit,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$search,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('CreatedAt')]
        [string]$sort,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('asc', 'desc')]
        [string]$sortDirection,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$createdBy,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$name,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$records,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$status,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$type,

        [parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $false
        )]
        [ValidateSet('AND', 'OR')]
        [string]$FilterLogicalOperator = 'AND'

    )

    begin {

        Assert-VersionRequirement -RequiredVersion 14.6

        #Parameter names which are used to build the structured filter expression, not sent as-is
        #Only these fields are accepted by the API's filter parameter, and only with the EQ operator
        $Parameters = [Collections.Generic.List[String]]@(
            'createdBy', 'name', 'records', 'status', 'type'
        )

    }

    process {

        if ($PSBoundParameters.ContainsKey('search') -or $PSBoundParameters.ContainsKey('sort') -or
            ($Parameters | Where-Object { $PSBoundParameters.ContainsKey($PSItem) })) {

            #search/filter/sort query parameters require a later version than the base endpoint
            Assert-VersionRequirement -RequiredVersion 15.0

        }

        #Create URL for Request
        $BaseURI = "$($psPASSession.BaseURI)/API/Reports"

        #Get Parameters to include in request
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove ($Parameters + @('sortDirection', 'FilterLogicalOperator'))

        #Get parameters to build the structured filter expression from
        $filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters

        $FilterString = $filterParameters | ConvertTo-StructuredFilterString -LogicalOperator $FilterLogicalOperator

        if ($null -ne $FilterString) {

            $boundParameters = $boundParameters + $FilterString

        }

        if ($PSBoundParameters.ContainsKey('sortDirection') -and $sortDirection -eq 'desc') {

            #Prefix the sort value with "-" to request descending order
            $boundParameters['sort'] = "-$($boundParameters['sort'])"

        }

        #Collects reports returned across all pages
        $Reports = [Collections.Generic.List[Object]]::New()

        $Offset = 0

        do {

            if ($Offset -gt 0) {

                #Page past the first request via the offset query parameter
                $requestParameters = $boundParameters + @{'offset' = $Offset }

            } else {

                $requestParameters = $boundParameters

            }

            #Create Query String, escaped for inclusion in request URL
            $queryString = $requestParameters | ConvertTo-QueryString

            $URI = $BaseURI

            if ($null -ne $queryString) {

                #Build URL from base URL
                $URI = "$URI`?$queryString"

            }

            #Send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method GET

            $PageReports = $null

            if ($null -ne $result) {

                $PageReports = $result.reports

            }

            if ($null -ne $PageReports) {

                $PageReports = [Object[]]$PageReports
                $null = $Reports.AddRange($PageReports)
                $Offset += $PageReports.Count

            }

        } while (($null -ne $PageReports) -and ($PageReports.Count -gt 0) -and ($Offset -lt $result.totalCount))

        if ($Reports.Count -gt 0) {

            #Return result
            $Reports | Add-ObjectDetail -TypeName psPAS.CyberArk.Vault.Report

        }

    }

    end {}

}
