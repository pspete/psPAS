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
	Output folder, or full destination file path, for the file.
	If the path's leaf component includes a file extension, it is treated as the exact file to save to;
	otherwise it is treated as an output folder and a suggested filename is appended.
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

	begin { }

	process {

		if (-not ($Path)) {

			#Default to TEMP if path not provided
			$Path = [Environment]::GetEnvironmentVariable('Temp')

		}

		if ([System.IO.Path]::GetExtension($Path)) {

			#Path's leaf component has a file extension - treat as the exact destination file
			$OutputPath = $Path

		} elseif (Test-Path -Path $Path -PathType Container) {

			if ($InputObject.Headers.ContainsKey('Content-Disposition')) {
				#Get filename from Content-Disposition Header element.
				$FileName = ($InputObject.Headers['Content-Disposition'] -split 'filename=')[1] -replace '"'
			}

			#Define output path
			$OutputPath = Join-Path $Path $FileName

		} else {
			$OutputPath = $Path #assume full path provided
		}

		if ($PSCmdlet.ShouldProcess($OutputPath, 'Save File')) {

			try {

				#Command Parameters
				$output = @{
					Path     = $OutputPath
					Value    = $InputObject.Content
					Encoding = 'Byte'
				}

				if (Test-IsCoreCLR) {

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

	end { }

}