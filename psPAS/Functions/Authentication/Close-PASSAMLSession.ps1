function Close-PASSAMLSession {
    <#
.SYNOPSIS
Logoff from CyberArk Vault SAML Session.

.DESCRIPTION
Performs Vault Logoff from SAML session and removes the Vault session.

.EXAMPLE
Close-PASSAMLSession

Logs off from the SAML session related to the authorisation token

#>
    [CmdletBinding()]
    param(  )

    BEGIN {

    }#begin

    PROCESS {

        #Construct URL for request
        $URI = "$Script:BaseURI/$Script:PVWAAppName/WebServices/auth/SAML/SAMLAuthenticationService.svc/Logoff"

        $Body = @{} | ConvertTo-Json

        #Send Logon Request
        Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

    }#process

    END {}#end
}