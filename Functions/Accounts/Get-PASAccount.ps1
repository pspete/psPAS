function Get-PASAccount {
    <#
.SYNOPSIS
Returns information about an account.

.DESCRIPTION
Returns information about an account. If more than one account meets the search criteria,
only the first account will be returned (the Count output parameter will display the number
of accounts that were found).
Only the following users can access this account:
    - Users who are members of the Safe where the account is stored
    - Users who have access to this specific account.
    - The user who runs this web service requires the following permission in the Safe:
    - Retrieve account
This method does not display the actual password.
If ten or more accounts are found, the Count Output parameter will show 10.

.PARAMETER Keywords
Keyword to search for.
If multiple keywords are specified, the search will include all the keywords.
Separate keywords with a space.

.PARAMETER Safe
The name of a Safe to search. The search will be carried out only in the Safes in the Vault
that the authenticated used is authorized to access.

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
$token | Get-PASAccount -Keywords root -Safe UNIX

Finds account(s) matching keywords in UNIX safe:

AccountID  : 19_6
Safe       : UNIX
Folder     : Root
Name       : UNIXSSH-machine-root
UserName   : root
PlatformID : UNIXSSH
DeviceType : Operating System
Address    : machine

.EXAMPLE
$token | Get-PASAccount -Keywords xtest

Finds accounts matching the specified keyword.
Only the first matching account will be returned.
If multiple accounts are found, a warning will be displayed before the result:

WARNING: 3 matching accounts found. Only the first result will be returned

AccountID  : 19_9
Safe       : TestSafe
Folder     : Root
Name       : Application-Cyberark-10.10.10.20-xTest3
UserName   : xTest3
PlatformID : Cyberark
DeviceType : Application
Address    : 10.10.10.20

.INPUTS
All parameters can be piped by property name
Should accept pipeline objects from other *-PASAccount functions

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Account
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.
AccountID, Account Safe, Safe Folder, Account Name,
and any other set property of the account are contained in output.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
.LINK
#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(0, 500)]
        [string]$Keywords,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(0, 28)]
        [string]$Safe,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$sessionToken,

        [parameter(ValueFromPipelinebyPropertyName = $true)]
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

        #Get Parameters to include in request
        $boundParameters = $PSBoundParameters | Get-PASParameters

        #Create Query String, escaped for inclusion in request URL
        $query = ($boundParameters.keys | ForEach-Object {

                "$_=$($boundParameters[$_] | Get-EscapedString)"

            }) -join '&'

        #Create request URL
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Accounts?$query"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

        #Get count of accounts found
        $count = $($result.count)

        Write-Verbose "Accounts Found: $count"

        #If accounts found
        if($count -gt 0) {

            #If multiple accounts found
            if($count -gt 1) {

                #Alert that web service only displays information on first result
                Write-Warning "$count matching accounts found. Only the first result will be returned"

            }

            #Get account details from search result
            $account = ($result | Select-Object accounts).accounts

            #Get account properties from found account
            $properties = ($account | Select-Object -ExpandProperty properties)

            #Create output object
            $return = New-object -TypeName psobject -Property @{

                #Internal Unique ID of Account
                "AccountID" = $($account | Select-Object -ExpandProperty AccountID)

                #Number of accounts found by query
                #"Count" = $count

            }

            #For every account property
            For($int = 0; $int -lt $properties.length; $int++) {

                $return |

                #Add each property name and value to results
                Add-ObjectDetail -PropertyToAdd @{$properties[$int].key = $properties[$int].value} -Passthru $false

            }

        }

    }#process

    END {

        if($return) {

            #Return Results
            $return | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account -PropertyToAdd @{

                "sessionToken" = $sessionToken
                "WebSession" = $WebSession
                "BaseURI" = $BaseURI
                "PVWAAppName" = $PVWAAppName

            }

        }

    }#end

}