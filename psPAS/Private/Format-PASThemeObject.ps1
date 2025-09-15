function Format-PASThemeObject {
    <#
	.SYNOPSIS
	Creates object in the expected format for adding or updating PAS Themes

	.DESCRIPTION
	From a hashtable provided as input, nests key/value pairs under expected key.
	Returns object structured as required to be converted to json and used as payload to create or update PAS theme.
	Designed to be consumed by New-PASTheme & Set-PASTheme.

	.PARAMETER UserProperties
	A hashtable containing the key/values to create or update a PAS Theme

	.EXAMPLE
	$ParameterValues | Format-PASThemeObject
	#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [hashtable]$ThemeProperties
    )

    begin {
        $images = [Collections.Generic.List[String]]@('mainBackgroundImage', 'mainLogoDark', 'advancedSmallLogo', 'advancedSymbolLogo')
        $colors = [Collections.Generic.List[String]]@('colorsStyle')
        $colorDefinitionByType_Dark = [Collections.Generic.List[String]]@('backgroundMain_Dark', 'borderMain_Dark', 'textMain_Dark', 'disableMain_Dark', 'disableTextPrimary_Dark', 'disableBackgroundPrimary_Dark', 'successPrimary_Dark', 'successSecondary_Dark', 'warningPrimary_Dark', 'warningSecondary_Dark', 'infoPrimary_Dark', 'infoSecondary_Dark', 'errorPrimary_Dark', 'errorSecondary_Dark')
        $colorDefinitionByType_Bright = [Collections.Generic.List[String]]@('backgroundMain_Bright', 'borderMain_Bright', 'textMain_Bright', 'disableMain_Bright', 'disableTextPrimary_Bright', 'disableBackgroundPrimary_Bright', 'successPrimary_Bright', 'successSecondary_Bright', 'warningPrimary_Bright', 'warningSecondary_Bright', 'infoPrimary_Bright', 'infoSecondary_Bright', 'errorPrimary_Bright', 'errorSecondary_Bright')
        $main = [Collections.Generic.List[String]]@('mainColor', 'selectedMain', 'hoverMain', 'defaultButtonTextPrimary')
        $menu = [Collections.Generic.List[String]]@('menuLogoBackground', 'menuBackground', 'menuHoverBackground', 'menuActiveBackgroundPrimary', 'menuActiveBackgroundSecondary', 'menuText', 'menuTextActive', 'menuIcon')
        $advanced = [Collections.Generic.List[String]]@('backgroundMain', 'borderMain', 'textMain')

        $theme = [ordered]@{
            name    = ''
            isDraft = ''
            images  = [ordered]@{
                main = [ordered]@{
                    mainBackgroundImage = ''
                    mainLogoDark        = ''
                    advancedSmallLogo   = ''
                    advancedSymbolLogo  = ''
                }
            }
            colors  = [ordered]@{
                colorsStyle      = ''
                definitionByType = [ordered]@{
                    dark   = [ordered]@{
                        backgroundMain           = ''
                        borderMain               = ''
                        textMain                 = ''
                        disableMain              = ''
                        disableTextPrimary       = ''
                        disableBackgroundPrimary = ''
                        successPrimary           = ''
                        successSecondary         = ''
                        warningPrimary           = ''
                        warningSecondary         = ''
                        infoPrimary              = ''
                        infoSecondary            = ''
                        errorPrimary             = ''
                        errorSecondary           = ''
                    }
                    bright = [ordered]@{
                        backgroundMain           = ''
                        borderMain               = ''
                        textMain                 = ''
                        disableMain              = ''
                        disableTextPrimary       = ''
                        disableBackgroundPrimary = ''
                        successPrimary           = ''
                        successSecondary         = ''
                        warningPrimary           = ''
                        warningSecondary         = ''
                        infoPrimary              = ''
                        infoSecondary            = ''
                        errorPrimary             = ''
                        errorSecondary           = ''
                    }
                }
                main             = [ordered]@{
                    mainColor                = ''
                    selectedMain             = ''
                    hoverMain                = ''
                    defaultButtonTextPrimary = ''
                }
                menu             = [ordered]@{
                    menuLogoBackground            = ''
                    menuBackground                = ''
                    menuHoverBackground           = ''
                    menuActiveBackgroundPrimary   = ''
                    menuActiveBackgroundSecondary = ''
                    menuText                      = ''
                    menuTextActive                = ''
                    menuIcon                      = ''
                }
                advanced         = [ordered]@{
                    backgroundMain = ''
                    borderMain     = ''
                    textMain       = ''
                }
            }
        }


    }

    process {

        #Process each key of the input hashtable
        #Populate the output hashtable
        switch ($ThemeProperties.keys) {

            { $images -contains $PSItem } {
                $theme['images']['main'][$PSitem] = $ThemeProperties[$PSItem]
            }

            { $colors -contains $PSItem } {
                $theme['colors'][$PSitem] = $ThemeProperties[$PSItem]
            }

            { $colorDefinitionByType_Dark -contains $PSItem } {
                $theme['colors']['definitionByType']['dark'][$($PSItem -replace '_Dark', '')] = $ThemeProperties[$PSItem]
            }

            { $colorDefinitionByType_Bright -contains $PSItem } {
                $theme['colors']['definitionByType']['bright'][$($PSItem -replace '_Bright', '')] = $ThemeProperties[$PSItem]
            }

            { $main -contains $PSItem } {
                $theme['colors']['main'][$PSitem] = $ThemeProperties[$PSItem]
            }

            { $menu -contains $PSItem } {
                $theme['colors']['menu'][$PSitem] = $ThemeProperties[$PSItem]
            }

            { $advanced -contains $PSItem } {
                $theme['colors']['advanced'][$PSitem] = $ThemeProperties[$PSItem]
            }

            default {
                $theme[$PSItem] = $ThemeProperties[$PSItem]
            }

        }

    }

    end {
        $theme
    }

}