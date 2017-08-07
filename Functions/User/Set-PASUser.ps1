function Set-PASUser {
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
Format MM/dd/yyyy

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

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
$token | set-pasuser -UserName Bill -Disabled $true

Disables vault user Bill

.INPUTS
UserName, SessionToken, WebSession & BaseURI can be piped to the function by propertyname

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
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [securestring]$NewPassword,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [string]$Email,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [string]$FirstName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [string]$LastName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [boolean]$ChangePasswordOnTheNextLogon,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateScript( {

                ($_ -match '^(((0[13578]|1[02])[/](0[1-9]|[12][0-9]|3[01])|(0[469]|11)[/](0[1-9]|[12][0-9]|30)|02[/](0[1-9]|1\d|2[0-8]))[/]\d{4}|02[/]29[/](\d{2}(0[48]|[2468][048]|[13579][26])|([02468][048]|[1359][26])00))$')

            })]
        [string]$ExpiryDate,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [string]$UserTypeName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [boolean]$Disabled,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
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
        $boundParameters = $PSBoundParameters | Get-PASParameters -ParametersToRemove UserName

        #deal with newPassword SecureString
        If($PSBoundParameters.ContainsKey("NewPassword")) {

            #Create New Credential object
            $NewPwd = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $(

                #Assign UserName and newPassword
                $UserName), $NewPassword

            #Inclued decoded password in request
            $boundParameters["NewPassword"] = $($NewPwd.GetNetworkCredential().Password)

        }

        #Create URL for request
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)"

        #create request body
        $body = $boundParameters | ConvertTo-Json

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -Headers $sessionToken -WebSession $WebSession

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