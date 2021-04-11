# .ExternalHelp psPAS-help.xml
function Clear-PASPrivateSSHKey {
    [CmdletBinding()]
    param( )

    BEGIN {

        Assert-VersionRequirement -RequiredVersion 12.1

    }#begin

    PROCESS {

        $URI = "$Script:BaseURI/api/Users/Secret/SSHKeys/ClearCache"

        #send request to webservice
        Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

    }#process

    END { }#end
}