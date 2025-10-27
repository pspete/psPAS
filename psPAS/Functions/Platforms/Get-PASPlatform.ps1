# .ExternalHelp psPAS-help.xml
function Get-PASPlatform {
    [CmdletBinding(DefaultParameterSetName = 'targets')]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'targets'
        )]
        [boolean]$Active,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'targets'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'groups'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'rotationalGroups'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'dependents'
        )]
        [string]$Search,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'platform-details'
        )]
        [Alias('Name')]
        [string]$PlatformID,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'dependents'
        )]
        [switch]$DependentPlatform,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'groups'
        )]
        [switch]$GroupPlatform,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'rotationalGroups'
        )]
        [switch]$RotationalGroup,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'targets'
        )]
        [string]$SystemType,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'targets'
        )]
        [boolean]$PeriodicVerify,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'targets'
        )]
        [boolean]$ManualVerify,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'targets'
        )]
        [boolean]$PeriodicChange,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'targets'
        )]
        [boolean]$ManualChange,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'targets'
        )]
        [boolean]$AutomaticReconcile,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'targets'
        )]
        [boolean]$ManualReconcile

    )

    begin {

        function Get-Platform {
            ## Helper function to get platform details using the "Get platforms" API endpoint
            param(
                [parameter(
                    Mandatory = $false,
                    ValueFromPipelinebyPropertyName = $true
                )]
                [boolean]$Active,

                [parameter(
                    Mandatory = $false,
                    ValueFromPipelinebyPropertyName = $true
                )]
                [ValidateSet('Regular', 'Group')]
                [string]$PlatformType,

                [parameter(
                    Mandatory = $false,
                    ValueFromPipelinebyPropertyName = $true
                )]
                [string]$Search
            )
            begin {
                #Create request URL
                $URI = "$($psPASSession.BaseURI)/API/Platforms"
            }
            process {
                #Get Parameters to include in request
                $boundParameters = $PSBoundParameters | Get-PASParameter

                #Create Query String, escaped for inclusion in request URL
                $queryString = $boundParameters | ConvertTo-QueryString

                if ($null -ne $queryString) {
                    #Build URL from base URL
                    $URI = "$URI`?$queryString"
                }

                $PlatformQuery = Invoke-PASRestMethod -Uri $URI -Method GET
            }
            end {
                if ($null -ne $PlatformQuery.Platforms) {
                    #Return the details of the platforms
                    $PlatformQuery.Platforms
                }
            }

        }

        #include these parameter values in url for Get-Platform call
        $PlatformQueryParameters = [Collections.Generic.List[Object]]::New(@('Active', 'Search'))

        # Ensure PlatformData is always defined
        $PlatformData = @()

    }#begin

    process {

        switch ($PSCmdlet.ParameterSetName) {

            'platform-details' {
                #Returns details of a specific platform

                Assert-VersionRequirement -RequiredVersion 9.10

                #Create request URL
                $URI = "$($psPASSession.BaseURI)/API/Platforms/$($PlatformID | Get-EscapedString)/"

                break

            }

            'targets' {
                #Returns details of target platforms

                Assert-VersionRequirement -RequiredVersion 11.4

                $URI = "$($psPASSession.BaseURI)/API/Platforms/$($PSCmdlet.ParameterSetName)"

                #Parameter to include parameter value in url
                $Parameters = [Collections.Generic.List[Object]]::New(@('Search'))

                #Get Parameters to include in request filter string
                $filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove $Parameters
                $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters
                $FilterString = $filterParameters | ConvertTo-FilterString

                if ($null -ne $FilterString) {
                    #Add filter string to parameters
                    $boundParameters = $boundParameters + $FilterString

                }

                #Create Query String, escaped for inclusion in request URL
                $queryString = $boundParameters | ConvertTo-QueryString

                if ($null -ne $queryString) {

                    #Add query string to request URL
                    $URI = "$URI`?$queryString"

                }

                #Get additional regular platform details using the Get-Platforms Helper function for merging into results
                $PlatformParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $PlatformQueryParameters
                $PlatformData = Get-Platform @PlatformParameters -PlatformType 'Regular'

                break

            }

            default {
                #details of group, rotational, and dependent platforms
                Assert-VersionRequirement -RequiredVersion 11.4

                $URI = "$($psPASSession.BaseURI)/API/Platforms/$($PSCmdlet.ParameterSetName)"

                $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove GroupPlatform, RotationalGroup, DependentPlatform

                #Create Query String, escaped for inclusion in request URL
                $queryString = $boundParameters | ConvertTo-QueryString

                if ($null -ne $queryString) {
                    #Add query string to request URL
                    $URI = "$URI`?$queryString"

                }

                if ($PSCmdlet.ParameterSetName -ne 'dependents') {
                    #Get additional group platform details using the Get-Platforms Helper function for merging into results
                    $PlatformParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $PlatformQueryParameters
                    $PlatformData = Get-Platform @PlatformParameters -PlatformType 'Group'
                } else {
                    $PlatformData = @()
                }
                break

            }

        }

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        switch ($PSCmdlet.ParameterSetName) {

            'platform-details' {

                if ($null -ne $result.Details) {
                    #Single platform detail response
                    #Flatten the Details property into top-level
                    $platform = [PSCustomObject]@{}

                    # Add top-level properties
                    foreach ($prop in $result.PSObject.Properties) {
                        if ($prop.Name -ne 'Details') {
                            $platform | Add-Member -NotePropertyName $prop.Name -NotePropertyValue $prop.Value
                        }
                    }

                    # Add nested properties from Details
                    foreach ($prop in $result.Details.PSObject.Properties) {
                        $platform | Add-Member -NotePropertyName $prop.Name -NotePropertyValue $prop.Value
                    }

                    $result = $platform

                    $typename = 'psPAS.CyberArk.Vault.Platform.Details'

                }

            }

            default {

                if ($result.Total -eq 0) {

                    $result = Join-ObjectByProperty -PrimaryObjects $($result | Select-Object -ExpandProperty Platforms) -SecondaryObjects $PlatformData -PrimaryKey 'PlatformID' -SecondaryKey 'general.id'
                    $typename = 'psPAS.CyberArk.Vault.Platform.Basic'

                } elseif (($null -ne $result.Platforms) -and ($result.Total -gt 0)) {
                    #11.1+ returns result under "platforms" property
                    #Merge platform details from Get-Platforms call into results
                    $result = Join-ObjectByProperty -PrimaryObjects $($result | Select-Object -ExpandProperty Platforms) -SecondaryObjects $PlatformData -PrimaryKey 'PlatformID' -SecondaryKey 'general.id'

                    # ensure typename is set; switch below will override appropriately
                    $typename = ''

                    switch ($PSCmdlet.ParameterSetName) {
                        #Set output type name based on parameter set used
                        'targets' {
                            $typename = 'psPAS.CyberArk.Vault.Platform.Targets'
                            break
                        }

                        'groups' {
                            $typename = 'psPAS.CyberArk.Vault.Platform.Groups'
                            break
                        }

                        'dependents' {
                            $typename = 'psPAS.CyberArk.Vault.Platform.Dependents'
                            break
                        }

                        'rotationalGroups' {
                            $typename = 'psPAS.CyberArk.Vault.Platform.RotationalGroups'
                            break
                        }

                    }

                }

            }

        }

        if ($null -ne $result) {
            $result | Add-ObjectDetail -typename $typename
        }

    }#process

    end { }#end

}