function New-PASUser{
<#
.SYNOPSIS
Creates a new vault user

.DESCRIPTION
Adds a new user to the vault

.PARAMETER UserName
The name of the user to create in the vault

.PARAMETER InitialPassword
The password to set on the account.
Must meet the password complexity requirements

.PARAMETER Email
The user's email address

.PARAMETER FirstName
The user's first name

.PARAMETER LastName
The user's last name

.PARAMETER ChangePasswordOnTheNextLogon
Whether or not user will be forced to change password on first logon

.PARAMETER ExpiryDate
Expiry Date to set on account.
Default is Never

.PARAMETER UserTypeName
The Type of User to create.
EPVUser type will be created by default.

.PARAMETER Disabled
Whether or not the user will be created as a disbaled user
Default is Enabled

.PARAMETER Location
The Vault Location where the user will be created
Default location is "Root"

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
SessionToken, WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
User Details

.NOTES

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true
        )]
        [string]$UserName,
        
        [parameter(
            Mandatory=$true
        )]
        [string]$InitialPassword,
        
        [parameter(
            Mandatory=$true
        )]
        [string]$Email,
        
        [parameter(
            Mandatory=$true
        )]
        [string]$FirstName,
        
        [parameter(
            Mandatory=$true
        )]
        [string]$LastName,
        
        [parameter(
            Mandatory=$true
        )]
        [boolean]$ChangePasswordOnTheNextLogon,
        
        [parameter(
            Mandatory=$true
        )]
        [DateTime]$ExpiryDate,
        
        [parameter(
            Mandatory=$true
        )]
        [string]$UserTypeName,
        
        [parameter(
            Mandatory=$true
        )]
        [boolean]$Disabled,
        
        [parameter(
            Mandatory=$true
        )]
        [string]$Location,

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

        #Create URL for request
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Users"

        #create request body
        $body = $PSBoundParameters | Get-PASParameters | ConvertTo-Json
        
        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result}#end
}