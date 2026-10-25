# .ExternalHelp psPAS-help.xml
function Get-PASLocation {
    [CmdletBinding()]
    param( )

    begin {

        Assert-VersionRequirement -RequiredVersion 15.2

    }#begin

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/Locations"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            #Return Results
            $result.locations | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Location

        }

    }#process

    end { }#end

}
