# .ExternalHelp psPAS-help.xml
Function Get-PASIPAllowList {
    [CmdletBinding()]
    param( )

    Begin {
        Assert-VersionRequirement -PrivilegeCloud
    }

    Process {

        #Create URL for request
        $URI = "$($psPASSession.ApiURI)/api/advanced-settings/ip-allowlist"

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $result) {

            $result

        }

    }

    End {}

}