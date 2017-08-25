function Start-PASCredChange {
    <#
.SYNOPSIS
Initiates an immediate password change by the CPM to a new random password.

.DESCRIPTION
Flags a managed account credentials for an immediate CPM password change.
The "Initiate CPM password management operations" permission is required.

.PARAMETER AccountID
The unique ID  of the account to delete.
This is retrieved by the Get-PASAccount function.

.PARAMETER ImmediateChangeByCPM
Yes/No value, dictating if the account will be scheduled for immediate change.
Specify Yes to initiate a password change by CPM

.PARAMETER ChangeCredsForGroup
Yes/No value, dictating if all accounts that belong to the same group should
have their passwords changed.
This is only relevant for accounts that belong to an account group.
Parameter will be ignored if account does not belong to a group.

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
$token | Start-PASCredChange -AccountID 21_3 -ImmediateChangeByCPM Yes

Will mark account with ID of "21_3" for immediate password change by CPM

.EXAMPLE
$token | Get-PASAccount xAccount | Start-PASCredChange -ImmediateChangeByCPM Yes

Will mark xAccount for immediate password change by CPM

.INPUTS
SessionToken, AccountID, WebSession & BaseURI can be piped by  property name

.OUTPUTS
None

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
        [string]$AccountID,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateSet('Yes', 'No')]
        [string]$ImmediateChangeByCPM,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateSet('Yes', 'No')]
        [string]$ChangeCredForGroup,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$SessionToken,

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

    BEGIN {

        #Create empty hashtable to hold objects for header
        #CredChange header is non-standard
        $header = @{}

    }#begin

    PROCESS {

        #Create URL for request
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Accounts/$AccountID/ChangeCredentials"

        #Header is normally just session token
        $header = $SessionToken

        #Get parameters to include in request body
        $boundParameters = $PSBoundParameters |

        #ImmediateChangeByCPM must be sent in the request header
        #remove it from the body of the request
        Get-PASParameters -ParametersToRemove "ImmediateChangeByCPM"

        #add ImmediateChangeByCPM to header as key=value pair
        $header["ImmediateChangeByCPM"] = $ImmediateChangeByCPM

        #create request body
        $body = $boundParameters | ConvertTo-Json

        #send request to web service
        Invoke-PASRestMethod -Uri $URI -Method PUT -body $body -Headers $header -WebSession $WebSession


    }#process

    END {}#end

}