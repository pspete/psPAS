---
title:  "New-PASSession Deep Dive"
date:   2022-10-10 00:00:00
tags:
  - psPAS Article
  - New-PASSession
  - Deep Dive
  - Invoke-PASRestMethod
  - Invoke-WebRequest
  - Get-PASResponse
  - ConvertFrom-Json
  - ITATS542I
  - Send-RADIUSResponse
  - SAMLResponse
  - Get-PASSAMLResponse
  - PS-SAML-Interactive
---

Collating some "Deep Dive" content here shedding light on the inner workings of psPAS, starting with **`New-PASSession`**, the most important command in psPAS and the first command explored and developed for the module way back in 2017.

_What makes the **`New-PASSession`** command so important?_

Each and every time any psPAS user needs to use the module to access the API of their CyberArk solution, **`New-PASSession`** is the first command they will run, making it by far the most crucial code in the whole module, as well being as one of the most viewed commands in the module documentation, and on the psPAS GitHub repo.

As the aim is for **`New-PASSession`** to be compatible with all supported API authentication methods, it is also one of the most complex functions in the entire module.

If you want an understanding of what is going on behind the scenes of the command, this is the right place.

## New-PASSession Internals

The invocation flow of New-PASSession to API authentication looks like this (as does any standard psPAS code flow):

![alt]({{ site.url }}{{ site.baseurl }}/assets/images/New-PASSession/CodeFlow.png){: .half .align-center}

Here, you can see the various abstraction layers that psPAS employs to execute the authentication request with the API, convert the API response into a PowerShell object, and then return the authentication request's result.

- **`New-PASSession`**
  - The front-end command for all API authentication methods supported by psPAS.
  - Formats the API URL into the correct format for this and future request.
    - The URL value provided to **`New-PASSession`** is used for any other **`psPAS`** commands issued in a session.
  - Constructs the overall request, setting required values for the chosen authentication type.
  - Issues requests to the API, or other functions to complete authentication requirements for the chosen method.
  - Extracts the Authorization token value from the LogonResult returned from the API.
  - Sets Script/Module Scope Variables for use by all other module commands:
    - BaseURI.
    - WebSession 'Authorization' header.
    - API Version.
- **`Invoke-PASRestMethod`**
  - Receives all psPAS function requests for the API, including **`New-PASSession`** requests.
  - Enforces module defaults, such as the expected ContentType & use of TLS 1.2.
  - Catches and throws any errors that **`Invoke-WebRequest`** produces.
  - Assigns the **`SessionVariable`** **`WebSession`** object to a script/module scope variable, this is particularly pertinent to **`New-PASSession`**.
- **`Invoke-WebRequest`**
  - Is responsible for receiving requests from **`Invoke-PASRestMethod`** and sending them to the API.
  - The **`Invoke-WebRequest`** cmdlet, included in PowerShell since version 3, sends HTTP and HTTPS requests to a web page or web service.
  - You can read all about it in the [Microsoft Docs](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.2).
- **`Get-PASResponse`**
  - Receives and returns the `Content` property of the API response sent from **`Invoke-PASRestMethod`**
  - Returns data based on the `Content-Type` of the received content.
- **`ConvertFrom-Json`**
  - Creates a custom object from a JSON-formatted string.
  - You can read all about it in the [Microsoft Docs](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/ConvertFrom-Json?view=powershell-7.2)
  - **`application/json`** content is expected for most API responses, **`psPAS`** converts this into a custom object before returning the data.

If everything goes according to plan, we will have a login token from the API at the end of the procedure.

In addition to saving the API URL and API version information, **`New-PASSession`** also conveniently stores the login token as a header value in a WebSession object variable in the script scope of the module.

As all of these values are saved in the module's script scope, they are now available to, and able to be referenced by, all other module functions without the values being exposed to, or provided by, module users for ongoing module operations.

All user facing commands in the module which send requests to the API use the variables set in the script scope to authenticate and direct responses to the API. They also follow the same internal pattern seen in **`New-PASSession`**, with the API response  passing through the internal functions until any response is returned as a PowerShell object to the context of the originating command.

## RADIUS Authentication Flow

The following diagram provides a higher-level overview of the module's RADIUS authentication flow:

![alt]({{ site.url }}{{ site.baseurl }}/assets/images/New-PASSession/RADIUS.png){: .half .align-center}

We use **`Invoke-PASRestMethod`** as a wrapper around the **`Invoke-WebRequest`** PowerShell CmdLet so that we can catch any errors that might arise while using the API.

If additional authentication steps are needed to access the API using RADIUS authentication after the initial authentication, these are identified as exceptions with the specific Error ID of **`ITATS542I`**.

When **`New-PASSession`** encounters an **`ITATS542I`** exception, we know a RADIUS Challenge is contained within it.

RADIUS Challenge responses are sent using the internal **`Send-RADIUSResponse`** function.

Any required OTP is provided, or prompted for, and is then sent back to the server issuing the challenge.

**`Send-RADIUSResponse`** will continue to handle additional **`ITATS542I`** exceptions for additional necessary challenges up until user responses are satisfactory for the authentication attempt or a challenge fails.

The API responds with a Logon Result containing the necessary authentication token upon successful completion of all challenges.

## IIS + Vault Primary/Secondary Authentication

Some authentication methods utilise IIS configurations as well as Vault authentication in conjunction with each other.

This necessitates that users must first successfully authenticate against any IIS authentication requirements in addition to the vault authentication. A few examples are:
- Windows Authentication using the default credentials for the PowerShell session.
- PKI Authentication and a certificate supplied by the user.

In each case, the required authentication factors are passed to **`Invoke-WebRequest`**, allowing IIS authentication to take place before any subsequent attempt to authenticate to the vault.

This flow is shown below:

![alt]({{ site.url }}{{ site.baseurl }}/assets/images/New-PASSession/IIS.png){: .half .align-center}

Any supplied certificate information or credential values will be stored as a reference in the script scope WebSession object that the module uses for subsequent operations, ensuring that any ongoing IIS authentication requirements are met after the first API authentication , and when other module commands are executed.

## SAML Authentication

SAML authentication requires a **`SAMLResponse`** value from your IDP to be passed to the API.

When you supply a **`SAMLResponse`** value to **`New-PASSession`**, the API receives it and returns the necessary API authorization token after successfully accepting and validating the SAML token.

This **`SAMLResponse`** value must be obtained directly from your IDP and provided to **`New-PASSession`**. As an alternative, **`psPAS`** might be able to obtain the **`SAMLResponse`** value if you're using an IDP that supports Integrated Windows Authentication SSO (like ADFS) and your environment is set up to support this authentication flow.

![alt]({{ site.url }}{{ site.baseurl }}/assets/images/New-PASSession/SAML.png){: .half .align-center}

We can see in the SAML authentication flow diagram that if no SAMLResponse value is provided, **`psPAS`** will invoke an internal function called **`Get-PASSAMLResponse`** which will attempt to obtain the **`SAMLResponse`** value.

**`Get-PASSAMLResponse`** obtains the IDP SSO URL from PVWA, and provides the default credentials of the PowerShell Session to the IDP, following a number of web redirects until receiving the required **`SAMLResponse`**. Many factors and configurations may influence the success of this command, and a SAMLResponse will not be able to be obtained from all IDPs.

There are many SAML IDPs which may be in use, far too many to incorporate all available options into **`psPAS`** individually. While there are no plans to add capability into psPAS to get a **`SAMLResponse`** from any other IDPs out in the wild, if you have a method to obtain a SAMLResponse from a particular IDP, consider sharing it - this is a topic we get contacted about regularly; while we'd love to be able to provide answers for all SAML authentication platforms, it is beyond the scope of the core capabilities of the module's intended purpose.

This is where the power of the CyberArk & PowerShell communities comes into play... Allyn Lyndsay, a fellow CyberArk Guardian, has created a significantly handy tool to interactively authenticate to your SAML IDP, and return the **`SAMLResponse`** for use in other calls, like **`New-PASSession`**.

Find the tool and see it in action on GitHub here: [**PS-SAML-Interactive**](https://github.com/allynl93/PS-SAML-Interactive)

## Summary

Now you understand how New-PASSession functions, and leverages various psPAS internals to successfully authenticate against the API!

Did we forget anything?

Let us know if there is any further information you would want to see or if you have any questions that have not been answered.
