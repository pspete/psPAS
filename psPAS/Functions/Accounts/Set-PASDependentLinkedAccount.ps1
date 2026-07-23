# .ExternalHelp psPAS-help.xml
function Set-PASDependentLinkedAccount {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '', Justification = 'Does not involve a plaintext password')]
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
        [string]$accountId,

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
        [string]$extraPasswordAccountId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SaaS'
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SelfHosted'
        )]
        [ValidateSet('1', '2', '3')]
        [string]$extraPasswordIndex,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SelfHosted'
        )]
        [string]$safe,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SelfHosted'
        )]
        [string]$name,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SelfHosted'
        )]
        [string]$folder = "Root"

    )

    begin {

    }#begin

    process {

        switch ($PSCmdlet.ParameterSetName) {

            'SaaS' {

                Assert-VersionRequirement -PrivilegeCloud

                #Create URL for Request
                $URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/account-dependents/$dependentAccountId/link-accounts"

                #Get Parameters to include in request
                $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID, dependentAccountId

                # Rename the extraPasswordAccountId key to AccountID
                $boundParameters.accountID = $boundParameters.extraPasswordAccountId
                $boundParameters.Remove('extraPasswordAccountId')

            }

            'SelfHosted' {

                Assert-VersionRequirement -SelfHosted
                Assert-VersionRequirement -RequiredVersion 15.0

                #Create URL for Request
                $URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/dependentAccounts/$dependentAccountId/Link"

                #Get Parameters to include in request
                $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID, dependentAccountId

                #Ensure folder value is included in the request body
                $boundParameters['folder'] = $folder

            }

        }
        
        $body = $boundParameters | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($dependentAccountId, 'Set Linked Account')) {

            #Send request to web service
            Invoke-PASRestMethod -Uri $URI -Method POST -Body $body

        }
    }
    end { }#end
}
