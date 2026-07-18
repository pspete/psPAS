# .ExternalHelp psPAS-help.xml
function Import-PASTicketingSystem {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( { Test-Path -Path $_ -PathType Leaf })]
        [ValidatePattern( '\.zip$' )]
        [string]$ImportFile
    )

    begin {
        Assert-VersionRequirement -PrivilegeCloud
    }

    process {

        #Create URL for request
        $URI = "$($psPASSession.ApiURI)/API/ticketing-systems/import"

        #Convert File to byte array
        $FileBytes = $ImportFile | Get-ByteArray

        #Create Request Body
        $Body = @{'ticketingZipFile' = $FileBytes } | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($ImportFile, 'Imports Custom Ticketing System')) {

            #send request to web service
            Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Debug:$false

        }

    }

    end {}

}