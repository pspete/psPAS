# .ExternalHelp psPAS-help.xml
function Get-PASUserLicenseReport {
    [CmdletBinding()]
    param( )

    begin {

        Assert-VersionRequirement -PrivilegeCloud

    }

    process {

        #Create URL for Request
        $URI = "$($psPASSession.ApiURI)/API/licenses/pcloud/"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $Result) {

            #Return result
            $Result

        }

    }

    end {}

}