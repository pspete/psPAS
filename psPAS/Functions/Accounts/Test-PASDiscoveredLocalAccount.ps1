# .ExternalHelp psPAS-help.xml
function Test-PASDiscoveredLocalAccount {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'identifiers', Justification = 'False Positive')]
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'single'
        )]
        [string]$type,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'single'
        )]
        [string]$subtype,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'single'
        )]
        [string]$address,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'single'
        )]
        [string]$username,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'single'
        )]
        [string]$externalId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'multiple'
        )]
        [hashtable[]]$accounts

    )

    begin {

        Assert-VersionRequirement -PrivilegeCloud

        $identifierProperties = [Collections.Generic.List[String]]@('address', 'username')

    }

    process {

        #Create URL for Request
        $URI = "$($psPASSession.ApiURI)/api/discovered-accounts/check-existence"

        #Get Parameters to include in request
        $boundParameters = $PSBoundParameters | Get-PASParameter

        switch ($PSCmdlet.ParameterSetName) {

            'single' {

                $boundParameters.keys | Where-Object { $identifierProperties -contains $PSItem } | ForEach-Object {

                    $identifiers = @{ }

                } {

                    #add key=value to hashtable
                    $identifiers[$PSItem] = $boundParameters[$PSItem]

                } {

                    $boundParameters['identifiers'] = $identifiers

                }

                $boundParameters = $boundParameters | Get-PASParameter -ParametersToRemove $identifierProperties

                $body = @{'account' = @($boundParameters) } | ConvertTo-Json -Depth 3

                break

            }

            'multiple' {

                $body = $boundParameters | ConvertTo-Json -Depth 3

                break

            }

        }

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -body $body

        if ($null -ne $Result) {

            #Return result
            $Result

        }

    }

    end {}

}