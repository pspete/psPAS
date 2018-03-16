#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repo Root folder
$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

if( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$ManifestPath" -Force -ErrorAction Stop

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		It "throws if DPDictionary is not expected type" {
			{$Dictionary = New-Object psobject
				New-DynamicParam -Name AlwaysParam -ValidateSet @( gwmi win32_volume |
						% {$_.driveletter} | sort ) -DPDictionary $Dictionary} |should throw
		}

		$testParam = New-DynamicParam -Name SomeParam -Type String -Alias SomeAlias -ValidateSet "Some,Set" `
			-Mandatory $true -ParameterSetName SomeSet -Position 1 -ValueFromPipelineByPropertyName $true `
			-HelpMessage "Some Message" -DPDictionary $false

		it "outputs parameter with expected name" {
			$testParam["SomeParam"].Name | Should Be SomeParam
		}

		it "outputs parameter with expected type" {
			$testParam["SomeParam"].ParameterType.Name | Should Be String
		}
		it "outputs parameter with expected alias" {
			$testParam["SomeParam"].Attributes.AliasNames | Should Be SomeAlias
		}
		it "outputs parameter with expected ValidateSet declaration" {
			$testParam["SomeParam"].Attributes.ValidValues | Should Be "Some,Set"
		}
		it "outputs parameter with expected Mandatory declaration" {
			$testParam["SomeParam"].Attributes.Mandatory | Should Be $true
		}
		it "outputs parameter with expected ParameterSetName declaration" {
			$testParam["SomeParam"].Attributes.ParameterSetName | Should Be SomeSet
		}
		it "outputs parameter with expected position" {
			$testParam["SomeParam"].Attributes.Position | Should Be 1
		}
		it "outputs parameter with expected ValueFromPipelineByPropertyName declaration" {
			$testParam["SomeParam"].Attributes.ValueFromPipelineByPropertyName | Should Be $true
		}
		it "outputs parameter with expected HelpMessage" {
			$testParam["SomeParam"].Attributes.HelpMessage | Should Be "Some Message"
		}

		it "outputs parameter to existing Dictionary Object" {
			$Dictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
			$testParam = New-DynamicParam -Name SomeParam -Type String -Alias SomeAlias -ValidateSet "Some,Set" `
				-Mandatory $true -ParameterSetName SomeSet -Position 1 -ValueFromPipelineByPropertyName $true `
				-HelpMessage "Some Message" -DPDictionary $Dictionary

			$Dictionary["SomeParam"] | Should Not BeNullOrEmpty

		}
	}

}