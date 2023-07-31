# .ExternalHelp psPAS-help.xml
Function Get-PASPTARiskEvent {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('RISK_UNCONSTRAINED_DELEGATION', 'RISK_RISKY_SPN')]
        [string]$type,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('OPEN', 'CLOSED')]
        [string]$status,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('detectionTime', 'score')]
        [string]$sort,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [int]$page,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(1, 1000)]
        [int]$size

    )

    BEGIN {
        Assert-VersionRequirement -RequiredVersion 13.2
        $Parameters = [Collections.Generic.List[Object]]::New(@('type', 'status'))
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$Script:BaseURI/API/pta/API/Risks/RisksEvents/"

        $filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove $Parameters
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
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

        If ($null -ne $result) {

            #Return Results
            $result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Event.Risk

        }

    }#process

    END { }#end

}