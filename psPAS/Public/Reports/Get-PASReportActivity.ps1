# .ExternalHelp psPAS-help.xml
function Get-PASReportActivity {
    [CmdletBinding()]
    param(

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('ActivitiesReport', 'ActiveNonActiveSafesReport')]
        [string]$Type

    )

    begin {

        Assert-VersionRequirement -RequiredVersion 15.0

    }

    process {

        #Create URL for Request
        $BaseURI = "$($psPASSession.BaseURI)/API/ReportParams/Activities"

        #Get Parameters to include in request
        $boundParameters = $PSBoundParameters | Get-PASParameter

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

            #Return result
            $result.activityGroups | Add-ObjectDetail -TypeName psPAS.CyberArk.Vault.Report.ActivityGroup

        }

    }

    end {}

}
