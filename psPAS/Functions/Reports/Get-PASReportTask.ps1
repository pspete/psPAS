# .ExternalHelp psPAS-help.xml
function Get-PASReportTask {
    [CmdletBinding(DefaultParameterSetName = 'byQuery')]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byID'
        )]
        [string]$id,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [string]$search,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [string]$subType,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [string]$name,

        [parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $false,
            ParameterSetName = 'byQuery'
        )]
        [ValidateSet('AND', 'OR')]
        [string]$FilterLogicalOperator = 'AND',

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [int]$limit

    )

    begin {

        Assert-VersionRequirement -RequiredVersion 14.6

        #Parameter names which are used to build the structured filter expression, not sent as-is
        #Only these fields are accepted by the API's filter parameter, and only with the EQ operator
        $Parameters = [Collections.Generic.List[String]]@(
            'subType', 'name'
        )

    }

    process {

        if ($PSCmdlet.ParameterSetName -eq 'byID') {

            #Create URL for Request
            $URI = "$($psPASSession.BaseURI)/API/Tasks/$($id | Get-EscapedString)"

            #Send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method GET

            if ($null -ne $result) {

                #Return result
                $result | Add-ObjectDetail -TypeName psPAS.CyberArk.Vault.Task

            }

        } else {

            if ($PSBoundParameters.ContainsKey('search') -or
                ($Parameters | Where-Object { $PSBoundParameters.ContainsKey($PSItem) })) {

                #search/filter query parameters require a later version than the base endpoint
                Assert-VersionRequirement -RequiredVersion 15.0

            }

            #Create URL for Request
            $BaseURI = "$($psPASSession.BaseURI)/API/Tasks"

            #Get Parameters to include in request
            $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove ($Parameters + @('FilterLogicalOperator'))

            #Get parameters to build the structured filter expression from
            $filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters

            $FilterString = $filterParameters | ConvertTo-StructuredFilterString -LogicalOperator $FilterLogicalOperator

            if ($null -ne $FilterString) {

                $boundParameters = $boundParameters + $FilterString

            }

            #Create Query String, escaped for inclusion in request URL
            $queryString = $boundParameters | ConvertTo-QueryString

            $URI = $BaseURI

            if ($null -ne $queryString) {

                #Build URL from base URL
                $URI = "$URI`?$queryString"

            }

            #Send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method GET

            if ($null -ne $result) {

                #API only provides a totalCount value; page via Get-NextLink's offset support
                $Tasks = $result | Get-NextLink -RequestUri $URI

                if ($null -ne $Tasks) {

                    #Return result
                    $Tasks | Add-ObjectDetail -TypeName psPAS.CyberArk.Vault.Task

                }

            }

        }

    }

    end {}

}
