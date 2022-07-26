Function ConvertTo-ConnectionParam {
	<#
.SYNOPSIS
Converts input parameters to correct format for PAS ConnectionParams

.DESCRIPTION
ConnectionParams consist of "AllowMappingLocalDrives", "AllowConnectToConsole",
"RedirectSmartCards", "PSMRemoteMachine", "LogonDomain" & "AllowSelectHTML5" properties.
If these exist as keys in the input parameters, they are added to the input parameters
as nested hashtable key/value pairs, the top level key/value pairs are not included in the output.

.PARAMETER Parameters
Hashtable containing parameter names and values.

.EXAMPLE
$InputObj = @{
				PSMRemoteMachine = "RemoteMachineValue"
				LogonDomain      = "LogonDomainValue"
				SomeProperty     = "SomeValue"
			}
$InputObj | ConvertTo-ConnectionParam

Outputs:
$output["ConnectionParams"]["PSMRemoteMachine"]["Value"] = RemoteMachineValue
$output["ConnectionParams"]["LogonDomain"]["Value"] = LogonDomainValue
$output["SomeProperty"] = SomeValue

#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'ConnectionParams', Justification = 'False Positive')]
	[CmdletBinding()]
	[OutputType('System.Hashtable')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[hashtable]$Parameters
	)

	Begin {
		$ConnectionParameters = [Collections.Generic.List[String]]@('AllowMappingLocalDrives', 'AllowConnectToConsole',
			'RedirectSmartCards', 'PSMRemoteMachine', 'LogonDomain', 'AllowSelectHTML5')
	}

	Process {

		If ($null -ne $Parameters) {

			#ConnectionParameters are included under the ConnectionParams property of the JSON body
			$Parameters.keys | Where-Object { $ConnectionParameters -contains $PSItem } | ForEach-Object {

				$ConnectionParams = @{ }

			} {

				#For Each ConnectionParams Parameter
				#add key=value to hashtable
				$ConnectionParams.Add($PSItem, @{'value' = $Parameters[$PSItem] })

			} {
				if ($ConnectionParams.keys.count -gt 0) {

					#if ConnectionParameters have been specified
					#Add ConnectionParams to boundParameters
					$Parameters['ConnectionParams'] = $ConnectionParams

				}

				#Remove individual ConnectionParameters from boundParameters
				$Parameters | Get-PASParameter -ParametersToRemove $ConnectionParameters

			}

		}

	}

	End { }

}