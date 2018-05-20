Imports System.Data.SqlClient

Partial Class Schedules
    Inherits System.Web.UI.Page

    Protected Sub dClients_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim dClients As DropDownList = CType(sender.parent.parent.parent.parent.FindControl("dClients"), DropDownList)
        Dim AddressTextBox As TextBox = CType(sender.parent.parent.parent.parent.FindControl("AddressTextBox"), TextBox)
        Dim CityTextBox As TextBox = CType(sender.parent.parent.parent.parent.FindControl("CityTextBox"), TextBox)
        Dim StateTextBox As TextBox = CType(sender.parent.parent.parent.parent.FindControl("StateTextBox"), TextBox)
        Dim ZipTextBox As TextBox = CType(sender.parent.parent.parent.parent.FindControl("ZipTextBox"), TextBox)
        Dim ChargeTextBox As TextBox = CType(sender.parent.parent.parent.parent.FindControl("ChargeTextBox"), TextBox)

        Using Cn As New SqlConnection(ConfigurationManager.ConnectionStrings("LawnWorksHouston").ToString)
            Cn.Open()
            Dim sQuery As String = "SELECT Id, Name, Service_Address, Service_City, Service_State, Service_Zip, Default_Charge, Charge_by FROM Contacts WHERE Id = " & dClients.SelectedValue.ToString
            Using Cmd As New SqlCommand(sQuery, Cn)
                Dim rReader As SqlDataReader = Cmd.ExecuteReader
                If rReader.Read() Then
                    AddressTextBox.Text = rReader("Service_Address").ToString
                    CityTextBox.Text = rReader("Service_City").ToString
                    StateTextBox.Text = rReader("Service_State").ToString
                    ZipTextBox.Text = rReader("Service_Zip").ToString
                    If rReader("Charge_by").ToString = "Appointment" Then
                        ChargeTextBox.Text = FormatNumber(rReader("Default_Charge").ToString, 2, TriState.False, TriState.False, TriState.False)
                    Else
                        ChargeTextBox.Text = "0.00"
                    End If
                End If
            End Using
            Cn.Close()
        End Using
    End Sub

    Protected Sub frmSchedules_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles frmSchedules.ItemInserted
        gAllAppointments.DataBind()
        gSchedules.DataBind()
    End Sub

    Protected Sub frmSchedules_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertEventArgs) Handles frmSchedules.ItemInserting
        Dim dClients As DropDownList = CType(frmSchedules.FindControl("dClients"), DropDownList)
        e.Values("Name") = dClients.SelectedItem.Text.ToString
    End Sub

    Protected Sub gAllAppointments_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gAllAppointments.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lDay As Label = CType(e.Row.FindControl("lDay"), Label)
            lDay.Text = DateAdd(DateInterval.Day, e.Row.DataItem("Id"), DateAdd(DateInterval.WeekOfYear, Val(lWeek.Text) - 1, DateAdd(DateInterval.Weekday, -(DatePart(DateInterval.Weekday, CDate("01/01/" & lYear.Text))), CDate("01/01/" & lYear.Text)))) & "(" & WeekdayName(e.Row.DataItem("Id"), True) & ")"
            Dim I As Single, J As Single
            For I = 1 To 9
                Dim myGrid As GridView = CType(e.Row.FindControl("g" & I), GridView)
                J = I + 8
                sqlAppts.FilterExpression = "Time >= '1900-01-01 " & J & ":00:00.000' AND Time < '1900-01-01 " & J + 1 & ":00:00.000' AND WeekDay = " & e.Row.DataItem("Id")
                myGrid.DataSource = sqlAppts
                myGrid.DataBind()
            Next
            If e.Row.DataItem("Id").ToString = "4" Then e.Row.BackColor = Drawing.Color.AntiqueWhite
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lWeek.Text = DatePart(DateInterval.WeekOfYear, Now)
            lYear.Text = DatePart(DateInterval.Year, Now)
            If Not Request.QueryString("Id") Is Nothing Then
                frmSchedulesEdit.ChangeMode(FormViewMode.Edit)
                Dim hGoogle As HyperLink = CType(frmSchedulesEdit.FindControl("hGoogle"), HyperLink)
                Using Cn As New SqlConnection(ConfigurationManager.ConnectionStrings("LawnWorksHouston").ToString)
                    Cn.Open()
                    Dim sQuery As String = "SELECT [Id],[Date],[Name],[Address],[City] ,[State] ,[Zip] ,[Time] ,[Charge] ,[Notes]  FROM [lawnworkshouston].[dbo].[Schedules] WHERE Id = " & Request.QueryString("Id")
                    Using Cmd As New SqlCommand(sQuery, Cn)
                        Dim rReader As SqlDataReader = Cmd.ExecuteReader
                        If rReader.Read() Then
                            hGoogle.NavigateUrl = "https://www.google.com/calendar/render?action=TEMPLATE&hl=en&text=" & rReader("Name") & "&dates=" & Year(rReader("Date")) & Right("0" & Month(rReader("Date")), 2) & Right("0" & Day(rReader("Date")), 2) & "T" & Right("0" & Hour(rReader("Time")), 2) & Right("0" & Minute(rReader("Time")), 2) & Right("0" & Second(rReader("Time")), 2) & "/" & Year(rReader("Date")) & Right("0" & Month(rReader("Date")), 2) & Right("0" & Day(rReader("Date")), 2) & "T" & Right("0" & Hour(rReader("Time")), 2) & Right("0" & Minute(rReader("Time")), 2) & Right("0" & Second(rReader("Time")), 2) & "&location=" & rReader("Address").ToString & "," & rReader("City").ToString & "," & rReader("State").ToString & "-" & rReader("Zip").ToString & "&details=" & rReader("Notes") & "&sf=true&oustput=xml"
                        End If
                    End Using
                    Cn.Close()
                End Using
            End If
        End If
    End Sub

    Protected Sub lbPreWeek_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbPreWeek.Click
        If lWeek.Text = "1" Then
            lWeek.Text = "53"
            lYear.Text = Val(lYear.Text) - 1
        Else
            lWeek.Text = Val(lWeek.Text) - 1
        End If
        gAllAppointments.DataBind()
    End Sub

    Protected Sub lbNextWeek_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbNextWeek.Click
        If lWeek.Text = "53" Then
            lWeek.Text = "1"
            lYear.Text = Val(lYear.Text) + 1
        Else
            lWeek.Text = Val(lWeek.Text) + 1
        End If
        gAllAppointments.DataBind()
    End Sub

    Protected Sub frmSchedules_ItemCreated(ByVal sender As Object, ByVal e As System.EventArgs) Handles frmSchedules.ItemCreated
        If frmSchedules.CurrentMode = FormViewMode.Insert Then
            Dim DateTextBox As TextBox = CType(frmSchedules.FindControl("DateTextBox"), TextBox)
            DateTextBox.Text = Now.Date
        End If
    End Sub

    Protected Sub frmSchedulesEdit_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdatedEventArgs) Handles frmSchedulesEdit.ItemUpdated
        gAllAppointments.DataBind()
        gSchedules.DataBind()
    End Sub

    Protected Sub frmSchedulesEdit_ItemUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdateEventArgs) Handles frmSchedulesEdit.ItemUpdating
        Dim dClients As DropDownList = CType(frmSchedulesEdit.FindControl("dClients"), DropDownList)
        Dim dTime As DropDownList = CType(frmSchedulesEdit.FindControl("dTime"), DropDownList)
        Dim dStatus As DropDownList = CType(frmSchedulesEdit.FindControl("dStatus"), DropDownList)
        Dim AddressTextBox As TextBox = CType(frmSchedulesEdit.FindControl("AddressTextBox"), TextBox)
        Dim CityTextBox As TextBox = CType(frmSchedulesEdit.FindControl("CityTextBox"), TextBox)
        Dim StateTextBox As TextBox = CType(frmSchedulesEdit.FindControl("StateTextBox"), TextBox)
        Dim ZipTextBox As TextBox = CType(frmSchedulesEdit.FindControl("ZipTextBox"), TextBox)
        Dim ChargeTextBox As TextBox = CType(frmSchedulesEdit.FindControl("ChargeTextBox"), TextBox)
        Dim DateTextBox As TextBox = CType(frmSchedulesEdit.FindControl("DateTextBox"), TextBox)
        Dim WorkdoneTextBox As TextBox = CType(frmSchedulesEdit.FindControl("WorkdoneTextBox"), TextBox)
        Dim NotesTextBox As TextBox = CType(frmSchedulesEdit.FindControl("NotesTextBox"), TextBox)

        e.NewValues("Client_Id") = dClients.SelectedValue.ToString
        e.NewValues("Name") = dClients.SelectedItem.Text.ToString
        e.NewValues("Time") = dTime.Text
        e.NewValues("Address") = Trim(AddressTextBox.Text)
        e.NewValues("City") = Trim(CityTextBox.Text)
        e.NewValues("State") = Trim(StateTextBox.Text)
        e.NewValues("Zip") = Trim(ZipTextBox.Text)
        e.NewValues("Charge") = Trim(Val(ChargeTextBox.Text))
        e.NewValues("Date") = Trim(DateTextBox.Text)
        e.NewValues("Workdone") = Trim(WorkdoneTextBox.Text)
        e.NewValues("Notes") = Trim(NotesTextBox.Text)
        e.NewValues("Status") = dStatus.Text
    End Sub

    Protected Sub dClients_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)
        Using Cn As New SqlConnection(ConfigurationManager.ConnectionStrings("LawnWorksHouston").ToString)
            Cn.Open()
            Dim sQuery As String = "SELECT Id, Client_Id, Name, Address, City, State, Zip, Date, Time, ISNULL(Charge,0.00) As Charge, WorkDone, Notes, Status FROM Schedules WHERE Id = " & Request.QueryString("Id").ToString
            Dim dClients As DropDownList = CType(frmSchedulesEdit.FindControl("dClients"), DropDownList)
            Dim dTime As DropDownList = CType(frmSchedulesEdit.FindControl("dTime"), DropDownList)
            Dim dStatus As DropDownList = CType(frmSchedulesEdit.FindControl("dStatus"), DropDownList)
            Dim AddressTextBox As TextBox = CType(frmSchedulesEdit.FindControl("AddressTextBox"), TextBox)
            Dim CityTextBox As TextBox = CType(frmSchedulesEdit.FindControl("CityTextBox"), TextBox)
            Dim StateTextBox As TextBox = CType(frmSchedulesEdit.FindControl("StateTextBox"), TextBox)
            Dim ZipTextBox As TextBox = CType(frmSchedulesEdit.FindControl("ZipTextBox"), TextBox)
            Dim ChargeTextBox As TextBox = CType(frmSchedulesEdit.FindControl("ChargeTextBox"), TextBox)
            Dim DateTextBox As TextBox = CType(frmSchedulesEdit.FindControl("DateTextBox"), TextBox)
            Dim WorkdoneTextBox As TextBox = CType(frmSchedulesEdit.FindControl("WorkdoneTextBox"), TextBox)
            Dim NotesTextBox As TextBox = CType(frmSchedulesEdit.FindControl("NotesTextBox"), TextBox)

            Using Cmd As New SqlCommand(sQuery, Cn)
                Dim rReader As SqlDataReader = Cmd.ExecuteReader
                If rReader.Read() Then
                    dClients.Text = rReader("Client_Id").ToString
                    dTime.Text = FormatDateTime(rReader("Time").ToString, DateFormat.ShortTime)
                    AddressTextBox.Text = rReader("Address").ToString
                    CityTextBox.Text = rReader("City").ToString
                    StateTextBox.Text = rReader("State").ToString
                    ZipTextBox.Text = rReader("Zip").ToString
                    ChargeTextBox.Text = FormatNumber(rReader("Charge").ToString, 2, TriState.False, TriState.False, TriState.False)
                    DateTextBox.Text = FormatDateTime(rReader("Date").ToString, DateFormat.ShortDate)
                    WorkdoneTextBox.text = rReader("Workdone").ToString
                    NotesTextBox.Text = rReader("Notes").ToString
                    dStatus.text = rReader("Status").ToString
                End If
            End Using
            Cn.Close()
        End Using
    End Sub

    Protected Sub gSchedules_RowUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdatedEventArgs) Handles gSchedules.RowUpdated
        gAllAppointments.DataBind()
    End Sub

    Protected Sub gSchedules_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gSchedules.RowUpdating
        If e.NewValues("Status") = "Done" Then
            If Val(e.OldValues("Regular").ToString) > 0 Then
                Using Cn As New SqlConnection(ConfigurationManager.ConnectionStrings("LawnWorksHouston").ToString)
                    Cn.Open()
                    Dim sQuery As String = "SELECT Id FROM [Schedules] WHERE [Client_Id] = " & e.OldValues("Client_Id").ToString & " AND [Date] =  DATEADD(D," & e.OldValues("Regular").ToString & ",'" & e.OldValues("Date").ToString & "')"
                    Dim bCreated As Boolean = False
                    Using Cmd As New SqlCommand(sQuery, Cn)
                        Dim rReader As SqlDataReader = Cmd.ExecuteReader
                        If rReader.Read() Then
                            bCreated = True
                        End If
                        rReader.Close()
                    End Using
                    If Not bCreated Then
                        ' sQuery = "INSERT INTO [Schedules] ([Client_Id],[Name],[Address],[City],[State],[Zip],[Date],[Time],[Charge],[Status]) SELECT Client_Id,Name, Address, City,State,Zip, DATEADD(D," & e.OldValues("Regular").ToString & ", Date),Time,ISNULL(Charge,0.00),'Pending' As Status FROM [Schedules] WHERE Id = " & e.Keys("Id").ToString
                        sQuery = "INSERT INTO [Schedules] ([Client_Id],[Name],[Address],[City],[State],[Zip],[Date],[Time],[Charge],[Status]) SELECT Schedules.Client_Id, Contacts.Name, Contacts.Service_Address, Contacts.Service_City, Contacts.Service_State, Contacts.Service_Zip, DATEADD(D, " & e.OldValues("Regular").ToString & ", Schedules.Date) AS Date, Schedules.Time, CASE WHEN Charge_by = 'Month' THEN 0.00 ELSE ISNULL(Default_Charge , 0.00) END AS Charge, 'Pending' AS Status FROM Schedules INNER JOIN Contacts ON Schedules.Client_Id = Contacts.Id WHERE Schedules.Id = " & e.Keys("Id").ToString
                        Using Cmd As New SqlCommand(sQuery, Cn)
                            Cmd.ExecuteNonQuery()
                        End Using
                    End If
                    Cn.Close()
                End Using
            End If
        End If
    End Sub

    Protected Sub gSchedules_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gSchedules.RowDataBound
        e.Row.Cells(13).Visible = False
        e.Row.Cells(14).Visible = False
    End Sub

    Protected Sub Detail_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem("Status").ToString = "Cancelled" Then
                e.Row.Font.Strikeout = True
                e.Row.ForeColor = Drawing.Color.Red
            End If
        End If
    End Sub
End Class
