# .ExternalHelp psPAS-help.xml
Function Reset-PASThemeImage {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    BEGIN {

        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.4

    }#begin

    PROCESS {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/ActiveThemes/"

        if ($PSCmdlet.ShouldProcess('Default Theme', 'Resetting UI Theme')) {

            #send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method DELETE

        }
    }#process

    END { }#end

}