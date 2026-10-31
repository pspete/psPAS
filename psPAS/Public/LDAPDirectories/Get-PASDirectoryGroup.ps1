# .ExternalHelp psPAS-help.xml
function Get-PASDirectoryGroup {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('DomainName')]
        [string]$DirectoryName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Contains,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Context,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [int]$Limit,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$IsSSLConnection
    )

    begin {

        Assert-VersionRequirement -RequiredVersion 15.2

    }#begin

    process {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/api/Configuration/LDAP/Directories/$DirectoryName/Groups"

        #Get Parameters to include in request
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove 'DirectoryName'

        #Create Query String, escaped for inclusion in request URL
        $queryString = $boundParameters | ConvertTo-QueryString

        if ($null -ne $queryString) {

            #Build URL from base URL
            $URI = "$URI`?$queryString"

        }

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            #Return Results
            $result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Directory.Group

        }

    }#process

    end { }#end

}
