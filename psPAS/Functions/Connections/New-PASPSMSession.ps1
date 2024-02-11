# .ExternalHelp psPAS-help.xml
function New-PASPSMSession {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'PSMConnectPrerequisites', Justification = 'False Positive')]
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PSMConnect'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[string]$userName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[securestring]$secret,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[string]$address,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[string]$platformID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[string]$extraFields,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PSMConnect'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[string]$reason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PSMConnect'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[string]$TicketingSystemName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PSMConnect'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[string]$TicketId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PSMConnect'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[string]$ConnectionComponent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PSMConnect'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[ValidateSet('Yes', 'No')]
		[string]$AllowMappingLocalDrives,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PSMConnect'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[ValidateSet('Yes', 'No')]
		[string]$AllowConnectToConsole,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PSMConnect'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[ValidateSet('Yes', 'No')]
		[string]$RedirectSmartCards,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PSMConnect'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[string]$PSMRemoteMachine,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PSMConnect'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[string]$LogonDomain,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PSMConnect'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[ValidateSet('Yes', 'No')]
		[string]$AllowSelectHTML5,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PSMConnect'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AdHocConnect'
		)]
		[ValidateSet('RDP', 'PSMGW')]
		[string]$ConnectionMethod,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateScript( { Test-Path -Path $_ -IsValid })]
		[string]$Path
	)

	BEGIN {

		$AdHocParameters = [Collections.Generic.List[String]]@('ConnectionComponent', 'reason', 'ticketingSystemName', 'ticketId', 'ConnectionParams')

	}#begin

	PROCESS {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID, ConnectionMethod, Path

		#Nest parameters "AllowMappingLocalDrives", "AllowConnectToConsole","RedirectSmartCards",
		#"PSMRemoteMachine", "LogonDomain" & "AllowSelectHTML5" under ConnectionParams Property
		$boundParameters = $boundParameters | ConvertTo-ConnectionParam

		switch ($PSCmdlet.ParameterSetName) {

			'PSMConnect' {
				Assert-VersionRequirement -RequiredVersion 9.10

				#Create URL for Request
				$URI = "$($psPASSession.BaseURI)/API/Accounts/$($AccountID)/PSMConnect"

				#Create body of request
				$body = $boundParameters | ConvertTo-Json

				$ShouldProcess = $AccountID

				break

			}

			'AdHocConnect' {
				Assert-VersionRequirement -RequiredVersion 10.5

				#Create URL for Request
				$URI = "$($psPASSession.BaseURI)/API/Accounts/AdHocConnect"

				#Include decoded password in request
				$boundParameters['secret'] = $(ConvertTo-InsecureString -SecureString $secret)

				#Connection parameters are included under the PSMConnectPrerequisites property of the JSON body, for each one specified
				$boundParameters.keys | Where-Object { $AdHocParameters -contains $PSItem } | ForEach-Object {

					$PSMConnectPrerequisites = @{ }

				} {

					#add key=value to hashtable
					$PSMConnectPrerequisites.Add($PSItem, $boundParameters[$PSItem] )

				} {
					if ($PSMConnectPrerequisites.keys.count -gt 0) {

						#If PSMConnectPrerequisites have been specified, add PSMConnectPrerequisites to boundParameters
						$boundParameters['PSMConnectPrerequisites'] = $PSMConnectPrerequisites

					}
				}

				#Create body of request
				$body = $boundParameters | Get-PASParameter -ParametersToRemove $AdHocParameters | ConvertTo-Json -Depth 4

				$ShouldProcess = $userName

				break

			}

		}

		$ThisSession = $psPASSession.WebSession

		#if a connection method is specified
		If ($PSBoundParameters.ContainsKey('ConnectionMethod')) {

			#The information needs to passed in the header
			if ($PSBoundParameters['ConnectionMethod'] -eq 'RDP') {

				#RDP accept "application/json" response
				$Accept = 'application/octet-stream'

			} elseif ($PSBoundParameters['ConnectionMethod'] -eq 'PSMGW') {

				Assert-VersionRequirement -RequiredVersion 10.2

				#PSMGW accept * / * response
				$Accept = '* / *'

			}

			#add detail to header
			$ThisSession.Headers['Accept'] = $Accept

		}

		if ($PSCmdlet.ShouldProcess($ShouldProcess, 'New PSM Session')) {

			#send request to PAS web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $body -WebSession $ThisSession

		}

		If ($null -ne $result) {

			If (($result | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name) -contains 'PSMGWRequest') {

				$Path = [System.IO.Path]::GetTempPath()
				$FileName = "$((Get-PASSession).LastCommandResults.Headers['X-Correlation-ID']).html"
				$OutputPath = Join-Path $Path $FileName

				#POST PSMGWRequest Details to HTML5 GW via html form
				$htmlParams = @{
					Title = 'PSMGWRequest'
					Body  = '<form action="' + $result.PSMGWURL + '" method="POST"><input name="PSMGWRequest" type="hidden" value="' + $result.PSMGWRequest + '"></form><script>document.forms[0].submit()</script>'
				}

				ConvertTo-Html @htmlParams | Out-File $OutputPath
				Get-Item -Path $OutputPath | Invoke-Item

			} Else {

				#Save the RDP file to disk and automatically open it to spawn the RDP conenction to PSM
				Out-PASFile -InputObject $result -Path $Path | Invoke-Item

			}

		}

	} #process

	END { }#end

}