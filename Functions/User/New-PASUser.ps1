function New-PASUser {
    <#
.SYNOPSIS
Creates a new vault user

.DESCRIPTION
Adds a new user to the vault

.PARAMETER UserName
The name of the user to create in the vault

.PARAMETER InitialPassword
The password to set on the account, as a Secure String
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
Format: MM/dd/yyyy

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

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
$token | New-PASUser -UserName NewUser -InitialPassword $securePWD

Creates a Vault user named NewUser, with password set to securestring value from $securePWD

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.User
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
        [string]$UserName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [securestring]$InitialPassword,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Email,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$FirstName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$LastName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$ChangePasswordOnTheNextLogon,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateScript( {

                ($_ -match '^(((0[13578]|1[02])[/](0[1-9]|[12][0-9]|3[01])|(0[469]|11)[/](0[1-9]|[12][0-9]|30)|02[/](0[1-9]|1\d|2[0-8]))[/]\d{4}|02[/]29[/](\d{2}(0[48]|[2468][048]|[13579][26])|([02468][048]|[1359][26])00))$')

            })]
        [String]$ExpiryDate,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$UserTypeName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$Disabled,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Location,

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

        #Get request parameters
        $boundParameters = $PSBoundParameters | Get-PASParameters

        #deal with newPassword SecureString
        #Create New Credential object
        $InitialPwd = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $(

            #Assign UserName and initialPassword
            $UserName), $InitialPassword

        #Include decoded password in request
        $boundParameters["InitialPassword"] = $($InitialPwd.GetNetworkCredential().Password)

        #Construct Request Body
        $body = $boundParameters | ConvertTo-Json

        #Create URL for request
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Users"

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END {

        $result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User -PropertyToAdd @{

            "sessionToken" = $sessionToken
            "WebSession"   = $WebSession
            "BaseURI"      = $BaseURI
            "PVWAAppName"  = $PVWAAppName

        }

    }#end

}