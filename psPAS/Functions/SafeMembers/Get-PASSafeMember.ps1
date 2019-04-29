function Get-PASSafeMember {
	<#
.SYNOPSIS
Lists the members of a Safe

.DESCRIPTION
Lists the members of a Safe.
View Safe Members permission is required.

If a Safe Member Name is provided, the full permissions of the member on the Safe will be returned.
Includes AccessWithoutConfirmation, InitiateCPMAccountManagementOperations, RequestsAuthorizationLevel &
SpecifyNextAccountContent which are not included when querying by safe only.

.PARAMETER SafeName
The name of the safe to get the members of

.PARAMETER MemberName
Specify the name of a safe member to return their safe permissions in full.
You cannot report on the permissions of the user authenticated to the API.

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

.PARAMETER ExternalVersion
The External CyberArk Version, returned automatically from the New-PASSession function from version 9.7 onwards.

.EXAMPLE
$token | Get-PASSafeMember -SafeName Target_Safe

Lists all members with permissions on Target_Safe

.EXAMPLE
$token | Get-PASSafeMember -SafeName Target_Safe -MemberName SomeUser

Lists all permissions for member SomeUser on Target_Safe

.INPUTS
All parameters can be piped by property name
Accepts pipeline input from *-PASSafe, or any function which
contains SafeName in the output

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Safe.Member
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK
#>
	[Alias("Get-PASSafeMembers")]
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$SafeName,

		[Alias("UserName")]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "MemberPermissions"
		)]
		[ValidateNotNullOrEmpty()]
		[string]$MemberName,

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
		[string]$PVWAAppName = "PasswordVault",

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[System.Version]$ExternalVersion = "0.0"

	)

	BEGIN {

		$Method = "GET"
		$Request = @{ }

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Safes/$($SafeName |

            Get-EscapedString)/Members"

		#Get full permissions for specific user on safe
		if ($PSCmdlet.ParameterSetName -eq "MemberPermissions") {

			#Create URL for member specific request
			$URI = "$URI/$($MemberName | Get-EscapedString)"
			#Send a PUT Request instead of GET
			$Method = "PUT"
			#Send an empty body
			#Add to Request parameters for PUT Request
			$Request["Body"] = @{"member" = @{ } } | ConvertTo-Json

		}

		#Build Request Parameters
		$Request["URI"] = $URI
		$Request["Method"] = $Method
		$Request["Headers"] = $sessionToken
		$Request["WebSession"] = $WebSession

		#Send request to webservice
		$result = Invoke-PASRestMethod @Request

		if ($result) {

			if ($PSCmdlet.ParameterSetName -eq "MemberPermissions") {

				#format output
				$Output = $result.member | Select-Object MembershipExpirationDate,

				@{Name = "UserName"; "Expression" = {

						$MemberName }

				},

				@{Name = "Permissions"; "Expression" = {

						$_.Permissions | Where-Object { $_.value } | Select-Object -ExpandProperty key }

				}

			}

			Else {

				#output
				$Output = $result.members | Select-Object UserName, @{Name = "Permissions"; "Expression" = {

						($_.Permissions).psobject.properties | Where-Object { $_.Value -eq $true } |

						Select-Object -ExpandProperty Name }

				}

			}

			$Output | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe.Member -PropertyToAdd @{

				"SafeName"        = $SafeName
				"sessionToken"    = $sessionToken
				"WebSession"      = $WebSession
				"BaseURI"         = $BaseURI
				"PVWAAppName"     = $PVWAAppName
				"ExternalVersion" = $ExternalVersion

			}

		}

	}#process

	END { }#end

}
