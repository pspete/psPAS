# .ExternalHelp psPAS-help.xml
Function Get-PASReportSchedule {
    [CmdletBinding()]
    param( )

    Begin {

        Assert-VersionRequirement -RequiredVersion 14.6

    }

    Process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/Tasks"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $Result) {

            #Return result
            $Result

        }

    }

    End {}

}