function Close-PASSharedSession {
    <#
.SYNOPSIS
Logoff from CyberArk Vault shared user.

.DESCRIPTION
Performs Logoff and removes the Vault session.

.EXAMPLE
Close-PASSharedSession

Logs off from the session related to the authorisation token.

#>
    [CmdletBinding()]
    param(  )

    BEGIN {

    }#begin

    PROCESS {

        #Construct URL for request
        $URI = "$Script:BaseURI/$Script:PVWAAppName/WebServices/auth/Shared/RestfulAuthenticationService.svc/Logoff"

        #Send Logon Request
        Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $WebSession

    }#process

    END {}#end
}