# .ExternalHelp psPAS-help.xml
Function Set-PASGroup {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [int]$GroupID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$GroupName
    )

    BEGIN {

        Assert-VersionRequirement -RequiredVersion 12.0

    }#begin

    Process {

        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/UserGroups/$GroupID"

        #Get request parameters
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove GroupID

        #Construct Request Body
        $Body = $boundParameters | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($GroupID, 'Update Group')) {

            #send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body

        }

        if ($null -ne $result) {

            $result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Group

        }

    }

    End { }

}