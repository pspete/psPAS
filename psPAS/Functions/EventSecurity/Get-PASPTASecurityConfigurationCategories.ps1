# .ExternalHelp psPAS-help.xml
Function Get-PASPTASecurityConfigurationCategories {

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.2
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/pta/API/configuration/categories"
        
        #send request to web service
        Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $result) {

            #Return Results
            $result

        }

    }#process

    END { }#end

}