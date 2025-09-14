# .ExternalHelp psPAS-help.xml
function Get-PASLinkedAccount {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('AccountID')]
        [string]$id

    )

    begin {

        #Assume this is possible since Link/Unlink account capability in the newer UI
        Assert-VersionRequirement -RequiredVersion 12.2

    }#begin

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/ExtendedAccounts/$id/LinkedAccounts"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            #Return Results
            $result.LinkedAccounts | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account.LinkedAccount

        }

    }#process

    end { }#end

}