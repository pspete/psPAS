# .ExternalHelp psPAS-help.xml
function Get-PASPTAPrivilegedGroup {
    [CmdletBinding()]
    param( )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.0
    }#begin

    process {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/pta/API/configuration"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            #Return Results
            $result | Where-Object { $PSItem.propertykey -eq 'PrivilegedDomainGroupsList' } |
                Select-Object -ExpandProperty 'ActualValue' |
                Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.PrivilegedDomainGroupsList

        }

    }#process

    end { }#end

}