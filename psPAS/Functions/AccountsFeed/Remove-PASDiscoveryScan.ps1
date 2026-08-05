# .ExternalHelp psPAS-help.xml
function Remove-PASDiscoveryScan {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('id')]
        [string]$taskId
    )

    begin {

        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 12.2

    }#begin

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/DiscoveryScans/$($taskId | Get-EscapedString)"

        if ($PSCmdlet.ShouldProcess($taskId, 'Remove Discovery Scan')) {

            Invoke-PASRestMethod -Method DELETE -Uri $URI

        }

    }#process

    end { }#end

}
