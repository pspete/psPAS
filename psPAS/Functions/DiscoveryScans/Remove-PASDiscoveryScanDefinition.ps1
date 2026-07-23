# .ExternalHelp psPAS-help.xml
function Remove-PASDiscoveryScanDefinition {
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
        $URI = "$($psPASSession.ApiURI)/api/scan-definitions/$id"

        if ($PSCmdlet.ShouldProcess($id, 'Remove Scan Definition')) {

            #Send Delete request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }

    end {}

}