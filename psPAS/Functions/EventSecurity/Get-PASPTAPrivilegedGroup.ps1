# .ExternalHelp psPAS-help.xml
Function Get-PASPTAPrivilegedGroup {
    [CmdletBinding()]
    param( )

    BEGIN {
        Assert-VersionRequirement -RequiredVersion 14.0
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$Script:BaseURI/API/pta/API/configuration"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

        If ($null -ne $result) {

            #Return Results
            $result | Where-Object { $PSItem.propertykey -eq 'PrivilegedDomainGroupsList' } |
                Select-Object -ExpandProperty 'ActualValue' |
                Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.PrivilegedDomainGroupsList

        }

    }#process

    END { }#end

}