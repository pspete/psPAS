# .ExternalHelp psPAS-help.xml
function Set-PASAccount {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Gen2SingleOp')]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('id')]
		[string]$AccountID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2SingleOp'
		)]
		[ValidateSet('add', 'replace', 'remove')]
		[Alias('Operation')]
		[string]$op,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2SingleOp'
		)]
		[ArgumentCompleter({
				#TO-DO: Consider excluding paths that are read-only, e.g. /id

				#Standard ArgumentCompleter parameters, populated by the completion engine on tab.
				param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

				#Avoid PSScriptAnalyzer PSReviewUnusedParameter rule on standard ArgumentCompleter parameters.
				$null = $commandName, $parameterName

				#Resolve AccountID: supplied directly, or from a preceding 'Get-PASAccount -id <value>' pipeline command.
				#e.g. Set-PASAccount -AccountID 22_3 -op replace -path <tab>
				$AccountID = $fakeBoundParameters['AccountID']

				if (-not $AccountID) {

					#e.g. Get-PASAccount -id 22_3 | Set-PASAccount -path <tab>
					#Find the first Get-PASAccount command in the pipeline being typed & get its command elements.
					$Elements = ($commandAst.Parent.PipelineElements |
							Where-Object { ($_ -is [System.Management.Automation.Language.CommandAst]) -and ($_.GetCommandName() -eq 'Get-PASAccount') } |
							Select-Object -First 1).CommandElements

					#Take the constant value following the -id / -AccountID parameter.
					for ($i = 1; $i -lt $Elements.Count; $i++) {

						#Element must be a literal value preceded by the -id / -AccountID parameter name.
						#StringConstantExpressionAst inherits from ConstantExpressionAst, so quoted, bareword & numeric values are all covered.
						if (($Elements[$i - 1] -is [System.Management.Automation.Language.CommandParameterAst]) -and
							($Elements[$i - 1].ParameterName -in 'id', 'AccountID') -and
							($Elements[$i] -is [System.Management.Automation.Language.ConstantExpressionAst])) {

							$AccountID = $Elements[$i].Value
							break

						}

					}

				}

				#Nothing to complete without a resolved AccountID.
				if (-not $AccountID) { return }

				#Get the account object; no completions if retrieval fails (e.g. no session, unknown ID).
				try { $Account = Get-PASAccount -id $AccountID -ErrorAction Stop } catch { return }

				#Recursively emit '/parent/child' paths for every property on the account object.
				function Get-PASAccountPropertyPath($Object, [string]$Prefix = '') {

					foreach ($Property in $Object.PSObject.Properties) {

						#Only NoteProperties hold account data (recursion ends on values with none, e.g. strings).
						if ($Property.MemberType -eq 'NoteProperty') {

							#Output the JSON Patch style path for this property.
							$Path = "$Prefix/$($Property.Name)"
							$Path

							#Descend into nested objects, e.g. /platformAccountProperties/port
							if ($null -ne $Property.Value) { Get-PASAccountPropertyPath $Property.Value $Path }

						}

					}

				}

				#Offer sorted paths matching any partial input as the completion results.
				Get-PASAccountPropertyPath $Account |
				Sort-Object -Unique |
				Where-Object { $_ -like "$wordToComplete*" } |
				ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }

			})]
		[string]$path,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2SingleOp'
		)]
		[string]$value,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2MultiOp'
		)]
		[hashtable[]]$operations,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$Folder,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[Alias('Name')]
		[string]$AccountName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$DeviceType,

		[Alias('PolicyID')]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$PlatformID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$Address,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$UserName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$GroupName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$GroupPlatformID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false,
			ParameterSetName = 'Gen1'
		)]
		[hashtable]$Properties = @{ },

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ParameterSetName = 'Gen2SingleOp'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ParameterSetName = 'Gen2MultiOp'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true,
			ParameterSetName = 'Gen1'
		)]
		[PSObject]$InputObject
	)

	begin {

	}#begin

	process {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove InputObject, AccountID

		switch ($PSCmdlet.ParameterSetName) {

			{ $PSItem -match 'Gen2' } {

				Assert-VersionRequirement -RequiredVersion 10.4

				#Create URL for Request
				$URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID"

				#Define method for request
				$Method = 'PATCH'

				#Define type of output object
				$Type = 'psPAS.CyberArk.Vault.Account.V10'

				if ($PSCmdlet.ParameterSetName -match 'Gen2MultiOp') {

					$boundParameters = $boundParameters['operations']

				}

				#Do Not Pipe into ConvertTo-JSON.
				#Correct JSON Format is only achieved when the array is not sent along the pipe
				$body = ConvertTo-Json @($boundParameters)

			}

			'Gen1' {

				Assert-VersionRequirement -SelfHosted

				#Create URL for Request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Accounts/$AccountID"

				#Define method for request
				$Method = 'PUT'

				#Define type of output object
				$Type = 'psPAS.CyberArk.Vault.Account'

				if ($PSBoundParameters.ContainsKey('Properties')) {

					#Format "Properties" parameter value.
					#Array of key=value pairs required for JSON convertion
					$boundParameters['Properties'] = [Collections.Generic.List[Object]]@($boundParameters['Properties'].getenumerator() |

							ForEach-Object { $_ })

				}

				if (($InputObject) -and (($InputObject | Get-Member).TypeName -eq 'psPAS.CyberArk.Vault.Account')) {

					#If InputObject is psPAS.CyberArk.Vault.Account
					#*i.e. receiving pipeline from Get-PASAccount

					#Get all existing properties as defined by input object:
					#Process Pipeline input object properties
					$InputObject |

						#exclude properties output by get-pasaccount not applicable to set-pasaccount request
						Select-Object -Property * -ExcludeProperty Name, PolicyID, Safe |

						#get all remaining noteproperties
						Get-Member -MemberType 'NoteProperty' |

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
								[array]$boundParameters['Properties'] += $ExistingProperty.GetEnumerator() | ForEach-Object { $_ }
								#*any existing properties of an account not sent in a "set" request will be cleared on the account.
								#*This ensures correctly formatted request with all existing account properties included
								#*when function is sent data via the pipeline.

							}

						}

				}

				#Create body of request
				$body = @{

					'Accounts' = $boundParameters

					#ensure nodes at all required depths are included in the JSON object
				} | ConvertTo-Json -Depth 3

				break

			}
		}

		if ($PSCmdlet.ShouldProcess($AccountID, 'Update Account Properties')) {

			#send request to PAS web service
			$Result = Invoke-PASRestMethod -Uri $URI -Method $Method -Body $Body

			if ($null -ne $result) {

				switch ($PSCmdlet.ParameterSetName) {

					'Gen1' { $Return = $Result.UpdateAccountResult ; break }

					default { $Return = $Result }

				}

				$Return | Add-ObjectDetail -typename $Type -PropertyToAdd @{

					'AccountID' = $AccountID

				}

			}

		}

	}#process

	end { }#end

}