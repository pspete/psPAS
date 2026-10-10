# .ExternalHelp psPAS-help.xml
function Get-PASAccountSearchProperty {
    [CmdletBinding()]
    param( )

    begin {

        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.4

    }

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/Accounts/AdvancedSearchProperties"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $Result) {

            #Process and return structured result
            $Result.advancedSearchProperties.PSObject.Properties | ForEach-Object {
                [PSCustomObject]@{
                    PropertyName              = $_.Name
                    ValidValues               = $_.Value.validValues -join ', '
                    SupportedOperators        = $_.Value.supportedOperators -join ', '
                    SupportedLogicalOperators = $_.Value.supportedLogicalOperators -join ', '
                }
            }

        }

    }

    end {}

}