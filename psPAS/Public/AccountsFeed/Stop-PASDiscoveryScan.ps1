# .ExternalHelp psPAS-help.xml
function Stop-PASDiscoveryScan {
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
        $URI = "$($psPASSession.BaseURI)/api/DiscoveryScans/$($taskId | Get-EscapedString)/stop"
        
        if ($PSCmdlet.ShouldProcess($taskId, 'Stop Discovery Scan')) {

            Invoke-PASRestMethod -Method POST -Uri $URI

        }

    }#process

    end { }#end

}
