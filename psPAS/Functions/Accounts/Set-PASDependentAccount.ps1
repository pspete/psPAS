# .ExternalHelp psPAS-help.xml
Function Set-PASDependentAccount {
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
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$name,

        [parameter(
            Mandatory = $false,
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

    BEGIN {

        Assert-VersionRequirement -RequiredVersion 14.6

    }#begin

    PROCESS {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/Accounts/$AccountID/dependentAccounts/$dependentAccountId"

        #Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID, dependentAccountId

        $DependentAccount = New-PASAccountObject @boundParameters -DependentAccount

        #Get the dependent account that is being updated
        $DependentAccountObject = Get-PASDependentAccount -AccountId $AccountID -DependentAccountId $dependentAccountId

        #Set current values if required
        if (-not $boundParameters.ContainsKey('name')) {
            $DependentAccount.name = $DependentAccountObject.name
        }

        if (-not $boundParameters.ContainsKey('platformAccountProperties')) {
            $DependentAccount.platformAccountProperties = $DependentAccountObject.platformAccountProperties
        }

        if (-not $boundParameters.ContainsKey('automaticManagementEnabled')) {
            $DependentAccount.secretManagement.automaticManagementEnabled = $DependentAccountObject.secretManagement.automaticManagementEnabled
        }

        if (-not $boundParameters.ContainsKey('manualManagementReason')) {
            $DependentAccount.secretManagement.manualManagementReason = $DependentAccountObject.secretManagement.manualManagementReason
        }

		$body = $DependentAccount | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($AccountID, "Update Dependent Account $dependentAccountId")) {

            #Send request to web service
            Invoke-PASRestMethod -Uri $URI -Method PUT -Body $body

        }

    }#process

    END { }#end

}
