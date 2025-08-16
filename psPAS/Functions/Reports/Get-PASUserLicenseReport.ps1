# .ExternalHelp psPAS-help.xml
Function Get-PASUserLicenseReport {
    [CmdletBinding()]
    param( )

    Begin {

        Assert-VersionRequirement -PrivilegeCloud

    }

    Process {

        #Create URL for Request
        $URI = "$($psPASSession.ApiURI)/API/licenses/pcloud/"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $Result) {

            #Return result
            $Result

        }

    }

    End {}

}