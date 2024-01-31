# .ExternalHelp psPAS-help.xml
Function Get-PASPTAPrivilegedUser {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('ActualValue', 'DefaultValue')]
        [string]$ValueType
    )

    BEGIN {
        Assert-VersionRequirement -RequiredVersion 14.0
        $ReturnValue = 'ActualValue'
    }#begin

    PROCESS {

        If ($PSBoundParameters.ContainsKey('ValueType')) {
            $ReturnValue = $ValueType
        }
        #Create request URL
        $URI = "$Script:BaseURI/API/pta/API/configuration"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

        If ($null -ne $result) {

            #Return Results
            $result | Where-Object { $PSItem.propertykey -eq 'PrivilegedUsersList' } |
                Select-Object -ExpandProperty $ReturnValue |
                Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.PrivilegedUsersList

        }

    }#process

    END { }#end

}