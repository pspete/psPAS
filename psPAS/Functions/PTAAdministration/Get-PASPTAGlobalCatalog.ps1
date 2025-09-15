# .ExternalHelp psPAS-help.xml
function Get-PASPTAGlobalCatalog {
    [CmdletBinding()]
    param(	)

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 13.0
    }#begin

    process {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/pta/API/Administration/GCConnectivity"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            #Return Results
            $result

        }

    }#process

    end { }#end

}