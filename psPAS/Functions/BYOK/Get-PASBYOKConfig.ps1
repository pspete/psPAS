# .ExternalHelp psPAS-help.xml
function Get-PASBYOKConfig {
    [CmdletBinding()]
    param( )

    begin {
        Assert-VersionRequirement -PrivilegeCloud
    }

    process {

        #Create URL for request
        $URI = "$($psPASSession.ApiURI)/api/byok"

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            $result

        }

    }

    end {}

}