# .ExternalHelp psPAS-help.xml
Function Get-PASDiscoveredLocalAccountActivity {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$id
    )

    Begin {

        Assert-VersionRequirement -PrivilegeCloud

    }

    Process {

        #Create URL for Request
        $URI = "$($psPASSession.ApiURI)/api/discovered-accounts/$id/activities"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        If ($null -ne $Result) {

            #Return result
            $Result

        }

    }

    End {}

}