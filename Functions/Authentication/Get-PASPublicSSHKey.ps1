function Get-PASPublicSSHKey{
<#
.SYNOPSIS
Retrieves a user's SSH Keys.

.DESCRIPTION
Retrieves all public SSH keys that are authorized for a specific user.
The "Reset User Passwords" Vault permission is required to query public SSH Keys.
The authenticated user who runs the function must be in the same Vault
Location or higher as the user whose public SSH keys are retrieved.
A user cannot manage their own public SSH keys.

.PARAMETER UserName
The username of the Vault user whose public SSH keys will be added
A username cannot contain te follwing charcters: "%", "&", "+" or ".".

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
All parameters can be piped by property name
Accepts pipeline objects from *-PASUser functions

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.PASPublicSSHKey
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
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateScript({$_ -notmatch ".*(%|\&|\+|\.).*"})]
        [string]$UserName,
          
        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$SessionToken,

        [parameter(ValueFromPipelinebyPropertyName=$true)]
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
        $URI = "$BaseURI/PasswordVault/WebServices/PIMServices.svc/Users/$($UserName | 
            
            Get-EscapedString)/AuthenticationMethods/SSHKeyAuthentication/AuthorizedKeys"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $SessionToken -WebSession $WebSession

    }#process

    END{
        
        if($result){

            $result.GetUserAuthorizedKeysResult | 
            
                Add-ObjectDetail -typename psPAS.CyberArk.Vault.PublicSSHKey -PropertyToAdd @{

                    "UserName" = $UserName
                    "sessionToken" = $sessionToken
                    "WebSession" = $WebSession
                    "BaseURI" = $BaseURI

                }

        }
        
    }#end

}