# .ExternalHelp psPAS-help.xml
function Remove-PASDiscoveredLocalAccount {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$id
    )

    begin {

        Assert-VersionRequirement -PrivilegeCloud

    }#begin

    process {

        $URI = "$($psPASSession.ApiURI)/api/discovered-accounts/$id"

        if ($PSCmdlet.ShouldProcess("Discovered Local Account: $id", 'Delete')) {

            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end
}