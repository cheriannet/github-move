Imports System.Data.SqlClient
Imports System.Data

Partial Class Invoice
    Inherits System.Web.UI.Page

    Protected Sub bCreate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles bCreate.Click
        Using Cn As New SqlConnection(ConfigurationManager.ConnectionStrings("LawnWorksHouston").ToString)
            Cn.Open()
            Dim I As Single = 0
            Dim iInvoiceId As Integer = 0
            For I = 0 To gPending.Rows.Count - 1
                Dim ckBill As CheckBox = CType(gPending.Rows(I).FindControl("ckBill"), CheckBox)
                If ckBill.Checked Then
                    Dim sQuery As String = ""
                    If iInvoiceId = 0 Then
                        Dim lClient_Id As Label = CType(gPending.Rows(I).FindControl("lClient_Id"), Label)
                        Dim IDParameter As New SqlParameter("@ID", SqlDbType.Int)
                        IDParameter.Direction = ParameterDirection.Output

                        sQuery = "INSERT INTO [Invoice] ([Client_Id], [Name], [Service_Address], [Service_City], [Service_State], [Service_Zip], [Bill_To_Address], [Bill_To_City], [Bill_To_State], [Bill_To_Zip], [Inv_Date], [Account_Type], [Regular], [Created_On], [Created_By]) SELECT Id, Name, Service_Address, Service_City, Service_State, Service_Zip, BillTo_Address, BillTo_City, BillTo_State, BillTo_Zip, Getdate() As Date, Account_Type,CASE WHEN Regular = 0 THEN '1-Time' ELSE 'Regular' END As Regular, Getdate() As Created_On, '" & User.Identity.Name.ToString & "' As Created_By FROM [Contacts] WHERE ID = " & lClient_Id.Text & " SET @ID = SCOPE_IDENTITY()"
                        Using Cmd As New SqlCommand(sQuery, Cn)
                            Cmd.Parameters.Add(IDParameter)
                            Cmd.ExecuteNonQuery()
                        End Using
                        iInvoiceId = IDParameter.Value

                        If gPending.DataKeys(I).Values("Charge_by") = "Month" And ckMonthly.Checked Then
                            sQuery = "INSERT INTO [Invoice_Detail] ([Inv_Id], [Workdone], [Notes], [Charge]) VALUES (@Inv_Id, @Workdone, @Notes, @Charge)"
                            Using Cmd As New SqlCommand(sQuery, Cn)
                                With Cmd.Parameters
                                    .Add(New SqlParameter("@Inv_Id", iInvoiceId))
                                    .Add(New SqlParameter("@Workdone", Trim(tMonthlyWorkdone.Text)))
                                    .Add(New SqlParameter("@Notes", Trim(tMonthlyNotes.Text)))
                                    .Add(New SqlParameter("@Charge", Val(Trim(tMonthlyCharge.Text))))
                                End With
                                Cmd.ExecuteNonQuery()
                            End Using
                        End If
                    End If

                    sQuery = "INSERT INTO [Invoice_Detail] ([Inv_Id], [Schedule_Id], [Date], [Workdone], [Notes], [Charge]) VALUES (@Inv_Id, @Schedule_Id, @Date, @Workdone, @Notes, @Charge)"
                    Dim lSchedule_Id As Label = CType(gPending.Rows(I).FindControl("lSchedule_Id"), Label)
                    Dim lDate As Label = CType(gPending.Rows(I).FindControl("lDate"), Label)
                    Dim tWorkdone As TextBox = CType(gPending.Rows(I).FindControl("tWorkdone"), TextBox)
                    Dim tNotes As TextBox = CType(gPending.Rows(I).FindControl("tNotes"), TextBox)
                    Dim tCharge As TextBox = CType(gPending.Rows(I).FindControl("tCharge"), TextBox)
                    Using Cmd As New SqlCommand(sQuery, Cn)
                        With Cmd.Parameters
                            .Add(New SqlParameter("@Inv_Id", iInvoiceId))
                            .Add(New SqlParameter("@Schedule_Id", lSchedule_Id.Text))
                            .Add(New SqlParameter("@Date", lDate.Text))
                            .Add(New SqlParameter("@Workdone", tWorkdone.Text))
                            .Add(New SqlParameter("@Notes", tNotes.Text))
                            .Add(New SqlParameter("@Charge", tCharge.Text))
                        End With
                        Cmd.ExecuteNonQuery()
                    End Using

                    sQuery = "UPDATE Schedules SET Billed_On = Getdate(), Billed_By = '" & User.Identity.Name.ToString & "' WHERE (Id = " & lSchedule_Id.Text & ")"
                    Using Cmd As New SqlCommand(sQuery, Cn)
                        Cmd.ExecuteNonQuery()
                    End Using

                End If
            Next
            Cn.Close()
        End Using
        Response.Redirect("Invoice.aspx")
    End Sub

    Protected Sub gPending_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gPending.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem("Charge_by") = "Month" Then
                pMonthly.Visible = True
                tMonthlyNotes.Text = MonthName(Month(Today)) & " Lawn Maintenance"
                tMonthlyCharge.Text = FormatNumber(e.Row.DataItem("Default_Charge"), 2, TriState.False, TriState.False)
            End If
        End If
    End Sub
End Class
