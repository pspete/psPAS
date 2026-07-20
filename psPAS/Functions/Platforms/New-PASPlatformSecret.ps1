# .ExternalHelp psPAS-help.xml
function New-PASPlatformSecret {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('id')]
        [string]$Platformid
    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 15.2
    }#begin

    process {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/Platforms/$Platformid/GenerateSecret/"

        if ($PSCmdlet.ShouldProcess($Platformid, 'Generate Platform Secret')) {

            Invoke-PASRestMethod -Uri $URI -Method POST

        }

    }#process

    end { }#end

}
