# .ExternalHelp psPAS-help.xml
Function Reset-PASPTASecurityConfigurationProperty {
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

        [string]$propertyKey
    )

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.2
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/pta/API/configuration/properties/$($propertyKey | Get-EscapedString)/default"

        if ($PSCmdlet.ShouldProcess($propertyKey, 'Reset PTA Security Configuration Property')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method PUT

        }

    }#process

    END { }#end

}