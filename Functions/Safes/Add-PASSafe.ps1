function Add-PASSafe {
    <#
.SYNOPSIS
Adds a new safe to the Vault

.DESCRIPTION
Adds a new safe to the Vault.
The "Add Safes" permission is required in the vault.

.PARAMETER SafeName
The name of the safe to create.
Max Length 28 characters.
Cannot start with a space.
Cannot contain: '\','/',':','*','<','>','"','.' or '|'

.PARAMETER Description
Description of the new safe.
Max 100 characters.

.PARAMETER OLACEnabled
Boolean value, dictating whether or not to enable Object Level Access Control on the safe.

.PARAMETER ManagingCPM
The Name of the CPM user to manage the safe.
Specify "" to prevent CPM management.

.PARAMETER NumberOfVersionsRetention
The number of retained versions of every password that is stored in the Safe.
Max value = 999
Specify either this parameter or NumberOfDaysRetention.

.PARAMETER NumberOfDaysRetention
The number of days for which password versions are saved in the Safe.
Minimum Value: 1
Maximum Value 3650
Specify either this parameter or NumberOfVersionsRetention

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
$token | Add-PASSafe -SafeName Oracle -Description "Oracle Safe" -ManagingCPM PasswordManager -NumberOfVersionsRetention 7

Creates a new safe named Oracle with a 7 version retention.

.EXAMPLE
$token | Add-PASSafe -SafeName Dev_Team -Description "Dev Safe" -ManagingCPM DEV_CPM -NumberOfDaysRetention 7

Creates a new safe named Dev_Team, assigned to CPM DEV_CPM, with a 7 day retention period.

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Safe
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK

#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {$_ -notmatch ".*(\\|\/|:|\*|<|>|`"|\.|\||^\s).*"})]
        [ValidateLength(0, 28)]
        [string]$SafeName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(0, 100)]
        [string]$Description,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$OLACEnabled,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$ManagingCPM,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "Versions"
        )]
        [ValidateRange(1, 999)]
        [int]$NumberOfVersionsRetention,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = "Days"
        )]
        [ValidateRange(1, 3650)]
        [int]$NumberOfDaysRetention,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$sessionToken,

        [parameter(
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
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Safes"

        #create request body
        $body = @{

            #add parameters to safe node
            "safe" = $PSBoundParameters | Get-PASParameters

        } | ConvertTo-Json

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END {

        $result.AddSafeResult | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe -PropertyToAdd @{

            "sessionToken" = $sessionToken
            "WebSession"   = $WebSession
            "BaseURI"      = $BaseURI
            "PVWAAppName"  = $PVWAAppName

        }

    }#end

}