# .ExternalHelp psPAS-help.xml
function Get-PASUserPreference {
    [CmdletBinding()]
    param( )

    begin {

        Assert-VersionRequirement -RequiredVersion 15.2

    }#begin

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/UserPreferences"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            #Return Results
            $result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User.Preference

        }

    }#process

    end { }#end

}
