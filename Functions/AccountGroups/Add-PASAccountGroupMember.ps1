function Add-PASAccountGroupMember{
<#
.SYNOPSIS
Adds an account as a member of an account group.

.DESCRIPTION
Adds an account as a member of an account group.
The account can contain either password or SSH key.
The account must be stored in the same safe as the account group.
The following permissions are required on the safe where the account group will be created:
 - Add Accounts
 - Update Account Content
 - Update Accouunt Properties

.PARAMETER GroupID
The unique ID of the account group

.PARAMETER AccountID
The ID of the account to add as a member

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
Session Token, WebSession & BaseURI can be piped by propertyname

.OUTPUTS
None

.NOTES
[Ambiguous documentation]

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$GroupID,

        [parameter(
            Mandatory=$true
        )]
        [string]$AccountID,

        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$sessionToken,

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

    BEGIN{}#begin

    PROCESS{

        #Create URL for Request
        $URI = "$baseURI/API/AccountGroups/$($GroupID | 
            
            Get-EscapedString)/Members"

        #Create body of request
        $body = $PSBoundParameters | 
        
            Get-PASParameters -ParametersToRemove GroupID | 
        
                ConvertTo-Json
        
        #send request to PAS web service
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result}#end
}