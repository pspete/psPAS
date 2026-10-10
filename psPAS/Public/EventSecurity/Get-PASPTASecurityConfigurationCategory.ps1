# .ExternalHelp psPAS-help.xml
function Get-PASPTASecurityConfigurationCategory {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateSet('ActiveDormantUser', 'PrivilegedUsersAndGroups', 'IrregularIpUser', 'SuspectedCredentialsTheft', 'InteractiveLogonWithServiceAccount',
            'IrregularHoursUser', 'UnmanagedPrivilegedAccess', 'SuspiciousActivityInPSMSession', 'IrregularDaysUser', 'FailedVaultLogonAttempts',
            'ExcessiveAccessUser', 'SuspiciousPasswordChange')]
        [Alias('Category')]
        [string]$categoryKey
    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.2
    }#begin

    process {

        $URI = "$($psPASSession.BaseURI)/API/pta/API/configuration/categories"

        switch ($PSBoundParameters.keys) {

            'categoryKey' {

                #Create URL for Request
                $URI = "$URI/$categoryKey"
                break
            }

        }

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            $result

        }


    }#process

    end { }#end

}