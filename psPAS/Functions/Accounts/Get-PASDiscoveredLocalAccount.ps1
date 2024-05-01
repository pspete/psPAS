# .ExternalHelp psPAS-help.xml
Function Get-PASDiscoveredLocalAccount {
    [CmdletBinding(DefaultParameterSetName = 'byQuery')]
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
            ParameterSetName = 'byQuery'
        )]
        [string]$search,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [boolean]$searchOnAllFields,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [string]$type,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [string]$subtype,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [boolean]$isPrivileged,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [string]$lastDiscoveryRulesStatus,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [boolean]$extendedDetails,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [string]$sort,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'byQuery'
        )]
        [int]$limit

    )

    Begin {

        Assert-VersionRequirement -PrivilegeCloud

        #Parameter to include as filter value in url
        $Parameters = [Collections.Generic.List[String]]@('type', 'subtype', 'isPrivileged', 'lastDiscoveryRulesStatus')

    }

    Process {

        #Create URL for Request
        $URI = "$($psPASSession.ApiURI)/api/discovered-accounts"

        switch ($PSCmdlet.ParameterSetName) {

            'byID' {

                $URI = "$URI/$id"

                break

            }

            'byQuery' {

                #Get Parameters to include in request
                $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove $Parameters
                $filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters
                $FilterString = $filterParameters | ConvertTo-FilterString

                If ($null -ne $FilterString) {

                    $boundParameters = $boundParameters + $FilterString

                }

                #Create Query String, escaped for inclusion in request URL
                $queryString = $boundParameters | ConvertTo-QueryString

                If ($null -ne $queryString) {

                    #Build URL from base URL
                    $URI = "$URI`?$queryString"

                }

                break

            }

        }

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $Result) {

            If ($PSCmdlet.ParameterSetName -eq 'byQuery') {

                #Process nextlink if querying
                $Result = $Result | Get-NextLink -BaseURI $psPASSession.ApiURI

            }

            #Return result
            $Result

        }

    }

    End {}

}