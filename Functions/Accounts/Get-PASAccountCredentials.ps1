function Get-PASAccountCredentials{
<#
.SYNOPSIS
Returns password for an account.

.DESCRIPTION
Returns password for an account identified by its AccountID.
Will not return SSH Keys.
Cannot be used if a reson for password access must be specified.

.PARAMETER AccountID
The ID of the account whose password will be retrieved.

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
Accepts pipeline input from other Get-PASAccount

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Credential
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

        #Create request URL
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Accounts/$($AccountID | 
        
            Get-EscapedString)/Credentials"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession
        
    }#process

    END{
        
        If($result){

            [PSCustomObject] @{"Password" = $result} | 
               
                Add-ObjectDetail -typename psPAS.CyberArk.Vault.Credential -PropertyToAdd @{

                    "sessionToken" = $sessionToken
                    "WebSession" = $WebSession
                    "BaseURI" = $BaseURI

                }

        }
        
    }#end

}