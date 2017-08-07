function Get-PASSafeShareLogo {
    <#
.SYNOPSIS
Returns details of configured SafeShare Logo

.DESCRIPTION
Gets configuration details of logo displayed in the SafeShare WebGUI

.PARAMETER ImageType
The requested logo type: Square or Watermark.

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
$token | Get-PASSafeShareLogo -ImageType Square

Retrieves Safe Share Logo

.INPUTS
WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS

.NOTES
SafeShare no longer available from CyberArk

.LINK

#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true
        )]
        [ValidateSet("Square", "Watermark")]
        [String]$ImageType,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$BaseURI,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$PVWAAppName = "PasswordVault"
    )

    BEGIN {}#begin

    PROCESS {

        #Create URL for request
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Logo?type=$ImageType"

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $WebSession

    }#process

    END {$result}#end
}