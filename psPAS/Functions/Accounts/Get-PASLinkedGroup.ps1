# .ExternalHelp psPAS-help.xml
Function Get-PASLinkedGroup {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('AccountID')]
        [string]$id

    )

    BEGIN {

        #Assume this is possible since Link/Unlink account capability in the newer UI
        Assert-VersionRequirement -RequiredVersion 12.2

    }#begin

    PROCESS {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/ExtendedAccounts/$id/LinkedAccounts"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $result) {

            #Return Results
            $result | Select-Object -Property * -ExcludeProperty LinkedAccounts | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account.LinkedGroup

        }

    }#process

    END { }#end

}