function Out-PASFile {
	<#
	.SYNOPSIS
	Writes a Byte Array to a file

	.DESCRIPTION
	Takes a Byte Array from a web response and writes it to a file.
	Suggested filename from Content-Disposition Header is used for naming.

	.PARAMETER InputObject
	Content and Header properties from a web response

	.PARAMETER Path
	Output folder for the file.
	Defaults to $ENV:TEMP

	.EXAMPLE
	Out-PASFile -InputObject $result

	#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		$InputObject,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Path
	)

	Begin { }

	Process {

		If (-not ($Path)) {

			#Default to TEMP if path not provided
			$Path = [Environment]::GetEnvironmentVariable('Temp')

		}

		#Get filename from Content-Disposition Header element.
		$FileName = ($InputObject.Headers['Content-Disposition'] -split 'filename=')[1] -replace '"'

		#Define output path
		$OutputPath = Join-Path $Path $FileName

		if ($PSCmdlet.ShouldProcess($OutputPath, 'Save File')) {

			try {

				#Command Parameters
				$output = @{
					Path     = $OutputPath
					Value    = $InputObject.Content
					Encoding = 'Byte'
				}

				If (Test-IsCoreCLR) {

					#amend parameters for splatting if we are in Core
					$output.Add('AsByteStream', $true)
					$output.Remove('Encoding')

				}

				#write file
				Set-Content @output -ErrorAction Stop

				#return file object
				Get-Item -Path $OutputPath

			} catch {

				#throw the error
				$PSCmdlet.ThrowTerminatingError(

					[System.Management.Automation.ErrorRecord]::new(

						"Error Saving $OutputPath",
						$null,
						[System.Management.Automation.ErrorCategory]::NotSpecified,
						$PSItem

					)

				)
			}

		}

	}

	End { }

}