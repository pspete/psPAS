# .ExternalHelp psPAS-help.xml
function Get-PASFavoriteAccount {
    [CmdletBinding()]
    param( )

    begin {

        Assert-VersionRequirement -RequiredVersion 15.2

    }#begin

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/FavoriteAccounts"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            #Return Results
            $result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account.Favorite

        }

    }#process

    end { }#end

}
