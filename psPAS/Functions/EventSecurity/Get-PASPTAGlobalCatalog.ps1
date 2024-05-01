# .ExternalHelp psPAS-help.xml
Function Get-PASPTAGlobalCatalog {
    [CmdletBinding()]
    param(	)

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 13.0
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/pta/API/Administration/GCConnectivity"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $result) {

            #Return Results
            $result

        }

    }#process

    END { }#end

}