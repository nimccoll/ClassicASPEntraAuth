<!--#include file="vbsjson.asp"-->
<!--#include file="base64decode.asp"-->
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
        <h1>Server Variables</h1>
        <div>
        <%
            Dim clientPrincipal, json, o
            
            ' Display all of the ASP server variables
            For Each strKey In Request.ServerVariables
                Response.Write("<b>Name:</b> " + strKey + " <b>Value:</b> " + Request.ServerVariables(strKey) + "<br/>")
            Next
            
            clientPrincipal = Base64Decode(Request.ServerVariables("HTTP_X_MS_CLIENT_PRINCIPAL"))
            Response.Write(clientPrincipal + "<br/>")
            Set json = New VbsJson
            Set o = json.Decode(clientPrincipal)
            Response.Write(o("auth_typ") + "<br/>")
            For Each objClaim in o("claims")
                If objClaim("typ") = "preferred_username" Then
                    Session("LOGON_USER") = objClaim("val")
                    Response.Write("Logged in user is " + Session("LOGON_USER") + "<br/><br/>")
                End If
                Response.Write(objClaim("typ") + "<br/>")
                Response.Write(objClaim("val") + "<br/>")
                Response.Write("<br/>")
            Next
            
            Response.Write(Application("DOMAIN_NAME") + "<br/>")
            Response.Write(Application("DOMAIN_USERNAME") + "<br/>")
            Response.Write(Application("DOMAIN_PASSWORD") + "<br/>")
            
            ' Cleanup
            Set o = Nothing
            Set json = Nothing
        %>
        </div>
    </body>
</html>