function New-PASSession{
<#
.SYNOPSIS
Authenticates a user to CyberArk Vault.

.DESCRIPTION
Authenticates a user to a CyberArk Vault and returns a token and a webrequest session object
that can be used in subsequent PAS Web Services calls.
Only CyberArk Authenitcation method is supported.

.PARAMETER Credential
A Valid PSCredential object.

.PARAMETER SessionVariable
Defaults to "PASSession". 
After succesfull execution of this function, and authentication to the Vault,a WebSession 
object, that contains information about the connection and the request, including cookies, 
will be created and passed back in the return object.
This can be passed to subsequent requests to ensure websessions are persistant when the 
PAS Web Service exists accross PVWA servers behind a load balancer.

.PARAMETER BaseURI
A string containing the base web address to send te request to.
Pass the portion the PVWA HTTP address. 
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
A PSCredential Object can be piped to this function.

.OUTPUTS
CyberArk Session token; This token identifies the session with the vault, and
is supplied to every other web service request in the same session.
A WebSession object; This contains information about the connection and the request, 
including cookies. Can be supplied to other web servcie requests.
  
.NOTES

.LINK
#>
    [CmdletBinding()]  
    param(  
        [parameter(
            Mandatory=$true,
            ValueFromPipeline=$true
        )]
        [ValidateNotNullOrEmpty()]
        [PSCredential]$Credential,

        [parameter(
            Mandatory=$false
        )]
        [string]$SessionVariable = "PASSession",

        [parameter(
            Mandatory=$true
        )]
        [string]$BaseURI
    )

    BEGIN{
        
        #Construct URL for request
        $URI = "$baseURI/PasswordVault/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logon"
    
    }#begin

    PROCESS{
        
        #Construct Request Body
        $body = @{
                    #Add user name form credential object
                    "username" = $($Credential.UserName)
                    #Add decoded password value from crednetial object
                    "password" = $($Credential.GetNetworkCredential().Password)

                } | ConvertTo-Json
        
        #Send Logon Request
        $PASSession = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -SessionVariable $SessionVariable

        #Return Object
        [pscustomobject]@{
            
            #Authentication Token
            "sessionToken" = @{"Authorization" = $PASSession | 
                
                #Required for all subsequent Web Service Calls
                select -ExpandProperty CyberArkLogonResult}

            #WebSession Object
            "WebSession" = $PASSession | 
            
                select -ExpandProperty WebSession

            #The Web Service URL the request was sent to
            "BaseURI" = $BaseURI

        }

    }#process

    END{}#end
}