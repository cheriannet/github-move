Imports System.Data.SqlClient

Partial Class _Default
    Inherits System.Web.UI.Page

    Protected Sub bLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles bLogin.Click
        If FormsAuthentication.Authenticate(tUsername.Text, tPassword.Text) Then
            lError.Text = "Login Successful."
            FormsAuthentication.RedirectFromLoginPage(tUsername.Text, chkPersistLogin.Checked)
            tblLogin.Visible = False
        Else
            lError.Text = "<b>Something went wrong...</b> please re-enter your credentials..."
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If User.Identity.IsAuthenticated Then
            tblLogin.Visible = False
            'Send email when Raymond logins
            'Dim oMail As New System.Net.Mail.SmtpClient("smtp.gmail.com", 25)
            'oMail.EnableSsl = True
            'oMail.Credentials = New System.Net.NetworkCredential("pcmath@gmail.com", "Password")
            'oMail.Send("pcmath@gmail.com", "cherian@cherianpaul.com", "Raymond's Application", "Logged into Raymond's Application at " & Now)
            'oMail = Nothing
        End If
    End Sub
End Class
