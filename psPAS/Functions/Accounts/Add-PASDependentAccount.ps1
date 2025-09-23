# .ExternalHelp psPAS-help.xml
function Add-PASDependentAccount {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('id')]
        [string]$AccountId,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$name,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$platformId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [hashtable]$platformAccountProperties,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$automaticManagementEnabled,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$manualManagementReason

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
        $URI = "$($psPASSession.BaseURI)/API/Accounts/$AccountID/$URLString"

        #Get all parameters that will be sent in the request
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID

        $DependentAccount = New-PASAccountObject @boundParameters -DependentAccount

        $body = $DependentAccount | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($AccountID, 'Add Dependent Account')) {

            #Send request to web service
            $Result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $body

        }

        if ($null -ne $result) {

            #Return Results
            $result

        }

    }#process

    end { }#end

}
