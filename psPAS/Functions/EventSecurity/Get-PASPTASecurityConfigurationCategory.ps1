# .ExternalHelp psPAS-help.xml
Function Get-PASPTASecurityConfigurationCategory {
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

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.2
    }#begin

    PROCESS {

        switch ($PSBoundParameters.keys) {

            'categoryKey' {

                #Create URL for Request
                $URI = "$($psPASSession.BaseURI)/API/pta/API/configuration/categories/$categoryKey"

                break

            }

            Default {

                #Create URL for Request
                $URI = "$($psPASSession.BaseURI)/API/pta/API/configuration/categories"

                break

            }

        }

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $result) {

            $result

        }


    }#process

    END { }#end

}