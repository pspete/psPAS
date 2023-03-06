# .ExternalHelp psPAS-help.xml
Function Get-PASPTAGlobalCatalog {
    [CmdletBinding()]
    param(	)

    BEGIN {
        Assert-VersionRequirement -RequiredVersion 13.0
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$Script:BaseURI/API/pta/API/Administration/GCConnectivity"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

        If ($null -ne $result) {

            #Return Results
            $result

        }

    }#process

    END { }#end

}