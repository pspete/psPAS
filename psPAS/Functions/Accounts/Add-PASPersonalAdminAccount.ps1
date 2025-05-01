# .ExternalHelp psPAS-help.xml
function Add-PASPersonalAdminAccount {
    [CmdletBinding()]
    param(

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$address,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$userName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [securestring]$secret

    )

    BEGIN { }#begin

    PROCESS {

        #Get all parameters that will be sent in the request
        $boundParameters = $PSBoundParameters | Get-PASParameter

        Assert-VersionRequirement -RequiredVersion 12.6

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/Accounts/PersonalAdminAccount"

        $Account = New-PASAccountObject @boundParameters -PersonalAdminAccount

        $Body = $Account | ConvertTo-Json

        #send request to PAS web service
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

        If ($null -ne $result) {

            #Return Results
            $result | Add-ObjectDetail -typename 'psPAS.CyberArk.Vault.Account.V10'

        }

    }#process

    END { }#end

}