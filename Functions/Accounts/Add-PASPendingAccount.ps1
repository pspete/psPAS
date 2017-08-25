function Add-PASPendingAccount {
    <#
.SYNOPSIS
Adds discovered account or SSH key as a pending account in the accounts feed.

.DESCRIPTION
Enables an account or SSH key that is discovered by an external scanner to be added
as a pending account to the Accounts Feed.
Users can identify privileged accounts and determine which are on-boarded to the vault.

.PARAMETER UserName
The name of the account user

.PARAMETER Address
The name or address of the machine where the account is used.

.PARAMETER AccountDiscoveryDate
The date when the account was discovered.
This parameter uses the following standard:
    YYYY-MM-DDThh:mm:ssZ

.PARAMETER OSType
The OS where the password was discovered.
Windows or Unix

.PARAMETER AccountEnabled
The account status in the discovery source.

.PARAMETER AccountOSGroups
The name of the group that the account belongs to

.PARAMETER AccountType
Account Type

.PARAMETER DiscoveryPlatformType
Platform where discovered account is used

.PARAMETER Domain
The domain of the account.

.PARAMETER LastLogonDate
Date, according to discovery source, when the account was last used to logon.

.PARAMETER LastPasswordSet
Date, according to discovery source, when the password for the account was last set

.PARAMETER PasswordNeverExpires
If the password will ever expire in the discovery source

.PARAMETER OSVersion
OS Version where the account was discovered

.PARAMETER OU
OU of the account

.PARAMETER AccountCategory
Whether the discovered account is privileged or non-privileged.

.PARAMETER AccountCategoryCriteria
Criteria that determines whether or not the discovered account is privileged.
For example, the user or groupname, etc.
Separate multiple strings with ";".

.PARAMETER UserDisplayName
User's display name

.PARAMETER AccountDescription
A description of the user, as defined in the discovery source.
This will be saved as an account after it is added to the pending accounts.

.PARAMETER AccountExpirationDate
The account expiration date defined in the discovery source.

.PARAMETER UID
The unique User ID

.PARAMETER GID
The Unique Group ID

.PARAMETER MachineOSFamily
The type of machine where the account was discovered.

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
$token | Add-PASPendingAccount -UserName Administrator -Address ServerA.domain.com -AccountDiscoveryDate 2017-01-01T00:00:00Z `
-AccountEnabled enabled

Adds matching discovered account as pending account.

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None

.NOTES

.LINK

#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$UserName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Address,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateScript( {($_ -match "^((19|20)[0-9][0-9]-(0[0-9]|1[0-2])-(0[1-9]|([12][0-9]|3[01]))T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]Z)$")})]
        [string]$AccountDiscoveryDate,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet("Windows", "Unix")]
        [string]$OSType,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet("enabled", "disabled")]
        [string]$AccountEnabled,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$AccountOSGroups,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet("domain", "local")]
        [string]$AccountType,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$DiscoveryPlatformType,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Domain,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$LastLogonDate,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$LastPasswordSet,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$PasswordNeverExpires,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$OSVersion,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$OU,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet("Privileged", "Non-privileged")]
        [string]$AccountCategory,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$AccountCategoryCriteria,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$UserDisplayName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$AccountDescription,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$AccountExpirationDate,

        [string]$UID,
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$GID,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet("Workstation", "Server")]
        [string]$MachineOSFamily,

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

        #Create URL for Request
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/PendingAccounts"

        #Get all parameters that will be sent in the request
        $boundParameters = $PSBoundParameters | Get-PASParameters

        #Create body of request
        $body = @{

            #pendingaccount node
            "pendingAccount" = $boundParameters | Get-PASParameters

            #JSON object
        } | ConvertTo-Json

        #send request to PAS web service
        Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END {}#end
}