# .ExternalHelp psPAS-help.xml
function Get-PASPlatformSummary {
    [CmdletBinding()]
    param()

    BEGIN {
        Assert-VersionRequirement -RequiredVersion 12.2
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/Platforms/Targets/SystemTypes"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        #$result
        If ($null -ne $result) {

            #Return Results
            $result.SystemTypes

        }

    }#process

    END { }#end

}