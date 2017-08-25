function Set-PASAccount {
    <#
.SYNOPSIS
Updates an existing accounts details.

.DESCRIPTION
Updates an existing accounts details.
All of the account’s property details MUST be passed to the function.
Any current properties of the account not sent as part of the request will be removed
from the account.
To change a property value not exposed via a named parameter,
pass the property name and updated value to the function via the Properties parameter.
If changing the name or folder of a service account that has multiple dependencies (usages),
the connection between it and its dependencies will be automatically maintained.
If changing the name or folder of an account that is linked to another account (whether logon,
reconciliation or verification), the links will be automatically updated.

.PARAMETER AccountID
The unique ID of the account to update.
Retrieved by Get-PASAccount

.PARAMETER Folder
The folder where the account is stored.

.PARAMETER AccountName
The name of the account

.PARAMETER DeviceType
The devicetype assigned to the account.
Ensure all required parameters are specified.
Different device types require different parameters

.PARAMETER PlatformID
The CyberArk platform assigned to the account
Ensure all required parameters are specified.
Different platforms require different parameters

.PARAMETER Address
The Name or Address of the machine where the account will be used

.PARAMETER Username
The Username on the target machine

.PARAMETER GroupName
A groupname with which the account will be associated
The name of the group with which the account is associated.
To create a new group, specify the group platform ID in the GroupPlatformID property,
then specify the group name. The group will then be created automatically.

.PARAMETER GroupPlatformID
GroupPlatformID is required if account is to be moved to a new group.

.PARAMETER Properties
Hashtable of name=value pairs.
Specify properties to update.

.PARAMETER InputObject
Receives object from pipeline.

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
$token | Get-PASAccount dbuser | Set-PASAccount -Properties @{"DSN"="myDSN"}

Sets DSN value on matched account dbUser

.EXAMPLE
 $token | Set-PASAccount -AccountID 21_3 -Folder Root -AccountName NewName `
 -DeviceType Database -PlatformID Oracle -Address dbServer.domain.com -UserName dbuser

 Will set the AccountName of account with AccountID of 21_3 to "NewName".
 **Any/All additional properties of the account which are not specified via parameters will be cleared**

.INPUTS
All parameters, except "Properties", can be piped by property name.
Accepts pipeline object from Get-PASAccount functions.
When an object is piped into this function, properties which are
set on the account are automatically included in the request.
If run without pipeline input, all existing properties of the account
must be specified in the request, otherwise, any property values not
specified will be removed from the account.

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Account
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Dependencies (usages) cannot be updated.
Accounts that do not have a policy ID cannot be updated.

To update account properties, "Update password properties" permission is required.
To rename accounts, "Rename accounts" permission is required.
To move accounts to a different folder, Move accounts/folders permission is required.

.LINK

#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AccountID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Folder,

        [Alias("Name")]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$AccountName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$DeviceType,

        [Alias("PolicyID")]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$PlatformID,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Address,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$UserName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$GroupName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$GroupPlatformID,

        [parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $false
        )]
        [hashtable]$Properties = @{},

        [parameter(
            Mandatory = $false,
            ValueFromPipeline = $true
        )]
        [psobject]$InputObject,

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
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Accounts/$AccountID"

        #Get all parameters that will be sent in the request
        $boundParameters = $PSBoundParameters | Get-PASParameters -ParametersToRemove InputObject

        if($PSBoundParameters.ContainsKey("Properties")) {

            #Format "Properties" parameter value.
            #Array of key=value pairs required for JSON convertion
            $boundParameters["Properties"] = @($boundParameters["Properties"].getenumerator() |

                ForEach-Object {$_})

        }

        #If InputObject is psPAS.CyberArk.Vault.Account
        #i.e. receiving pipeline from Get-PASAccount
        If(($InputObject | Get-Member).TypeName -eq "psPAS.CyberArk.Vault.Account") {

            Write-Verbose "Processing psPAS.CyberArk.Vault.Account Properties"

            #Get all existing properties as defined by input object:
            #Process Pipeline input object properties
            $InputObject |

            #exclude properties output by get-pasaccount not applicable to set-pasaccount request
            Select-Object -Property * -ExcludeProperty Name, PolicyID, Safe |

            #get all remaining noteproperties
            Get-Member -MemberType "NoteProperty" |

            #For each property
            ForEach-Object {

                #Initialise hashtable
                $ExistingProperty = @{}

                #if property is not bound to function parameter by name,
                if(!(($PSBoundParameters.ContainsKey($($_.Name))) -or (

                            #if not being explicitly updated.
                            $($Properties).ContainsKey($($_.Name))))) {

                    Write-Debug "Adding $($_.Name) = $($InputObject.$($_.Name)) as Account Property"
                    [hashtable]$ExistingProperty.Add($($_.Name), $($InputObject.$($_.Name)))

                    #Add to Properties node of request data
                    [array]$boundParameters["Properties"] += $ExistingProperty.GetEnumerator() | ForEach-Object {$_}
                    #any existing properties of an account not sent in a "set" request will be cleared on the account.
                    #This ensures correctly formatted request with all existing account properties included
                    #when function is sent data via the pipeline.

                }

            }

        }

        #Create body of request
        $body = @{

            "Accounts" = $boundParameters

            #ensure nodes at all required depths are included in the JSON object
        } | ConvertTo-Json -Depth 3

        #send request to PAS web service
        $Result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END {

        If($Result) {

            $Result.UpdateAccountResult | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account -PropertyToAdd @{

                "AccountID"    = $AccountID
                "sessionToken" = $sessionToken
                "WebSession"   = $WebSession
                "BaseURI"      = $BaseURI
                "PVWAAppName"  = $PVWAAppName

            }

        }

    }#end

}