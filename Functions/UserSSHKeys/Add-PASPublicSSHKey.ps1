function Add-PASPublicSSHKey{
<#
.SYNOPSIS
Adds an authorised public SSH key foraspecific user in the Vault.
 
.DESCRIPTION
Adding an authorised public SSH key to a vault user allows the user 
to authenticate to the Vault through PSMP using a corresponding private SSH key.

The "Reset User Passwords" Permission is required in the vault to manage public SSH keys.
The user account used to add the key MUST be in the same Vault Location or higher
then the user whose public SSH keys are added.
A user cannot manage their own public SSH keys.

.PARAMETER UserName
The username of the Vault user whose public SSH keys will be added
A username cannot contain te follwing charcters: "%", "&", "+" or ".".

.PARAMETER PublicSSHKey
The content of the public SSH key as it appears in the authorized_keys file.
The key must not include new lines ('\n').
Do not include options such as "command", as they are not supported when 
authenticating through PSMP.
This key can only include comments in English.

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
SessionToken, UserName, WebSession & BaseURI can be piped to the 
function by propertyname

.OUTPUTS
TODO

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
            Mandatory=$true
        )]
        [ValidateScript({$_ -notmatch "`n"})]
        [string]$PublicSSHKey,
          
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

        #Create URL to endpoint for request
        $URI = "$BaseURI/PasswordVault/WebServices/PIMServices.svc/Users/$($UserName | 
            
            Get-EscapedString)/AuthenticationMethods/SSHKeyAuthentication/AuthorizedKeys"
        
        #create request body
        $Body = @{

            "PublicSSHKey" = $PublicSSHKey

        } | ConvertTo-Json

        #send request to webservice
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $SessionToken -WebSession $WebSession

    }#process

    END{$result.AddUserAuthorizedKeyResult}#end
}