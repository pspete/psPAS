# .ExternalHelp psPAS-help.xml
function Publish-PASDiscoveredAccount {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$id,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$PlatformID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$safeName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$shouldReconcileAccount,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [securestring]$defaultPassword

    )

    begin {

        Assert-VersionRequirement -RequiredVersion 12.6

    }#begin

    process {

        $URI = "$($psPASSession.BaseURI)/api/DiscoveredAccounts/$id/Onboard"

        #Get all parameters that will be sent in the request
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove id

        #deal with defaultPassword SecureString
        if ($PSBoundParameters.ContainsKey('defaultPassword')) {

            #Include decoded password in request
            $boundParameters['defaultPassword'] = $(ConvertTo-InsecureString -SecureString $defaultPassword)

        }

        $Body = $boundParameters | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($id, 'Onboard Discovered Account')) {

            Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

        }

    }#process

    end { }#end

}