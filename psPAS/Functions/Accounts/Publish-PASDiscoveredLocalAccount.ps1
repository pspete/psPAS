# .ExternalHelp psPAS-help.xml
function Publish-PASDiscoveredLocalAccount {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'coreAttributesProperties', Justification = 'False Positive')]
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
        [string]$safeName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$platformID,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [hashtable]$additionalProperties,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [securestring]$secret,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$resetSecret

    )

    BEGIN {

        Assert-VersionRequirement -PrivilegeCloud
        $coreAttributes = [Collections.Generic.List[String]]@('safeName', 'platformID')

    }#begin

    PROCESS {

        $URI = "$($psPASSession.ApiURI)/api/discovered-accounts/$id/onboard"

        #Get all parameters that will be sent in the request
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove id

        #deal with defaultPassword SecureString
        If ($PSBoundParameters.ContainsKey('secret')) {

            #Include decoded password in request
            $boundParameters['secret'] = $(ConvertTo-InsecureString -SecureString $secret)

        }

        $boundParameters.keys | Where-Object { $coreAttributes -contains $_ } | ForEach-Object {

            $coreAttributesProperties = @{ }

        } {

            #add key=value to hashtable
            $coreAttributesProperties[$_] = $boundParameters[$_]

        } {

            If ($coreAttributesProperties.Count -gt 0) {

                $boundParameters['coreAttributes'] = $coreAttributesProperties

            }

        }

        $Body = $boundParameters | Get-PASParameter -ParametersToRemove $coreAttributes | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($id, 'Onboard Discovered Local Account')) {

            Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

        }

    }#process

    END { }#end

}