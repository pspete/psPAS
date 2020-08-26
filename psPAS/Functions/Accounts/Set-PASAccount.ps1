# .ExternalHelp psPAS-help.xml
function Set-PASAccount {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "V10SingleOp")]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("id")]
		[string]$AccountID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10SingleOp"
		)]
		[ValidateSet("add", "replace", "remove")]
		[Alias("Operation")]
		[string]$op,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10SingleOp"
		)]
		[string]$path,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10SingleOp"
		)]
		[string]$value,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10MultiOp"
		)]
		[hashtable[]]$operations,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$Folder,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[Alias("Name")]
		[string]$AccountName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$DeviceType,

		[Alias("PolicyID")]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$PlatformID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$Address,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$UserName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$GroupName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V9"
		)]
		[string]$GroupPlatformID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false,
			ParameterSetName = "V9"
		)]
		[hashtable]$Properties = @{ },

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ParameterSetName = "V10SingleOp"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ParameterSetName = "V10MultiOp"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true,
			ParameterSetName = "V9"
		)]
		[PSObject]$InputObject
	)

	BEGIN {

	}#begin

	PROCESS {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove InputObject, AccountID

		switch ($PSCmdlet.ParameterSetName) {

			{ $PSItem -match "V10" } {

				Assert-VersionRequirement -RequiredVersion 10.4

				#Create URL for Request
				$URI = "$Script:BaseURI/api/Accounts/$AccountID"

				#Define method for request
				$Method = "PATCH"

				#Define type of output object
				$Type = "psPAS.CyberArk.Vault.Account.V10"

				if ($PSCmdlet.ParameterSetName -match "V10MultiOp") {

					$boundParameters = $boundParameters["operations"]

				}

				#Do Not Pipe into ConvertTo-JSON.
				#Correct JSON Format is only achieved when the array is not sent along the pipe
				$body = ConvertTo-JSON @($boundParameters)

			}

			"V9" {

				#Create URL for Request
				$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$AccountID"

				#Define method for request
				$Method = "PUT"

				#Define type of output object
				$Type = "psPAS.CyberArk.Vault.Account"

				if ($PSBoundParameters.ContainsKey("Properties")) {

					#Format "Properties" parameter value.
					#Array of key=value pairs required for JSON convertion
					$boundParameters["Properties"] = [Collections.Generic.List[String]]@($boundParameters["Properties"].getenumerator() |

						ForEach-Object { $_ })

				}

				If (($InputObject) -and (($InputObject | Get-Member).TypeName -eq "psPAS.CyberArk.Vault.Account")) {

					#If InputObject is psPAS.CyberArk.Vault.Account
					#*i.e. receiving pipeline from Get-PASAccount

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
						$ExistingProperty = @{ }

						#if property is not bound to function parameter by name,
						if (!(($PSBoundParameters.ContainsKey($($_.Name))) -or (

									#if not being explicitly updated.
									$($Properties).ContainsKey($($_.Name))))) {

							[hashtable]$ExistingProperty.Add($($_.Name), $($InputObject.$($_.Name)))

							#Add to Properties node of request data
							[array]$boundParameters["Properties"] += $ExistingProperty.GetEnumerator() | ForEach-Object { $_ }
							#*any existing properties of an account not sent in a "set" request will be cleared on the account.
							#*This ensures correctly formatted request with all existing account properties included
							#*when function is sent data via the pipeline.

						}

					}

				}

				#Create body of request
				$body = @{

					"Accounts" = $boundParameters

					#ensure nodes at all required depths are included in the JSON object
				} | ConvertTo-Json -Depth 3

				break

			}
		}

		if ($PSCmdlet.ShouldProcess($AccountID, "Update Account Properties")) {

			#send request to PAS web service
			$Result = Invoke-PASRestMethod -Uri $URI -Method $Method -Body $Body -WebSession $Script:WebSession

			If ($null -ne $result) {

				switch ($PSCmdlet.ParameterSetName) {

					"V9" { $Return = $Result.UpdateAccountResult ; break }

					default { $Return = $Result }

				}

				$Return | Add-ObjectDetail -typename $Type -PropertyToAdd @{

					"AccountID" = $AccountID

				}

			}

		}

	}#process

	END { }#end

}