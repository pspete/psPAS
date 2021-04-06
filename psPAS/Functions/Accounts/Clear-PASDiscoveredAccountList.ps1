# .ExternalHelp psPAS-help.xml
function Clear-PASDiscoveredAccountList {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    BEGIN {

        Assert-VersionRequirement -RequiredVersion 12.1

    }#begin

    PROCESS {

        $URI = "$Script:BaseURI/api/DiscoveredAccounts"

        if ($PSCmdlet.ShouldProcess('Discovered/Pending Account List', 'Delete')) {

            Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

        }

    }#process

    END { }#end
}