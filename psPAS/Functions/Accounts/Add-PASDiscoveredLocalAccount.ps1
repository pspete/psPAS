# .ExternalHelp psPAS-help.xml
function Add-PASDiscoveredLocalAccount {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('windows', 'mac', 'unix')]
        [string]$type,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [hashtable]$identifiers,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$isPrivileged,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [hashtable]$customProperties,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$source
    )

    BEGIN {

        Assert-VersionRequirement -PrivilegeCloud

    }#begin

    PROCESS {

        #Create URL for Request
        $URI = "$($psPASSession.ApiURI)/api/discovered-accounts/"

        #Get all parameters that will be sent in the request
        $boundParameters = $PSBoundParameters | Get-PASParameter

        #Add subType key with loosely value
        $boundParameters.Add('subType', 'loosely')

        $Body = $boundParameters | ConvertTo-Json

        #send request to PAS web service
        $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body

        If ($null -ne $result) {

            #Return Results
            $result

        }

    }#process

    END { }#end

}