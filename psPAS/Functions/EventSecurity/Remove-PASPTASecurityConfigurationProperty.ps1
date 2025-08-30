# .ExternalHelp psPAS-help.xml
Function Remove-PASPTASecurityConfigurationProperty {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('PrivilegedUsersList', 'PrivilegedDomainGroupsList', 'ActiveDormantUserAlgorithmEnabled',
            'ActiveDormantUserEventScore', 'ActiveDormantUserDays', 'ExcessiveAccessUserAlgorithmEnabled', 'ExcessiveAccessUserScoreRange',
            'FailedVaultLogonAttemptsAlgorithmEnabled', 'FailedVaultLogonAttemptsScoreOptions', 'FailedVaultLogonAttemptsThreshold',
            'FailedVaultLogonAttemptsTimeframe', 'IrregularDaysUserAlgorithmEnabled', 'IrregularDaysUserScoreRange', 'IrregularHoursUserAlgorithmEnabled',
            'IrregularHoursUserExcludedUsernames', 'IrregularHoursUserScoreRange', 'IrregularIpUserAlgorithmEnabled', 'IrregularIpUserExcludedSourceIpsList',
            'IrregularIpUserScoreRange', 'SCTAlgorithmEnabled', 'SCTEventScore', 'SCTExcludedAccountsList', 'SCTPasswordRetrievalTimeWindow',
            'InteractiveLogonWithServiceAccountAlgorithmEnabled', 'InteractiveLogonWithServiceAccountEventScore', 'ServiceAccountIncludeList',
            'SPCAlgorithmEnabled', 'SPCEventScore', 'SPCPassChangeByCPMTimeWindow', 'UPAAlgorithmEnabled', 'UPAEventScore', 'UPAExcludedAccountsList' ) ]

        [string]$propertyKey,
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$id
    )

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.2
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/pta/API/configuration/properties/$($propertyKey | Get-EscapedString)/$($id | Get-EscapedString)"

        if ($PSCmdlet.ShouldProcess($id, 'Delete PTA Security Configuration Property')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    END { }#end

}