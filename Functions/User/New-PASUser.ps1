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
Format: dd/MM/yyyy

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
            Mandatory=$false
        )]
        [string]$Email,
        
        [parameter(
            Mandatory=$false
        )]
        [string]$FirstName,
        
        [parameter(
            Mandatory=$false
        )]
        [string]$LastName,
        
        [parameter(
            Mandatory=$false
        )]
        [boolean]$ChangePasswordOnTheNextLogon,
        
        [parameter(
            Mandatory=$false
        )]
        [ValidateScript({
        
            $_ -match '((^$)|(^(((0[1-9]|1[0-9]|2[0-8])[\/](0[1-9]|1[012]))|((29|30|31)[\/](0[13578]|1[02]))|((29|30)[\/](0[4,6,9]|11)))[\/](19|[2-9][0-9])\d\d$)|(^29[\/]02[\/](19|[2-9][0-9])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)$))'
        
        })]
        [string]$ExpiryDate,
        
        [parameter(
            Mandatory=$false
        )]
        [string]$UserTypeName,
        
        [parameter(
            Mandatory=$false
        )]
        [boolean]$Disabled,
        
        [parameter(
            Mandatory=$false
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