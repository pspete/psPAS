function Get-PASSafeMembers{
<#
.SYNOPSIS
Lists the members of a Safe

.DESCRIPTION
Lists the members of a Safe.
View Safe Members permission is required.

.PARAMETER SafeName
The name of the safe to get the members of

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
Accepts pipeline input from *-PASSafe, or any function which 
contains SafeName in the output

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.SafeMember
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
        [ValidateNotNullOrEmpty()]
        [string]$SafeName,

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
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Safes/$($SafeName | 
        
            Get-EscapedString)/Members"
        
        #Send request to webservice
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

    }#process

    END{
    
        #output
        $result.members | Select-Object UserName, Permissions | 
        
            Add-ObjectDetail -typename psPAS.CyberArk.Vault.SafeMember -PropertyToAdd @{

                "SafeName" = $SafeName
                "sessionToken" = $sessionToken
                "WebSession" = $WebSession
                "BaseURI" = $BaseURI

            }
        
    }#end

}