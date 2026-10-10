# .ExternalHelp psPAS-help.xml
function Get-PASPlatformSummary {
    [CmdletBinding()]
    param()

    begin {
        Assert-VersionRequirement -RequiredVersion 12.2
    }#begin

    process {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/Platforms/Targets/SystemTypes"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        #$result
        if ($null -ne $result) {

            #Return Results
            $result.SystemTypes

        }

    }#process

    end { }#end

}