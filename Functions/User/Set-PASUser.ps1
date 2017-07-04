function Set-PASUser{
<#
.SYNOPSIS
Updates a vault user

.DESCRIPTION
Updates an existing user in the vault

.PARAMETER UserName
The name of the user to update in the vault

.PARAMETER NewPassword
The password to set on the account.
Must meet the password complexity requirements

.PARAMETER Email
The user's email address

.PARAMETER FirstName
The user's first name

.PARAMETER LastName
The user's last name

.PARAMETER ChangePasswordOnTheNextLogon
Whether or not user will be forced to change password on next logon

.PARAMETER ExpiryDate
Expiry Date to set on account.
Format dd/MM/yyyy

.PARAMETER UserTypeName
The User Type

.PARAMETER Disabled
Whether or not the user will be enabled or disabled.

.PARAMETER Location
The Vault Location for the user

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
            Mandatory=$false
        )]
        [string]$NewPassword,
        
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
        <#[ValidateScript({
        
            $_ -match '((^$)|(^\s+$)|(^(((0[1-9]|1[0-9]|2[0-8])[\/](0[1-9]|1[012]))|((29|30|31)[\/](0[13578]|1[02]))|((29|30)[\/](0[4,6,9]|11)))[\/](19|[2-9][0-9])\d\d$)|(^29[\/]02[\/](19|[2-9][0-9])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)$))'
        
        })]#>
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
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Users/$($UserName | 
        
            Get-EscapedString)"

        #create request body
        $body = $PSBoundParameters | 
        
            Get-PASParameters -ParametersToRemove UserName | 
            
                ConvertTo-Json
        
        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result}#end
}