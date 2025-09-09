# .ExternalHelp psPAS-help.xml
Function Get-PASReport {
    [CmdletBinding()]
    param( )

    Begin {

        Assert-VersionRequirement -RequiredVersion 14.6

    }

    Process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/Reports"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $Result) {

            #Return result
            $Result | Select-Object -ExpandProperty reports
            #TODO: Add Report type definition for formatting

        }

    }

    End {}

}