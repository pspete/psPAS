# .ExternalHelp psPAS-help.xml
Function Get-PASAccountSearchProperty {
    [CmdletBinding()]
    param( )

    Begin {

        Assert-VersionRequirement -RequiredVersion 14.4

    }

    Process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/Accounts/AdvancedSearchProperties"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $Result) {

            #Process and return structured result
            $Result.advancedSearchProperties.PSObject.Properties | ForEach-Object {
                [PSCustomObject]@{
                    PropertyName = $_.Name
                    ValidValues = $_.Value.validValues -join ', '
                    SupportedOperators = $_.Value.supportedOperators -join ', '
                    SupportedLogicalOperators = $_.Value.supportedLogicalOperators -join ', '
                }
            }

        }

    }

    End {}

}