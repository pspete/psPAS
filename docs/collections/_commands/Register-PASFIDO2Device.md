---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Register-PASFIDO2Device
schema: 2.0.0
title: Register-PASFIDO2Device
---

# Register-PASFIDO2Device

## SYNOPSIS
Registers a new FIDO2 device for a user.

## SYNTAX

### Default (Default)
```
Register-PASFIDO2Device [-UserId <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### OwnDevice
```
Register-PASFIDO2Device [-OwnDevice] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Registers a new FIDO2 device, either on behalf of another user (admin flow) or for the
currently logged-in user (self-service flow).

The cmdlet performs the full WebAuthn registration ceremony:

1. Requests `createCredentialOptions` from the CyberArk API.
2. Invokes the Windows WebAuthn API (`webauthn.dll`) to prompt the user to interact with
   their FIDO2 authenticator and produce an attestation.
3. Submits the attestation back to the CyberArk API to complete registration.

Requires Windows 10 1903 or later for the WebAuthn ceremony.

Requires CyberArk version 14.6 or later.

When called without `-OwnDevice`, any user who is a member of the Vault Admins group
can run this web service.

## EXAMPLES

### Example 1
```powershell
PS C:\> Register-PASFIDO2Device -UserId 57
```

Registers a new FIDO2 device for the user whose ID is `57`.
The user running the cmdlet must have the necessary privileges to register devices on
behalf of other users.

### Example 2
```powershell
PS C:\> Register-PASFIDO2Device
```

Registers a new FIDO2 device for the user implied by the current session, using the admin
registration endpoint.

### Example 3
```powershell
PS C:\> Register-PASFIDO2Device -OwnDevice
```

Registers a new FIDO2 device for the user that is currently logged in, using the self-service
registration endpoint.

## PARAMETERS

### -UserId
The ID of the user to register the FIDO2 device for.

If omitted, the device is registered against the user implied by the current session
(admin endpoint).

```yaml
Type: Int32
Parameter Sets: Default
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OwnDevice
When specified, registers the FIDO2 device against the current user via the self-service
endpoint.

```yaml
Type: SwitchParameter
Parameter Sets: OwnDevice
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Register-PASFIDO2Device](https://pspas.pspete.dev/commands/Register-PASFIDO2Device)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/fido2-start-registration.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/fido2-start-registration.htm)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/fido2-register.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/fido2-register.htm)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/fido2-self-start-registration.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/fido2-self-start-registration.htm)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/fido2-selfregister.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/fido2-selfregister.htm)
