# .ExternalHelp psPAS-help.xml
Function Get-PASBYOKConfig {
    [CmdletBinding()]
    param( )

    Begin {
        Assert-VersionRequirement -PrivilegeCloud
    }

    Process {

        #Create URL for request
        $URI = "$($psPASSession.ApiURI)/api/byok"

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $result) {

            $result

        }

    }

    End {}

}