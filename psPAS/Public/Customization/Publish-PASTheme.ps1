# .ExternalHelp psPAS-help.xml
function Publish-PASTheme {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$ThemeName

    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.4

    }#begin

    process {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/Themes/$ThemeName/draft/"

        #Request body
        $Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($ThemeName, 'Setting UI Theme')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

        }

    }#process

    end { }#end
}