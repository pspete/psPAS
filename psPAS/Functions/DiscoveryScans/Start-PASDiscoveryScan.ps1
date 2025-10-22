# .ExternalHelp psPAS-help.xml
function Start-PASDiscoveryScan {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$id
    )

    begin {

        Assert-VersionRequirement -PrivilegeCloud

    }

    process {

        #Create URL for Request
        $URI = "$($psPASSession.ApiURI)/api/scan-instances"

        $Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($id, 'Start Discovery Scan')) {

            #Send Delete request to web service
            Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

        }

    }

    end {}

}