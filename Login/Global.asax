<%@ Application Language="VB" %>
<%@ Import Namespace="System.Diagnostics" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
    End Sub
    
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub
        
    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
        'get reference to the source of the exception chain
        'Dim ex As Exception = Server.GetLastError().GetBaseException()
        'Dim Message As String
        ''log the details of the exception and page state to the
        ''Windows 2000 Event Log

        'Message = "ERROR MESSAGE: " & ex.Message.ToString() & vbNewLine & _
        '  "User Name: " & Session("susername") & vbNewLine & _
        '  "Web URL : " & Request.Url.ToString() & vbNewLine & _
        '  "SOURCE: " & ex.Source.ToString() & vbNewLine & _
        '  "FORM: " & Request.Form.ToString() & vbNewLine & _
        '  "QUERYSTRING: " & Request.QueryString.ToString() & vbNewLine & _
        '  "TARGETSITE: " & ex.TargetSite.ToString() & vbNewLine & _
        '  "STACKTRACE: " & ex.StackTrace

        'EventLog.WriteEntry(ex.Source.ToString(), Message)
        'Insert optional email notification here...
        
        
        'Dim oMail As New System.Net.Mail.SmtpClient("smtp.gmail.com", 25)
        'oMail.EnableSsl = True
        'oMail.Credentials = New System.Net.NetworkCredential("pcmath@gmail.com", "Password")
        'oMail.Send("pcmath@gmail.com", "cherian@cherianpaul.com", "Run Time Error in Raymond's Application", Message)
        'oMail = Nothing

    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub
       
    Protected Sub Application_BeginRequest(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub
</script>