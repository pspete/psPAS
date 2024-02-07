# .ExternalHelp psPAS-help.xml
function Enable-PASUser {

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [int]$id
    )

    BEGIN {

        Assert-VersionRequirement -RequiredVersion 12.6

    }#begin

    PROCESS {

        $URI = "$($psPASSession.BaseURI)/API/Users/$id/enable/"

        if ($PSCmdlet.ShouldProcess($id, 'Enable User')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method POST

        }

    }#process

    END { }#end

}