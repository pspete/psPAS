function Start-PASCredChange{
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
Yes/No value, dictating if the accounnt will be scheduled for immediate change.
Specify Yes to initaiate a password change by CPM

.PARAMETER ChangeCredsForGroup
Yes/No value, dictating if all accounts that belong to the same group should 
have their passwords changed.
This is only relevent for accounts that belong to an account group.
Parameter will be ignored if account does not belong to a group.

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

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
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AccountID,

        [parameter(
            Mandatory=$false
        )]
        [ValidateSet('Yes','No')]
        [string]$ImmediateChangeByCPM,

        [parameter(
            Mandatory=$false
        )]
        [ValidateSet('Yes','No')]
        [string]$ChangeCredForGroup,

        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$SessionToken,

        [parameter(
            ValueFromPipelinebyPropertyName=$true
        )]
        [Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [string]$BaseURI
    )

    BEGIN{
        
        #Create empty hashtable to hold objects for header
        #CredChange header is non-standard
        $header = @{}

    }#begin

    PROCESS{
        
        #Create URL for request
        $URI = "$BaseURI/PasswordVault/WebServices/PIMServices.svc/Accounts/$AccountID/ChangeCredentials"

        #Header is normally just session token
        $header = $SessionToken

        #Get parameters to in clude in request body
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

    END{}#end

}