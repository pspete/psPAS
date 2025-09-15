# .ExternalHelp psPAS-help.xml
function Remove-PASTheme {
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
        $URI = "$($psPASSession.BaseURI)/API/Themes/$($ThemeName | Get-EscapedString)"

        if ($PSCmdlet.ShouldProcess($ThemeName, 'Removing UI Theme')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end
}