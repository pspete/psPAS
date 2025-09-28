# .ExternalHelp psPAS-help.xml
function Export-PASTicketingSystemLogs {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(1, 7)]
        [int]$days = 7,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$userID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateScript( { Test-Path -Path $_ -IsValid })]
        [string]$path
    )

    begin {
        Assert-VersionRequirement -PrivilegeCloud
    }

    process {

        #Create URL for request
        $URI = "$($psPASSession.ApiURI)/API/ticketing-systems/logs/$days/$userID"

        if ($PSCmdlet.ShouldProcess($days, 'Exports Ticketing System Logs')) {

            #send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method POST -Debug:$false

            #if we get a log archive byte array
            if ($null -ne $result) {

                Out-PASFile -InputObject $result.zipFile -Path $path

            }

        }

    }

    end {}

}