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
<<<<<<< HEAD
Format: MM/dd/yyyy
=======
>>>>>>> refs/remotes/origin/master

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
<<<<<<< HEAD
            Mandatory=$false
=======
            Mandatory=$true
>>>>>>> refs/remotes/origin/master
        )]
        [string]$Email,
        
        [parameter(
<<<<<<< HEAD
            Mandatory=$false
=======
            Mandatory=$true
>>>>>>> refs/remotes/origin/master
        )]
        [string]$FirstName,
        
        [parameter(
<<<<<<< HEAD
            Mandatory=$false
=======
            Mandatory=$true
>>>>>>> refs/remotes/origin/master
        )]
        [string]$LastName,
        
        [parameter(
<<<<<<< HEAD
            Mandatory=$false
=======
            Mandatory=$true
>>>>>>> refs/remotes/origin/master
        )]
        [boolean]$ChangePasswordOnTheNextLogon,
        
        [parameter(
<<<<<<< HEAD
            Mandatory=$false
        )]
        [ValidateScript({
        
            $_ -match '^(((0[13578]|1[02])[/](0[1-9]|[12][0-9]|3[01])|(0[469]|11)[/](0[1-9]|[12][0-9]|30)|02[/](0[1-9]|1\d|2[0-8]))[/]\d{4}|02[/]29[/](\d{2}(0[48]|[2468][048]|[13579][26])|([02468][048]|[1359][26])00))$'
        
        })]
        [String]$ExpiryDate,
        
        [parameter(
            Mandatory=$false
=======
            Mandatory=$true
        )]
        [DateTime]$ExpiryDate,
        
        [parameter(
            Mandatory=$true
>>>>>>> refs/remotes/origin/master
        )]
        [string]$UserTypeName,
        
        [parameter(
<<<<<<< HEAD
            Mandatory=$false
=======
            Mandatory=$true
>>>>>>> refs/remotes/origin/master
        )]
        [boolean]$Disabled,
        
        [parameter(
<<<<<<< HEAD
            Mandatory=$false
=======
            Mandatory=$true
>>>>>>> refs/remotes/origin/master
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