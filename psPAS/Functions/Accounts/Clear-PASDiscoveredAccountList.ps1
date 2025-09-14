# .ExternalHelp psPAS-help.xml
function Clear-PASDiscoveredAccountList {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    begin {

        Assert-VersionRequirement -RequiredVersion 12.1

    }#begin

    process {

        $URI = "$($psPASSession.BaseURI)/api/DiscoveredAccounts"

        if ($PSCmdlet.ShouldProcess('Discovered/Pending Account List', 'Delete')) {

            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end
}