# .ExternalHelp psPAS-help.xml
Function Get-PASPTASecurityConfigurationCategory {
    [CmdletBinding(SupportsShouldProcess = $false, DefaultParameterSetName = 'ListAllCategories')]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false,
            ParameterSetName = 'ListAllCategories'
        )]
        [switch]$ListAllCategories,
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false,
            ParameterSetName = 'categoryKey'
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

        switch ($PSCmdlet.ParameterSetName) {

            'ListAllCategories' {

                #Create request URL
                $URI = "$($psPASSession.BaseURI)/API/pta/API/configuration/categories"

                #send request to web service
                $result = Invoke-PASRestMethod -Uri $URI -Method GET

                If ($null -ne $result) {

                    #Return Results as objects
                    $result | ForEach-Object {
                        [PSCustomObject]@{
                            Category = $_
                        }
                    }

                }

            }

            'categoryKey' {

                #Create URL for Request
                $URI = "$($psPASSession.BaseURI)/API/pta/API/configuration/categories/$categoryKey"

                #send request to web service
                $result = Invoke-PASRestMethod -Uri $URI -Method GET

                If ($null -ne $result) {

                    $result 

                }

            }

        }


    }#process

    END { }#end

}