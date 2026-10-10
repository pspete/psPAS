# .ExternalHelp psPAS-help.xml
function Remove-PASDependentAccount {
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
        [string]$dependentAccountId

    )

    begin {

        Assert-VersionRequirement -RequiredVersion 14.6

        #The url pattern is different between self-hosted and ISPSS
        #check for hosting type here
        if (Test-IsISPSS) {
            $URLString = 'account-dependents'
        } else {
            $URLString = 'dependentAccounts'
        }

    }#begin

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/Accounts/$AccountID/$URLString/$dependentAccountId"

        if ($PSCmdlet.ShouldProcess($AccountID, 'Remove Dependent Account')) {

            #Send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}
