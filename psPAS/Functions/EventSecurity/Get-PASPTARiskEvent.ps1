# .ExternalHelp psPAS-help.xml
Function Get-PASPTARiskEvent {
    [CmdletBinding(DefaultParameterSetName = '13.2')]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '14.0'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '13.2'
        )]
        [ValidateSet('RISK_UNCONSTRAINED_DELEGATION', 'RISK_RISKY_SPN')]
        [string]$type,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '14.0'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '13.2'
        )]
        [ValidateSet('OPEN', 'CLOSED')]
        [string]$status,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '14.0'
        )]
        [datetime]$FromTime,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '14.0'
        )]
        [datetime]$ToTime,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '14.0'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '13.2'
        )]
        [ValidateSet('detectionTime', 'score')]
        [string]$sort,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '14.0'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '13.2'
        )]
        [ValidateRange(1, 1000)]
        [int]$size

    )

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName
        $Parameters = [Collections.Generic.List[Object]]::New(@('type', 'status'))
        $TimeParameters = [Collections.Generic.List[Object]]::New(@('FromTime', 'ToTime'))
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/pta/API/Risks/RisksEvents/"

        $filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove @($Parameters + $TimeParameters)

        switch ($PSCmdlet.ParameterSetName) {

            '14.0' {

                switch ($PSBoundParameters) {

                    { $PSItem.ContainsKey('FromTime') } {

                        $FromTimeValue = """$($FromTime | ConvertTo-UnixTime -Milliseconds)"""
                        $Operator = 'gte'

                    }

                    { $PSItem.ContainsKey('ToTime') } {

                        $ToTimeValue = """$($ToTime | ConvertTo-UnixTime -Milliseconds)"""
                        $Operator = 'lte'

                    }
                    { $PSItem.ContainsKey('FromTime') -and $PSItem.ContainsKey('ToTime') } {

                        $TimeValue = "BETWEEN $FromTimeValue TO $ToTimeValue"
                        continue

                    }
                    { $PSItem.ContainsKey('FromTime') -or $PSItem.ContainsKey('ToTime') } {

                        $TimeValue = "$Operator ${FromTimeValue}${ToTimeValue}"
                        continue

                    }

                }

                $filterParameters['detectionTime'] = $TimeValue

            }

        }

        $FilterString = $filterParameters | ConvertTo-FilterString -QuoteValue

        If ($null -ne $FilterString) {

            $boundParameters = $boundParameters + $FilterString

        }

        #Create Query String, escaped for inclusion in request URL
        $queryString = $boundParameters | ConvertTo-QueryString

        if ($null -ne $queryString) {

            #Build URL from base URL
            $URI = "$URI`?$queryString"

        }

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        $Total = $result.totalEntities

        If ($Total -gt 0) {

            #Set events as output collection
            $Events = [Collections.Generic.List[Object]]::New(@($result.entities))

            #Split Request URL into baseURI & any query string value
            $URLString = $URI.Split('?')
            $URI = $URLString[0]
            $queryString = $URLString[1]

            $TotalPages = $result.totalpages

            For ( $Offset = 1 ; $Offset -lt $TotalPages ; $Offset++ ) {

                #While more risk events to return, create nextLink query value
                $nextLink = "page=$Offset"

                if ($null -ne $queryString) {

                    #If original request contained a queryString, concatenate with nextLink value.
                    $nextLink = "$queryString&$nextLink"

                }


                #Request nextLink. Add Risk Events to output collection.
                $Null = $Events.AddRange((Invoke-PASRestMethod -Uri "$URI`?$nextLink" -Method GET).entities)

            }

            $Output = $Events

        }

        If ($null -ne $Output) {

            #Return Results
            $Output | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Event.Risk

        }

    }#process

    END { }#end

}