# .ExternalHelp psPAS-help.xml
function Clear-PASDiscoveredLocalAccount {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    BEGIN {

        Assert-VersionRequirement -PrivilegeCloud

    }#begin

    PROCESS {

        $URI = "$($psPASSession.ApiURI)/api/discovered-accounts/clear"

        if ($PSCmdlet.ShouldProcess('Discovered Local Account List', 'Delete')) {

            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    END { }#end
}