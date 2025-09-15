# .ExternalHelp psPAS-help.xml
function Get-PASReportSchedule {
    [CmdletBinding()]
    param( )

    begin {

        Assert-VersionRequirement -RequiredVersion 14.6

    }

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/Tasks"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $Result) {

            #Return result
            $Result | Select-Object -ExpandProperty tasks
            #TODO: Add Schedule/Tasks type definition for formatting

        }

    }

    end {}

}