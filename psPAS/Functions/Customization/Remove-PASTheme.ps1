# .ExternalHelp psPAS-help.xml
Function Remove-PASTheme {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$ThemeName

    )

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.4

    }#begin

    PROCESS {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/Themes/$($ThemeName | Get-EscapedString)"

        if ($PSCmdlet.ShouldProcess($ThemeName, 'Removing UI Theme')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

    }#process

    END { }#end
}