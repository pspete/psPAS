# .ExternalHelp psPAS-help.xml
function Get-PASUserTypeInfo {
    [CmdletBinding()]
    param(	)

    BEGIN {
        Assert-VersionRequirement -RequiredVersion 13.2
    }#begin

    PROCESS {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/UserTypes/"

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $result) {

            #Return Results
            $result.UserTypes | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User.Type

        }

    }#process

    END { }#end

}