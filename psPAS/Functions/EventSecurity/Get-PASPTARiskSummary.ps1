# .ExternalHelp psPAS-help.xml
function Get-PASPTARiskSummary {
    [CmdletBinding()]
    param( )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 13.2
    }#begin

    process {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/pta/API/Risks/Summary/"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            #Return Results
            $result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Event.Risk.Summary

        }

    }#process

    end { }#end

}