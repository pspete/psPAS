# .ExternalHelp psPAS-help.xml
function Remove-PASReportTask {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$id
    )

    begin {

        Assert-VersionRequirement -RequiredVersion 14.6

    }

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/Tasks/$($id | Get-EscapedString)"

        if ($PSCmdlet.ShouldProcess($id, 'Remove Report Task')) {

            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }

    end {}

}