# .ExternalHelp psPAS-help.xml
function Set-PASDependentLinkedAccount {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '', Justification = 'Does not involve a plaintext password')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('id')]
        [string]$accountId,

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
        [string]$extraPasswordAccountId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('1', '2', '3')]
        [string]$extraPasswordIndex

    )

    begin {

        Assert-VersionRequirement -PrivilegeCloud

    }#begin

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/account-dependents/$dependentAccountId/link-accounts"

        #Get Parameters to include in request
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID, dependentAccountId

        # Rename the extraPasswordAccountId key to AccountID
        $boundParameters.accountID = $boundParameters.extraPasswordAccountId
        $boundParameters.Remove('extraPasswordAccountId')

        $body = $boundParameters | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($dependentAccountId, 'Set Linked Account')) {

            #Send request to web service
            Invoke-PASRestMethod -Uri $URI -Method POST -Body $body

        }

    }#process

    end { }#end

}