# .ExternalHelp psPAS-help.xml
function Get-PASDirectoryID {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('DomainName')]
		[ArgumentCompleter({
				#Standard ArgumentCompleter parameters.
				param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

				#Avoid PSScriptAnalyzer PSReviewUnusedParameter rule on standard ArgumentCompleter parameters.
				$null = $parameterName, $commandAst, $fakeBoundParameters

				#strip any quote the user has already started typing
				$wordToComplete = $wordToComplete.Trim("'`"")

				#ask the API for the available directories
				try {

					$Module = (Get-Command $commandName -ErrorAction Stop).Module
					$Directories = & $Module { Get-PASDirectoryID -ErrorAction Stop }

				} catch { return }

				$Directories.Name |
					Where-Object { $_ -and ($_ -like "$wordToComplete*") } |
					ForEach-Object {

						#directory names can contain spaces/colons, quote the completion text so it remains a single argument
						[System.Management.Automation.CompletionResult]::new("'$($_ -replace "'", "''")'", $_, 'ParameterValue', $_)

					}

			})]
		[string]$Name
	)

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/settings/AddSafeMember"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$Directories = $result.Directories

			if ($PSBoundParameters.ContainsKey('Name')) {

				#filter returned directories by name
				$Directories = $Directories | Where-Object { $PSItem.Name -like $Name }

			}

			$Directories | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe.Member.Directory

		}

	}#process

	end { }#end

}
