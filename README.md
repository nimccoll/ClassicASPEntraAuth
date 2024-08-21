# ClassicASPEntraAuth
Sample classic ASP code demonstrating how to leverage Microsoft Entra Authentication via Azure App Service EasyAuth and how to retrieve App Settings and Connection Strings from the Azure App Service.

## Background
VBScript provides little to no support for modern authentication protocols. Many classic ASP applications were developed for internal use and relied on Windows authentication and those that were public sites relied on Forms-Based authentication. This repository provides an approach that will allow you to deploy your classic ASP application to an Azure App Service and take advantage of the OpenID Connect authentication protocol by leveraging App Service Authentication (formerly known as "EasyAuth").

## Configuration
To leverage the sample code in this repository create an App Service in Azure and enable App Service Authentication as documented [here](https://learn.microsoft.com/en-us/azure/app-service/scenario-secure-app-authentication-app-service?tabs=workforce-configuration).

Once you have your App Service created and configured for authentication you can deploy the sample classic ASP files either by simply uploading them via your App Service's Kudu console or including them in a Visual Studio solution and publishing them to your Azure App Service.

## Understanding the Sample Code
In a typical classic ASP application, you can check the Request.ServerVariables LOGON_USER variable to determine if a user is signed in and obtain their credentials. Unfortunately, not all of the Identity Providers supported by the App Service Authentication feature correctly populate this variable. The provided sample code can be used with all of the Identity Providers supported by the App Service Authentication feature. Rather than examining the Request.ServerVariables LOGON_USER variable to determine the authenticated user, we will leverage a known set of HTTP headers that are always populated by the App Service Authentication feature regardless of which Identity Provider you select. In addition, the sample code demonstrates how you can pull in configuration values and connection strings from the App Service environment variables collection so you don't have to hard code them in include files or the global.asa file.

## Giving Credit Where Credit Is Due
To leverage the HTTP headers provided by the App Service Authentication feature we need to be able to do two things:

1. Decode a Base64 string
1. Parse a JSON document

VBScript does not have built-in functionality to do either one of these things. Luckily, other folks had already figured this out and I was able to leverage their work thanks to a little bit of time spent with Bing. The Base64Decode function was created by Antonin Foller, Motobit Software (http://Motobit.cz) in 1999. The VBSJson class was created by Demon (https://demon.tw) in 2012. A big thanks to both of these gentlemen for helping to make this solution possible.

## The Sample Code
### base64decode.asp
This file contains the Base64Decode function created by Antonin Foller

### vbsjson.asp
This file contains the VBSJson class created by Demon

### global.asa
The **Application_OnStart** event creates an instance of the WScript.Shell object in order to get access to the Environment of the currently executing process. Since every Application Setting and Connection String configured in the Environment Variables blade of the Azure App Service is exposed as an environment variable this allows our classic ASP application to retrieve both application settings and connection strings configured on the Azure App Service. No more hardcoding connection strings and other sensitive secrets in include files or the global.asa. This also allows us store these values securely in Key Vault by leveraging the [App Service Key Vault Reference feature](https://learn.microsoft.com/en-us/azure/app-service/app-service-key-vault-references?tabs=azure-cli). When developing and testing on your local machine simply use the Visual Studio Debug Properties panel to create and store these environment variable values with the project. Visual Studio will load them into the process when you run the application. This will allow the same code to function locally and in the Azure App Service. I have created an App Setting named HOSTING_ENVIRONMENT to indicate whether the application is running in Azure or running locally. This value and several others are retrieved from environment variables and stored in the Application object for later use.

The **Session_OnStart** event checks the Application("HOSTING_ENVIRONMENT") value to determine if the application is running in Azure. If it is, the code performs a base64 decode on the HTTP_X_MS_CLIENT_PRINCIPAL header. It then uses the VBSJson class to parse the JSON produced by the base64 decode and create a VBScript compatible object. The code searches the claims of the client principal object to find the "preferred_username" claim and populates the Session LOGON_USER value with the authenticated user id. If the application is running locally, the code simply populates the Session LOGON_USER with the Request.ServerVariables("LOGON_USER") value. Please note that you can pull any additional claims values you need from the client principal object (roles, groups, etc.) that you may need in your application and store them in the Session object.

### index.asp, test.asp, test2.asp
These remaining pages simply demonstrate how to retrieve and work with the environment variable values stored in the ASP Application object and the user information stored in the ASP Session object as well as how to use the Base64Decode function and the VBSJson class.