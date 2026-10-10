# .ExternalHelp psPAS-help.xml
function Get-PASIPAllowList {
    [CmdletBinding()]
    param( )

    begin {
        Assert-VersionRequirement -PrivilegeCloud
    }

    process {

        #Create URL for request
        $URI = "$($psPASSession.ApiURI)/api/advanced-settings/ip-allowlist"

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            $result

        }

    }

    end {}

}