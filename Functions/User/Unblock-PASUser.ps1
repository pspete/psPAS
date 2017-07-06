function Unblock-PASUser{
<#
.SYNOPSIS
Activates a suspended user

.DESCRIPTION
Activates an exisitng vault user who was suspended due to password 
failures.

.PARAMETER UserName
The user's name

.PARAMETER Suspended
Suspension status

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
        [boolean]$Suspended,

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

        #request body
        $body = $PSBoundParameters | 
        
            Get-PASParameters -ParametersToRemove UserName | 
            
                ConvertTo-Json

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result}#end

}