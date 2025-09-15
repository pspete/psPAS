# .ExternalHelp psPAS-help.xml
function Clear-PASDiscoveredLocalAccount {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    begin {

        Assert-VersionRequirement -PrivilegeCloud

    }#begin

    process {

        $URI = "$($psPASSession.ApiURI)/api/discovered-accounts/clear"

        if ($PSCmdlet.ShouldProcess('Discovered Local Account List', 'Delete')) {

            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end
}