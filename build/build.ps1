#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host 'Build Information:' -ForegroundColor Yellow

#Get current module version from manifest
$ManifestPath = Join-Path "$pwd" $(Join-Path "$env:APPVEYOR_PROJECT_NAME" "$env:APPVEYOR_PROJECT_NAME.psd1")
$CurrentVersion = (Import-PowerShellDataFile $ManifestPath).ModuleVersion

#display module information
Write-Host "ModuleName       : $env:APPVEYOR_PROJECT_NAME"
Write-Host "Build version    : $env:APPVEYOR_BUILD_VERSION"
Write-Host "Manifest version : $CurrentVersion"
Write-Host "Author           : $env:APPVEYOR_REPO_COMMIT_AUTHOR"
Write-Host "Branch           : $env:APPVEYOR_REPO_BRANCH"
Write-Host "Build Folder     : $env:APPVEYOR_BUILD_FOLDER"

If ([System.Version]$($env:APPVEYOR_BUILD_VERSION) -le [System.Version]$CurrentVersion) {

	throw "Build Version Not Greater than Current Version"

}
Else {

	Try {

		#---------------------------------#
		# BuildScript                     #
		#---------------------------------#
		#---------------------------------#
		# Update module manifest          #
		#---------------------------------#
		Write-Host "Updating Manifest Version to $env:APPVEYOR_BUILD_VERSION" -ForegroundColor Cyan

		#Replace version in manifest with build version from appveyor
		((Get-Content $ManifestPath).replace("= '$($currentVersion)'", "= '$($env:APPVEYOR_BUILD_VERSION)'")) | Set-Content $ManifestPath -ErrorAction Stop

		<#-- Package Version Release    --#>
		$Directory = New-Item -ItemType Directory -Path "Release\$($env:APPVEYOR_PROJECT_NAME)\$($env:APPVEYOR_BUILD_VERSION)" -Force -ErrorAction Stop
		$OutputArchive = "$($env:APPVEYOR_PROJECT_NAME)-v$($env:APPVEYOR_BUILD_VERSION).zip"

		$OutputArchive = "$($env:APPVEYOR_PROJECT_NAME)-v$($env:APPVEYOR_BUILD_VERSION).zip"
		$ReleaseSource = $(Resolve-Path .\$env:APPVEYOR_PROJECT_NAME)

		<#-- Create Release Folder  --#>
		$Directory = New-Item -ItemType Directory -Path "..\Release\$($env:APPVEYOR_PROJECT_NAME)\$($env:APPVEYOR_BUILD_VERSION)" -Force -ErrorAction Stop

		<#-- Copy Module Files    --#>
		Copy-Item -Path $ReleaseSource\* -Recurse -Destination $($Directory.Fullname) -Force -ErrorAction Stop


		If ((-not ($ENV:APPVEYOR_PULL_REQUEST_NUMBER)) -and (($ENV:APPVEYOR_REPO_BRANCH -eq 'master') -and ($ENV:APPVEYOR_BUILD_VERSION -ge "1.0.0"))) {

			If (($ENV:sig_key) -and ($ENV:PfxSecure)) {

				Write-Host "Signing Files" -ForegroundColor Cyan

				Try {
					$KeyPath = Join-Path $([System.Environment]::GetEnvironmentVariable("TEMP")) cert.pfx
					[IO.File]::WriteAllBytes($KeyPath, [Convert]::FromBase64String($($env:sig_key)))

					$SecurePW = ConvertTo-SecureString -String $($env:PfxSecure) -Force -AsPlainText
					$Cred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList "UserName", $SecurePW

					$Cert = Get-ChildItem -Path $KeyPath | Import-PfxCertificate -CertStoreLocation "Cert:\CurrentUser\My" -Password $Cred.Password

					$null = Get-ChildItem -Path "$($Directory.Fullname)\*.ps*" -Recurse | Set-AuthenticodeSignature -Certificate $Cert -TimestampServer 'http://timestamp.digicert.com'
					$null = New-FileCatalog -CatalogVersion 2 -CatalogFilePath "$($Directory.Fullname)\$($env:APPVEYOR_PROJECT_NAME).cat" -Path $($Directory.Fullname)
					$null = Set-AuthenticodeSignature -Certificate $Cert -TimestampServer 'http://timestamp.digicert.com' -FilePath "$($Directory.Fullname)\$($env:APPVEYOR_PROJECT_NAME).cat"
				}
				Catch {
					Throw $_
				}
				Finally {

					Get-ChildItem -Path "Cert:\CurrentUser\My" -Recurse -CodeSigningCert | Remove-Item -Force
					Remove-Item -Path $KeyPath -Force
					Remove-Variable -Name SecurePW -Force
					Remove-Variable -Name Cred -Force

				}

			}

		}

		<#-- Create Package    ---#>
		Compress-Archive $Directory -DestinationPath ..\$OutputArchive -ErrorAction Stop

		<#-- Release Artifact   --#>
		Write-Host "Release Artifact  : $OutputArchive"
		Push-AppveyorArtifact ..\$OutputArchive -FileName $OutputArchive -DeploymentName "$env:APPVEYOR_PROJECT_NAME-latest"

	}

	Catch {

		throw $_

	}

}