
Partial Class Contacts
    Inherits System.Web.UI.Page

    Protected Sub gContacts_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gContacts.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow And e.Row.RowIndex <> gContacts.EditIndex Then
            Dim lName As Label = CType(e.Row.FindControl("lName"), Label)
            If e.Row.DataItem("Active") = False Then
                lName.Font.Strikeout = True
            End If
        End If
    End Sub
End Class
