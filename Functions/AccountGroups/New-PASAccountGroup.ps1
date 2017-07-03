function New-PASAccountGroup{
<#
.SYNOPSIS
Adds a new account group to the Vault

.DESCRIPTION
Defines a new account group in the vault.
The following permissions are required on the safe where the account group will be created:
 - Add Accounts
 - Update Account Content
 - Update Accouunt Properties
  -Create Folders

.PARAMETER GroupName
The name of the group to create

.PARAMETER GroupPlatform
The name of the platform for the group.
The associated platform must be set to "PolicyType=Group"

.PARAMETER Safe
The Safe where the group will be cerated

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

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$GroupName,

        [parameter(
            Mandatory=$true
        )]
        [string]$GroupPlatform,

        [parameter(
            Mandatory=$true
        )]
        [string]$Safe,

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
        $URI = "$baseURI/API/AccountGroups/"

        #Create body of request
        $body = $PSBoundParameters | Get-PASParameters | ConvertTo-Json
        
        #send request to PAS web service
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result}#end
}