# .ExternalHelp psPAS-help.xml
function Get-PASPTAIncludedTarget {
    [CmdletBinding()]
    param( )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.0
    }#begin

    process {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/pta/API/administration"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            #Return Results
            $result | Where-Object { ($PSItem.propertykey -eq 'CidrInclusionList') -and ($PSItem.categorykey -eq 'MonitoredTargets') } |
                Select-Object -ExpandProperty 'actualValue' |
                Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.MonitoredTarget

        }

    }#process

    end { }#end

}