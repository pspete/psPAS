function Find-SharedServicesURL {
    <#
    .SYNOPSIS
    Find URL details for ISPSS shared services

    .DESCRIPTION
    Given a shared services subdomain or URL value, returns details of URLs for available Shared Services.

    .PARAMETER subdomain
    The Shared Services subdomain to return service URL values of.

    .PARAMETER url
    The Shared Services URL to return service URL values of.

    .PARAMETER service
    Specify to return the API URL of a particular service.

    .EXAMPLE
    Find-SharedServicesURL -subdomain somedomain

    .EXAMPLE
    Find-SharedServicesURL -url https://someotherdomain.cyberark.cloud

    .EXAMPLE
    Find-SharedServicesURL -subdomain somedomain -service pcloud

    .NOTES
    Pete Maan 2023
    #>
    [CmdletBinding()]
    Param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ParameterSetName = 'Subdomain'
        )]
        [string]$subdomain,

        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ParameterSetName = 'URL'
        )]
        [string]$url,

        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $true
        )]
        [ValidateSet(
            'analytics',
            'audit',
            'cem',
            'cloud_onboarding',
            'component_manager',
            'flows',
            'idaptive_risk_analytics',
            'identity_administration',
            'identity_compliance',
            'identity_user_portal',
            'jit',
            'pcloud',
            'sca',
            'secrets_hub',
            'secrets_manager',
            'session_monitoring'
        )]
        [string]$service
    )

    Begin {
        $PlatformDiscoveryURL = 'https://platform-discovery.cyberark.cloud/api/v2/services/subdomain/'
    }

    Process {

        if ($PSCmdlet.ParameterSetName -eq 'URL') {
            $URIObject = [System.UriBuilder]::new($url)
            $subdomain = $URIObject.host.Split('.') | Select-Object -First 1
        }

        $PlatformDiscoveryURL = $PlatformDiscoveryURL + $subdomain

        $Result = Invoke-PASRestMethod -URI $PlatformDiscoveryURL -Method GET

        If ($null -ne $Result) {

            If ($PSBoundParameters.ContainsKey('service')) {

                $Services = $Result | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name

                If ($Services -notcontains $Service) {

                    throw "URL for $service API not found"

                }

                Else {

                    $Result | Select-Object -ExpandProperty $service

                }

            } Else {

                $Result

            }

        }

    }

    End {}

}