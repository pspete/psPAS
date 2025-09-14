# .ExternalHelp psPAS-help.xml
function Clear-PASPrivateSSHKey {
    [CmdletBinding()]
    param( )

    begin {

        Assert-VersionRequirement -RequiredVersion 12.1

    }#begin

    process {

        $URI = "$($psPASSession.BaseURI)/api/Users/Secret/SSHKeys/ClearCache"

        #send request to webservice
        Invoke-PASRestMethod -Uri $URI -Method DELETE

    }#process

    end { }#end
}