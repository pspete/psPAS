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
        [string]$filter

    )

    begin {

        Assert-VersionRequirement -RequiredVersion 14.6

    }

    process {

        if ($PSBoundParameters.ContainsKey('search') -or $PSBoundParameters.ContainsKey('filter')) {

            #search/filter query parameters require a later version than the base endpoint
            Assert-VersionRequirement -RequiredVersion 15.0

        }

        #Create URL for Request
        $BaseURI = "$($psPASSession.BaseURI)/API/Reports"

        #Get Parameters to include in request
        $boundParameters = $PSBoundParameters | Get-PASParameter

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
            $Reports
            #TODO: Add Report type definition for formatting

        }

    }

    end {}

}
