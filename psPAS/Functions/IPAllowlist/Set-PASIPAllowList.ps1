# .ExternalHelp psPAS-help.xml
Function Set-PASIPAllowList {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [AllowEmptyCollection()]
        [ValidatePattern('^(?:(25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/(?:2[2-9]|3[0-2])$')]
        [string[]]$customerPublicIPs
    )

    Begin {
        Assert-VersionRequirement -PrivilegeCloud
    }

    Process {

        #Create URL for request
        $URI = "$($psPASSession.ApiURI)/api/advanced-settings/ip-allowlist"

        $body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($($customerPublicIPs -join ','), 'Set IP AllowList Properties')) {

            #send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $body

            If ($null -ne $result) {

                $result

            }

        }

    }

    End {}

}