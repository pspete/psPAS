# .ExternalHelp psPAS-help.xml
function Get-PASRemediationRuleSet {
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
            ParameterSetName = 'GetAllRemediationRuleSets'
        )]
        [string]$search,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'GetAllRemediationRuleSets'
        )]
        [ValidateSet(
            'id - asc', 'id - desc', 'name - asc', 'name - desc',
            'status - asc', 'status - desc', 'rulesCount - asc',
            'rulesCount - desc', 'actionsPerformed - asc', 'actionsPerformed - desc',
            'lastModificationTime - asc', 'lastModificationTime - desc'
        )]
        [string]$sort,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'GetAllRemediationRuleSets'
        )]
        [ValidateRange(1, 1000)]
        [int]$limit,

        [parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $false
        )]
        [int]$TimeoutSec

    )

    begin {

        Assert-VersionRequirement -PrivilegeCloud

    }

    process {

        #Create URL for Request
        $URI = "$($psPASSession.ApiURI)/api/discovery-rule-sets"

        switch ($PSCmdlet.ParameterSetName) {

            'byID' {

                $URI = "$URI/$id"

                break

            }

            'GetAllRemediationRuleSets' {

                #Get Parameters to include in request
                $boundParameters = $PSBoundParameters | Get-PASParameter

                if ($PSBoundParameters.Keys -notcontains 'Limit') {
                    $Limit = 50   #default limit
                    $boundParameters.Add('Limit', $Limit) # Add to boundparameters for inclusion in query string
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

                'GetAllRemediationRuleSets' {

                    $Total = $result.Count

                    if ($Total -gt 0) {

                        #Set ruleset as output collection
                        $RuleSets = [Collections.Generic.List[Object]]::New(($result))

                        #Split Request URL into baseURI & any query string value
                        $URLString = $URI.Split('?')
                        $URI = $URLString[0]
                        $queryString = $URLString[1]

                        for ( $Offset = $Limit ; $Offset -lt $Total ; $Offset += $Limit ) {

                            #While more members to return, create nextLink query value
                            $nextLink = "limit=$Limit&OffSet=$Offset"

                            if ($null -ne $queryString) {

                                #If original request contained a queryString, concatenate with nextLink value.
                                $nextLink = "$queryString&$nextLink"

                            }


                            #Request nextLink. Add memberlist to output collection.
                            $Null = $RuleSets.AddRange((Invoke-PASRestMethod -Uri "$URI`?$nextLink" -Method GET -TimeoutSec $TimeoutSec))

                        }

                        $Output = $RuleSets



                    }

                    break

                }

            }

            $Output

        }

    }

    end {}

}