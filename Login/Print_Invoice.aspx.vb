Imports System.Data.SqlClient

Partial Class Print_Invoice
    Inherits System.Web.UI.Page

    Protected Sub gDetail_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles gDetail.DataBound
        Dim I As Single = 0
        Dim iTotal As Double = 0.0
        For I = 0 To gDetail.Rows.Count - 1
            iTotal = iTotal + Val(gDetail.DataKeys(I).Values("Charge").ToString)
        Next
        If iTotal > 0 Then gDetail.FooterRow.Cells(4).Text = FormatCurrency(iTotal, 2, TriState.False, TriState.True, TriState.True)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim sQuery As String = "SELECT Id, Name, Service_Address, Service_City, Service_State, Service_Zip, Bill_To_Address, Bill_To_City, Bill_To_State, Bill_To_Zip, Inv_Date, Account_Type, Regular FROM Invoice WHERE Id = " & Request.QueryString("Id").ToString
            Using Cn As New SqlConnection(ConfigurationManager.ConnectionStrings("LawnWorksHouston").ToString)
                Cn.Open()
                Using Cmd As New SqlCommand(sQuery, Cn)
                    Dim rReader As SqlDataReader = Cmd.ExecuteReader
                    If rReader.Read() Then
                        lClient_Name.Text = rReader("Name").ToString
                        lService_Address.Text = rReader("Service_Address").ToString & "<br/>" & rReader("Service_City").ToString & "," & rReader("Service_State").ToString & "-" & rReader("Service_Zip").ToString
                        lBill_To_Address.Text = rReader("Bill_To_Address").ToString & "<br/>" & rReader("Bill_To_City").ToString & "," & rReader("Bill_To_State").ToString & "-" & rReader("Bill_To_Zip").ToString
                        lAccount_Type.Text = rReader("Account_Type").ToString
                        lRegular.Text = rReader("Regular").ToString
                        lInvoice_No.Text = "LWH-" & rReader("Id").ToString
                        lInvoice_Date.Text = FormatDateTime(rReader("Inv_Date").ToString, DateFormat.ShortDate)

                    End If
                End Using
                Cn.Close()
            End Using

        End If
    End Sub

    Protected Sub gDetail_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gDetail.RowDataBound
        If Not Request.QueryString("mode") = "edit" Then e.Row.Cells(0).Visible = False
    End Sub

    Protected Sub iLogo_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles iLogo.Click
        If InStr(Request.Url.ToString, "&mode=edit") > 0 Then
            Response.Redirect("Print_Invoice.aspx?Id=" + Request.QueryString("Id").ToString)
        Else
            Response.Redirect("Print_Invoice.aspx?Id=" + Request.QueryString("Id").ToString + "&mode=edit")
        End If
    End Sub
End Class
