# .ExternalHelp psPAS-help.xml
function Reset-PASTheme {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    begin {

        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.4

    }#begin

    process {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/ActiveThemes/"

        if ($PSCmdlet.ShouldProcess('Default Theme', 'Resetting UI Theme')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }
    }#process

    end { }#end

}