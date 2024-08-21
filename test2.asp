<%
'//===============================================================================
'// Microsoft FastTrack for Azure
'// Azure AD Classic ASP Authentication Sample
'// *** Must be used in conjunction with Azure App Service authentication ***
'//===============================================================================
'// Copyright © Microsoft Corporation.  All rights reserved.
'// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY
'// OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT
'// LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
'// FITNESS FOR A PARTICULAR PURPOSE.
'//===============================================================================
%>
<html>
    <body>
        <h1>Classic ASP Azure Demo</h1>
        <div>
        <%
            Response.Write("Logged in user is " + Session("LOGON_USER") + "<br/><br/>")
            Response.Write("<b>Here are some App Settings from the App Service configuration</b><br/>")
            Response.Write(Application("DOMAIN_NAME") + "<br/>")
            Response.Write(Application("DOMAIN_USERNAME") + " (From Key Vault)<br/>")
            Response.Write(Application("DOMAIN_PASSWORD") + " (From Key Vault)<br/>")
            Response.Write("<br/>")
            Response.Write("<b>Here are some Connection Strings from the App Service configuration</b><br/>")
            Response.Write(Application("MY_CONNECTION_STRING") + " (From Key Vault)<br/>")
        %>
        </div>
    </body>
</html>