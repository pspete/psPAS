# .ExternalHelp psPAS-help.xml
function Clear-PASDependentLinkedAccount {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SelfHosted'
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SaaS'
        )]
        [Alias('id')]
        [string]$AccountID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SelfHosted'
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SaaS'
        )]
        [Alias('dependentid')]
        [string]$dependentAccountId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SaaS'
        )]
        [int]$extraPasswordIndex

    )

    begin {

    }#begin

    process {


        switch ($PSCmdlet.ParameterSetName) {

            'SaaS' {

                Assert-VersionRequirement -PrivilegeCloud

                #Create URL for Request
                $URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/account-dependents/$dependentAccountId/link-accounts/$extraPasswordIndex"

            }

            'SelfHosted' {

                #Self-Hosted parameter name, requires 15.0
                Assert-VersionRequirement -SelfHosted
                Assert-VersionRequirement -RequiredVersion 15.0

                #Create URL for Request
                $URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/dependentAccounts/$dependentAccountId/Unlink"

            }

        }


        if ($PSCmdlet.ShouldProcess($dependentAccountId, "Clear Linked Account")) {

            #Send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}