# .ExternalHelp psPAS-help.xml
Function Set-PASIPAllowList {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [AllowEmptyCollection()]
        [ValidatePattern('(?:[\d{1,3}\.]+)\/(?:2[2-9]|3[0-2])')]
        [string[]]$customerPublicIPs
    )

    Begin {
        Assert-VersionRequirement -PrivilegeCloud
    }

    Process {

        #Create URL for request
        $URI = "$($psPASSession.ApiURI)/api/advanced-settings/ip-allowlist"

        if ($PSCmdlet.ShouldProcess($($customerPublicIPs -join ','), 'Set IP AllowList Properties')) {

            #send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method PUT

            If ($null -ne $result) {

                $result

            }

        }

    }

    End {}

}