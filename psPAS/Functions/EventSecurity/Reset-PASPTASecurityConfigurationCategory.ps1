# .ExternalHelp psPAS-help.xml
function Reset-PASPTASecurityConfigurationCategory {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('ActiveDormantUser', 'PrivilegedUsersAndGroups', 'IrregularIpUser', 'SuspectedCredentialsTheft', 'InteractiveLogonWithServiceAccount',
            'IrregularHoursUser', 'UnmanagedPrivilegedAccess', 'SuspiciousActivityInPSMSession', 'IrregularDaysUser', 'FailedVaultLogonAttempts', 'ExcessiveAccessUser')]
        [string]$categoryKey
    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.2
    }#begin

    process {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/API/pta/API/configuration/properties/$($categoryKey | Get-EscapedString)/default"

        if ($PSCmdlet.ShouldProcess($categoryKey, 'Reset PTA Security Configuration Category')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method PUT

        }

    }#process

    end { }#end

}