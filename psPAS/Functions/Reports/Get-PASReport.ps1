# .ExternalHelp psPAS-help.xml
function Get-PASReport {
    [CmdletBinding()]
    param( )

    begin {

        Assert-VersionRequirement -RequiredVersion 14.6

    }

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/Reports"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $Result) {

            #Return result
            $Result | Select-Object -ExpandProperty reports
            #TODO: Add Report type definition for formatting

        }

    }

    end {}

}