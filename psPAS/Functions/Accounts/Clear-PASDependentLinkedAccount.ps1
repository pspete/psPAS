# .ExternalHelp psPAS-help.xml
function Clear-PASDependentLinkedAccount {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('id')]
        [string]$AccountID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('dependentid')]
        [string]$dependentAccountId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [int]$extraPasswordIndex

    )

    begin {

        Assert-VersionRequirement -PrivilegeCloud

    }#begin

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/account-dependents/$dependentAccountId/link-accounts/$extraPasswordIndex"

        if ($PSCmdlet.ShouldProcess($dependentAccountId, "Clear extraPass$extraPasswordIndex Linked Account")) {

            #Send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}