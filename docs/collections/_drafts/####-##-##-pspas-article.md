---
title:  "Title"
date:   2022-01-21 00:00:00
tags:
  - pspAS Article
---

Title New-PASSession
participant New-PASSession
participant Invoke-PASRestMethod
participant Invoke-WebRequest
participant Get-PASResponse
participant ConvertFrom-Json
//group CyberArk/LDAP
box over New-PASSession:Username/Password
New-PASSession->Invoke-PASRestMethod:Authentication Request
Invoke-PASRestMethod->Invoke-WebRequest:API Request
Invoke-WebRequest->Invoke-PASRestMethod:API Response
box over Invoke-PASRestMethod:Error Handling
Invoke-PASRestMethod->Get-PASResponse:Response Value
Get-PASResponse->ConvertFrom-Json:JSON
Get-PASResponse<-ConvertFrom-Json:PowerShell Object
Invoke-PASRestMethod<-Get-PASResponse:Response Data
New-PASSession<-Invoke-PASRestMethod:Logon Result
rbox over New-PASSession:Script Scope variables:\n- Authorization Header\n- WebSession\n- Base URL\n- CyberArk version
//end

Title RADIUS
participant New-PASSession
participant Send-RADIUSResponse
participant Invoke-PASRestMethod
box over New-PASSession:Username/Password
New-PASSession->Invoke-PASRestMethod:Authentication Request
box over Invoke-PASRestMethod:Error Handling
New-PASSession<-Invoke-PASRestMethod:RADIUS Challenge
box over New-PASSession:OTP
New-PASSession->Send-RADIUSResponse:RADIUS Response
loop ITATS542I
Send-RADIUSResponse->Invoke-PASRestMethod:Response
Send-RADIUSResponse<-Invoke-PASRestMethod:Challenge
end
New-PASSession<-Invoke-PASRestMethod:Authorization Token



Title IIS + Vault Auth
participant New-PASSession
participant Invoke-PASRestMethod
box over New-PASSession:Username/Password\nCertificate\nDefault Credentials
New-PASSession->Invoke-PASRestMethod:Authentication Request
abox right of Invoke-PASRestMethod:IIS Authentication
New-PASSession<-Invoke-PASRestMethod:Response
New-PASSession->Invoke-PASRestMethod:Authentication Request
abox right of Invoke-PASRestMethod:API Authentication
New-PASSession<-Invoke-PASRestMethod:Authorization Token


Title SAML Authentication
participant New-PASSession
participant Invoke-PASRestMethod
participant Get-PASSAMLResponse
participant Invoke-WebRequest
//group CyberArk/LDAP
group SAML Auth
entryspacing 0.9
group #2f2e7b IWA SSO #white
New-PASSession->Get-PASSAMLResponse:Initiate authentication
Get-PASSAMLResponse->Invoke-WebRequest:/auth/saml GET Request
Get-PASSAMLResponse<-Invoke-WebRequest:IDP SSO URL
box over Get-PASSAMLResponse:DefaultCredentials
Get-PASSAMLResponse->Invoke-WebRequest:Auth Request
Invoke-WebRequest-->Invoke-WebRequest:Redirection
Get-PASSAMLResponse<-Invoke-WebRequest:IDP Response
New-PASSession<-Get-PASSAMLResponse:SAMLReponse
end
box over New-PASSession:SAMLResponse
New-PASSession->Invoke-PASRestMethod:Authentication Request
box over Invoke-PASRestMethod:Error Handling
New-PASSession<-Invoke-PASRestMethod:Authorization Token
end
//end