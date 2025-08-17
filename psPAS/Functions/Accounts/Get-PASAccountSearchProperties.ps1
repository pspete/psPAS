# .ExternalHelp psPAS-help.xml
Function Get-PASAccountSearchProperties {
    [CmdletBinding()]
    param( )

    Begin {

        Assert-VersionRequirement -RequiredVersion 14.4

    }

    Process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/Accounts/AdvancedSearchProperties"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $Result) {

            #Return result
            $Result

        }

    }

    End {}

}