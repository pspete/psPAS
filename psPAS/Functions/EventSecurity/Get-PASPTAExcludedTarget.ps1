# .ExternalHelp psPAS-help.xml
Function Get-PASPTAExcludedTarget {
    [CmdletBinding()]
    param( )

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.0
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/pta/API/administration"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $result) {

            #Return Results
            $result | Where-Object { ($PSItem.propertykey -eq 'CidrExclusionList') -and ($PSItem.categorykey -eq 'MonitoredTargets') } |
                Select-Object -ExpandProperty 'ActualValue' |
                Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.MonitoredTarget

        }

    }#process

    END { }#end

}