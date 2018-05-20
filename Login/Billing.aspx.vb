Imports System.Data.SqlClient

Partial Class Billing
    Inherits System.Web.UI.Page

    Protected Sub gInvoice_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gInvoice.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lId As Label = CType(e.Row.FindControl("lId"), Label)
            lId.Text = "LWH-" & e.Row.DataItem("Id").ToString
            Using Cn As New SqlConnection(ConfigurationManager.ConnectionStrings("LawnWorksHouston").ToString)
                Cn.Open()
                Dim sQuery As String = "SELECT Notes FROM Invoice WHERE Id = " & e.Row.DataItem("Id").ToString
                Dim tNotes As TextBox = CType(e.Row.FindControl("tNotes"), TextBox)
                Using Cmd As New SqlCommand(sQuery, Cn)
                    Dim rReader As SqlDataReader = Cmd.ExecuteReader
                    If rReader.Read() Then
                        tNotes.Text = rReader("Notes").ToString
                    End If
                End Using
                Cn.Close()
            End Using
        End If
    End Sub

    Protected Sub gInvoice_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gInvoice.RowUpdating
        If e.NewValues("Paid").ToString = "True" Then
            If e.OldValues("Paid_On") = "" Then
                e.NewValues("Paid_On") = Now.Date
            Else
                e.NewValues("Paid_On") = e.OldValues("Paid_On")
            End If
        Else
            e.NewValues("Paid_On") = ""
        End If
        Using Cn As New SqlConnection(ConfigurationManager.ConnectionStrings("LawnWorksHouston").ToString)
            Cn.Open()
            Dim tNotes As TextBox = CType(gInvoice.Rows(e.RowIndex).FindControl("tNotes"), TextBox)
            Dim sQuery As String = "UPDATE Invoice SET Notes = @Notes WHERE Id = " & e.Keys("Id").ToString
            Using Cmd As New SqlCommand(sQuery, Cn)
                Cmd.Parameters.Add(New SqlParameter("@Notes", Trim(tNotes.Text)))
                Cmd.ExecuteNonQuery()
            End Using
            Cn.Close()
        End Using
    End Sub
End Class
