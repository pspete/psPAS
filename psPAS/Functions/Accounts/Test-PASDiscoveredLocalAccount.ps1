# .ExternalHelp psPAS-help.xml
function Test-PASDiscoveredLocalAccount {
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
        [Hashtable]$identifiers,

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
        [DiscoveredAccount[]]$accounts

    )

    begin {

        Assert-VersionRequirement -PrivilegeCloud

    }

    process {

        #Create URL for Request
        $URI = "$($psPASSession.ApiURI)/api/discovered-accounts/check-existence"

        #Get Parameters to include in request
        $boundParameters = $PSBoundParameters | Get-PASParameter

        switch ($PSCmdlet.ParameterSetName) {

            'single' {

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