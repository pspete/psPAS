# .ExternalHelp psPAS-help.xml
function Get-PASReportSetting {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('ActivitiesReport', 'ActiveNonActiveSafesReport')]
        [string]$Type
    )

    begin {

        Assert-VersionRequirement -RequiredVersion 15.0

    }#begin

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/reportParams/$Type/settings"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            #Return Results
            $result.defaultFilterValues | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Report.Setting

        }

    }#process

    end { }#end

}
