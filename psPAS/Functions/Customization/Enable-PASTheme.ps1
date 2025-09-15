# .ExternalHelp psPAS-help.xml
function Enable-PASTheme {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string[]]$ThemesNames

    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.4

    }#begin

    process {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/ActiveThemes/"

        #Request body
        $Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($ThemesNames, 'Setting UI Theme')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

        }

    }#process

    end { }#end
}