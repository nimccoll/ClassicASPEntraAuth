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
        <h1>This is the Index Page</h1>
        <p><b>This page is available to any authenticated user.</b></p>
        <%
            ' Display all of the ASP server variables
            For Each strKey In Request.ServerVariables
                Response.Write("<b>Name:</b> " + strKey + " <b>Value:</b> " + Request.ServerVariables(strKey) + "<br/>")
            Next
        %>    
    </body>
</html>