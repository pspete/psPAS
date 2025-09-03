# .ExternalHelp psPAS-help.xml
Function Get-PASTheme {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'FindAll', Justification = 'False Positive')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'Active', Justification = 'False Positive')]
    [CmdletBinding(DefaultParameterSetName = 'byAll')]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'ByName'
        )]
        [string]$ThemeName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'ByActive'
        )]
        [switch]$Active,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'byAll'
		)]
		[switch]$FindAll
    )

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.4

    }#begin

    PROCESS {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/"

        switch ($PSCmdlet.ParameterSetName) {

			'ByName' {
				$URI = "$URI/Themes/$ThemeName/"
                break
			}

            'ByActive'{
                $URI = "$URI/ActiveThemes/"
                break
            }

            default {
                $URI = "$URI/Themes/"
            }

        }

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if($null -ne $result) {

            switch ($PSCmdlet.ParameterSetName) {

                'byAll' {
                    $return = $result | Select-Object -ExpandProperty CustomThemes

                    break
                }

                default {
                    $return = $result

                    break
                }

            }

            $return

        }

    }#process

    END { }#end
}