# .ExternalHelp psPAS-help.xml
Function Set-PASTheme {
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
        $URI = "$($psPASSession.BaseURI)/API/ActiveThemes/"

        #Request body
		$Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($ThemeName, 'Setting UI Theme')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		}

    }#process

    END { }#end
}