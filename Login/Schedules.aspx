<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Schedules.aspx.vb" Inherits="Schedules" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Schedules</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <center>
        <asp:Menu ID="MainMenu" runat="server" BackColor="#B5C7DE" 
            DataSourceID="SiteMap" DynamicHorizontalOffset="2" Font-Names="Verdana" 
            Font-Size="0.8em" ForeColor="#284E98" Orientation="Horizontal" 
            StaticSubMenuIndent="10px">
            <StaticSelectedStyle BackColor="#507CD1" />
            <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
            <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
            <DynamicMenuStyle BackColor="#B5C7DE" />
            <DynamicSelectedStyle BackColor="#507CD1" />
            <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
            <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
        </asp:Menu>
        <asp:SiteMapDataSource ID="SiteMap" runat="server" ShowStartingNode="False" />
    </center>
        <asp:SqlDataSource ID="sqlSchedules" runat="server" 
            ConnectionString="<%$ ConnectionStrings:LawnWorksHouston %>" 
            DeleteCommand="DELETE FROM [Schedules] WHERE [Id] = @Id" 
            InsertCommand="INSERT INTO [Schedules] ([Client_Id], [Name], [Address], [City], [State], [Zip], [Date], [Time], [Charge], [Notes]) VALUES (@Client_Id, @Name, @Address, @City, @State, @Zip, @Date, @Time, @Charge, @Notes)" 
            SelectCommand="SELECT Schedules.Id, Schedules.Client_Id, Schedules.Name, Schedules.Address, Schedules.City, Schedules.State, Schedules.Zip, Schedules.Date, Schedules.Time, Schedules.Charge, Schedules.Notes, Schedules.Status, Schedules.Workdone, Contacts.Regular FROM Schedules INNER JOIN Contacts ON Schedules.Client_Id = Contacts.Id WHERE (Schedules.Date = CAST(FLOOR(CAST(GETDATE() AS FLOAT)) AS DATETIME)) OR (Schedules.Date &lt; CAST(FLOOR(CAST(Getdate() AS FLOAT)) AS DATETIME)) AND (Schedules.Status = 'Pending') ORDER BY Schedules.Date, Schedules.Time" 
            
            
            
            
            
            UpdateCommand="UPDATE Schedules SET Status = @Status, Notes = @Notes, Workdone = @Workdone WHERE (Id = @Id)">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Status" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="Workdone" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="Client_Id" Type="Int32" />
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Address" Type="String" />
                <asp:Parameter Name="City" Type="String" />
                <asp:Parameter Name="State" Type="String" />
                <asp:Parameter Name="Zip" Type="String" />
                <asp:Parameter DbType="Date" Name="Date" />
                <asp:Parameter DbType="Time" Name="Time" />
                <asp:Parameter Name="Charge" Type="Decimal" />
                <asp:Parameter Name="Notes" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlSchedulesEdit" runat="server" 
            ConnectionString="<%$ ConnectionStrings:LawnWorksHouston %>" 
            SelectCommand="SELECT Id, Client_Id, Name, Address, City, State, Zip, Date, Time, Charge, Notes, Status FROM Schedules WHERE (Id = @Id)" 
            
            
            
            
            
            UpdateCommand="UPDATE Schedules SET Notes = @Notes, Client_Id = @Client_Id, Name = @Name, Address = @Address, City = @City, State = @State, Zip = @Zip, Date = @Date, Time = @Time, Charge = @Charge, Workdone = @Workdone, Status = @Status WHERE (Id = @Id)">
            <SelectParameters>
                <asp:QueryStringParameter Name="Id" QueryStringField="Id" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="Client_Id" />
                <asp:Parameter Name="Name" />
                <asp:Parameter Name="Address" />
                <asp:Parameter Name="City" />
                <asp:Parameter Name="State" />
                <asp:Parameter Name="Zip" />
                <asp:Parameter Name="Date" />
                <asp:Parameter Name="Time" />
                <asp:Parameter Name="Charge" />
                <asp:Parameter Name="Workdone" />
                <asp:Parameter Name="Status" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lWeek" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lYear" runat="server" Visible="False"></asp:Label>
        <br />
        <asp:FormView ID="frmSchedules" runat="server" DataKeyNames="Id" 
            DataSourceID="sqlSchedules">
            <InsertItemTemplate>
                <table>
                    <tr>
                        <td>
                            Name:
                        </td>
                        <td colspan="3">
                            <asp:DropDownList ID="dClients" runat="server" AutoPostBack="True" 
                                DataSourceID="sqlClients" DataTextField="Name" DataValueField="Id" 
                                ondatabound="dClients_SelectedIndexChanged" 
                                onselectedindexchanged="dClients_SelectedIndexChanged" 
                                SelectedValue='<%# Bind("Client_Id") %>'>
                            </asp:DropDownList>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            <asp:SqlDataSource ID="sqlClients" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:LawnWorksHouston %>" 
                                SelectCommand="SELECT [Id], [Name] FROM [Contacts] WHERE ([Active] = 1)">
                            </asp:SqlDataSource>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Address:</td>
                        <td colspan="3">
                            <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' 
                                Width="200px" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            City:
                        </td>
                        <td>
                            <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' 
                                Width="90px" />
                        </td>
                        <td>
                            State:</td>
                        <td>
                            <asp:TextBox ID="StateTextBox" runat="server" Text='<%# Bind("State") %>' 
                                Width="40px" />
                        </td>
                        <td>
                            Zip:
                        </td>
                        <td>
                            <asp:TextBox ID="ZipTextBox" runat="server" Text='<%# Bind("Zip") %>' 
                                Width="50px" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Date:</td>
                        <td colspan="3">
                            <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>' 
                                Width="70px" />
                            <asp:RangeValidator ID="rvDate" runat="server" ControlToValidate="DateTextBox" 
                                Display="Dynamic" ErrorMessage="Invalid Date" MaximumValue="1/1/2100" 
                                MinimumValue="1/1/1900" Type="Date"></asp:RangeValidator>
                            <asp:RequiredFieldValidator ID="rfDate" runat="server" 
                                ControlToValidate="DateTextBox" Display="Dynamic" ErrorMessage="Invalid Date"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            Time:</td>
                        <td>
                            <asp:DropDownList ID="dTime" runat="server" SelectedValue='<%# Bind("Time") %>'>
                                <asp:ListItem>9:00</asp:ListItem>
                                <asp:ListItem>9:15</asp:ListItem>
                                <asp:ListItem>9:30</asp:ListItem>
                                <asp:ListItem>9:45</asp:ListItem>
                                <asp:ListItem>10:00</asp:ListItem>
                                <asp:ListItem>10:15</asp:ListItem>
                                <asp:ListItem>10:30</asp:ListItem>
                                <asp:ListItem>10:45</asp:ListItem>
                                <asp:ListItem>11:00</asp:ListItem>
                                <asp:ListItem>11:15</asp:ListItem>
                                <asp:ListItem>11:30</asp:ListItem>
                                <asp:ListItem>11:45</asp:ListItem>
                                <asp:ListItem>12:00</asp:ListItem>
                                <asp:ListItem>12:15</asp:ListItem>
                                <asp:ListItem>12:30</asp:ListItem>
                                <asp:ListItem>12:45</asp:ListItem>
                                <asp:ListItem>13:00</asp:ListItem>
                                <asp:ListItem>13:15</asp:ListItem>
                                <asp:ListItem>13:30</asp:ListItem>
                                <asp:ListItem>13:45</asp:ListItem>
                                <asp:ListItem>14:00</asp:ListItem>
                                <asp:ListItem>14:15</asp:ListItem>
                                <asp:ListItem>14:30</asp:ListItem>
                                <asp:ListItem>14:45</asp:ListItem>
                                <asp:ListItem>15:00</asp:ListItem>
                                <asp:ListItem>15:15</asp:ListItem>
                                <asp:ListItem>15:30</asp:ListItem>
                                <asp:ListItem>15:45</asp:ListItem>
                                <asp:ListItem>16:00</asp:ListItem>
                                <asp:ListItem>16:15</asp:ListItem>
                                <asp:ListItem>16:30</asp:ListItem>
                                <asp:ListItem>16:45</asp:ListItem>
                                <asp:ListItem>17:00</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Charge:</td>
                        <td colspan="3">
                            <asp:TextBox ID="ChargeTextBox" runat="server" Text='<%# Bind("Charge") %>' 
                                Width="70px" />
                            <asp:RangeValidator ID="rvAmount" runat="server" 
                                ControlToValidate="ChargeTextBox" ErrorMessage="Invalid Amount" 
                                MaximumValue="100000" MinimumValue="0" Type="Currency"></asp:RangeValidator>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Notes:</td>
                        <td colspan="5">
                            <asp:TextBox ID="NotesTextBox" runat="server" Height="60px" 
                                Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="350px" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td colspan="3">
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td colspan="3">
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                CommandName="Insert" Text="Add Appointment" />
                            &nbsp;&nbsp;
                            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                                CommandName="Cancel" Text="Cancel" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
                &nbsp;
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                    CommandName="New" Text="New Appointment" />
            </ItemTemplate>
            <EmptyDataTemplate>
                <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                    CommandName="New" Text="New Appointment" />
            </EmptyDataTemplate>
        </asp:FormView>
        <asp:FormView ID="frmSchedulesEdit" runat="server" DataKeyNames="Id" 
            DataSourceID="sqlSchedulesEdit">
            <EditItemTemplate>
                <table>
                    <tr>
                        <td>
                            Name:
                        </td>
                        <td colspan="3">
                            <asp:DropDownList ID="dClients" runat="server" AutoPostBack="True" 
                                DataSourceID="sqlClients" DataTextField="Name" DataValueField="Id" 
                                ondatabound="dClients_DataBound" 
                                onselectedindexchanged="dClients_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            <asp:SqlDataSource ID="sqlClients" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:LawnWorksHouston %>" 
                                SelectCommand="SELECT [Id], [Name] FROM [Contacts] WHERE ([Active] = 1)">
                            </asp:SqlDataSource>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Address:</td>
                        <td colspan="3">
                            <asp:TextBox ID="AddressTextBox" runat="server" 
                                Width="200px" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            City:
                        </td>
                        <td>
                            <asp:TextBox ID="CityTextBox" runat="server" 
                                Width="90px" />
                        </td>
                        <td>
                            State:</td>
                        <td>
                            <asp:TextBox ID="StateTextBox" runat="server" 
                                Width="40px" />
                        </td>
                        <td>
                            Zip:
                        </td>
                        <td>
                            <asp:TextBox ID="ZipTextBox" runat="server" 
                                Width="50px" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Date:</td>
                        <td colspan="3">
                            <asp:TextBox ID="DateTextBox" runat="server" 
                                Width="70px" />
                            <asp:RangeValidator ID="rvDate" runat="server" ControlToValidate="DateTextBox" 
                                Display="Dynamic" ErrorMessage="Invalid Date" MaximumValue="1/1/2100" 
                                MinimumValue="1/1/1900" Type="Date"></asp:RangeValidator>
                            <asp:RequiredFieldValidator ID="rfDate" runat="server" 
                                ControlToValidate="DateTextBox" Display="Dynamic" ErrorMessage="Invalid Date"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            Time:</td>
                        <td>
                            <asp:DropDownList ID="dTime" runat="server">
                                <asp:ListItem>09:00</asp:ListItem>
                                <asp:ListItem>09:15</asp:ListItem>
                                <asp:ListItem>09:30</asp:ListItem>
                                <asp:ListItem>09:45</asp:ListItem>
                                <asp:ListItem>10:00</asp:ListItem>
                                <asp:ListItem>10:15</asp:ListItem>
                                <asp:ListItem>10:30</asp:ListItem>
                                <asp:ListItem>10:45</asp:ListItem>
                                <asp:ListItem>11:00</asp:ListItem>
                                <asp:ListItem>11:15</asp:ListItem>
                                <asp:ListItem>11:30</asp:ListItem>
                                <asp:ListItem>11:45</asp:ListItem>
                                <asp:ListItem>12:00</asp:ListItem>
                                <asp:ListItem>12:15</asp:ListItem>
                                <asp:ListItem>12:30</asp:ListItem>
                                <asp:ListItem>12:45</asp:ListItem>
                                <asp:ListItem>13:00</asp:ListItem>
                                <asp:ListItem>13:15</asp:ListItem>
                                <asp:ListItem>13:30</asp:ListItem>
                                <asp:ListItem>13:45</asp:ListItem>
                                <asp:ListItem>14:00</asp:ListItem>
                                <asp:ListItem>14:15</asp:ListItem>
                                <asp:ListItem>14:30</asp:ListItem>
                                <asp:ListItem>14:45</asp:ListItem>
                                <asp:ListItem>15:00</asp:ListItem>
                                <asp:ListItem>15:15</asp:ListItem>
                                <asp:ListItem>15:30</asp:ListItem>
                                <asp:ListItem>15:45</asp:ListItem>
                                <asp:ListItem>16:00</asp:ListItem>
                                <asp:ListItem>16:15</asp:ListItem>
                                <asp:ListItem>16:30</asp:ListItem>
                                <asp:ListItem>16:45</asp:ListItem>
                                <asp:ListItem>17:00</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Charge:</td>
                        <td colspan="3">
                            <asp:TextBox ID="ChargeTextBox" runat="server" 
                                Width="70px" />
                            <asp:RangeValidator ID="rvAmount" runat="server" 
                                ControlToValidate="ChargeTextBox" ErrorMessage="Invalid Amount" 
                                MaximumValue="100000" MinimumValue="0" Type="Currency"></asp:RangeValidator>
                        </td>
                        <td>
                            Status</td>
                        <td>
                            <asp:DropDownList ID="dStatus" runat="server">
                                <asp:ListItem>Pending</asp:ListItem>
                                <asp:ListItem>Done</asp:ListItem>
                                <asp:ListItem>Cancelled</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Workdone:</td>
                        <td colspan="3">
                            <asp:TextBox ID="WorkdoneTextBox" runat="server" MaxLength="149" 
                                Width="200px" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Notes:</td>
                        <td colspan="5">
                            <asp:TextBox ID="NotesTextBox" runat="server" Height="60px" 
                                TextMode="MultiLine" Width="350px" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td colspan="3">
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td colspan="3">
                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                CommandName="Update" Text="Update Appointment" />
                            &nbsp;&nbsp;
                            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                                CommandName="Cancel" Text="Cancel" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            <asp:HyperLink ID="hGoogle" runat="server" Target="_blank">Google Calendar</asp:HyperLink>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </EditItemTemplate>
            <InsertItemTemplate>
                &nbsp;
            </InsertItemTemplate>
            <ItemTemplate>
                &nbsp;
            </ItemTemplate>
        </asp:FormView>
        <br />
        <asp:GridView ID="gSchedules" runat="server" AutoGenerateColumns="False" 
            BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" DataKeyNames="Id" DataSourceID="sqlSchedules" 
            Caption="Today's Appointments" Font-Size="Small">
            <RowStyle BackColor="White" ForeColor="#003399" />
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" 
                    ReadOnly="True" SortExpression="Id" />
                <asp:TemplateField HeaderText="Status" SortExpression="Status">
                    <EditItemTemplate>
                        <asp:DropDownList ID="dStatus" runat="server" 
                            SelectedValue='<%# Bind("Status") %>'>
                            <asp:ListItem>Pending</asp:ListItem>
                            <asp:ListItem>Done</asp:ListItem>
                            <asp:ListItem>Cancelled</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lStatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Name" HeaderText="Name" 
                    SortExpression="Name" ReadOnly="True" />
                <asp:BoundField DataField="Address" HeaderText="Address" 
                    SortExpression="Address" ReadOnly="True" />
                <asp:BoundField DataField="City" HeaderText="City" 
                    SortExpression="City" ReadOnly="True" />
                <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" 
                    ReadOnly="True" />
                <asp:BoundField DataField="Zip" HeaderText="Zip" SortExpression="Zip" 
                    ReadOnly="True" />
                <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" 
                    ReadOnly="True" SortExpression="Date" />
                <asp:BoundField DataField="Time" HeaderText="Time" 
                    SortExpression="Time" ReadOnly="True" DataFormatString="{0:t}" />
                <asp:BoundField DataField="Charge" HeaderText="Charge" SortExpression="Charge" 
                    DataFormatString="{0:c}" ReadOnly="True" />
                <asp:TemplateField HeaderText="Workdone" SortExpression="Workdone">
                    <EditItemTemplate>
                        <asp:TextBox ID="tWorkdone" runat="server" MaxLength="149" 
                            Text='<%# Bind("Workdone") %>' Width="200px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lWorkdone" runat="server" Text='<%# Bind("Workdone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes" SortExpression="Notes">
                    <EditItemTemplate>
                        <asp:TextBox ID="tNotes" runat="server" Height="115px" 
                            Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="282px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lNotes" runat="server" Text='<%# Bind("Notes") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Client_Id" HeaderText="Client_Id" 
                    SortExpression="Client_Id" />
                <asp:BoundField DataField="Regular" HeaderText="Regular" 
                    SortExpression="Regular" />
            </Columns>
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
        </asp:GridView>
        <br />
        <asp:SqlDataSource ID="sqlAllAppointments" runat="server" 
            ConnectionString="<%$ ConnectionStrings:LawnWorksHouston %>" 
            SelectCommand="SELECT Id FROM Contacts WHERE (Id &lt; 8)">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlAppts" runat="server" CacheDuration="2" 
            ConnectionString="<%$ ConnectionStrings:LawnWorksHouston %>" 
            EnableCaching="True" 
            
            
            
            
            
            SelectCommand="SELECT Schedules.Id, Schedules.Time, DATEPART(WEEKDAY, Schedules.Date) AS WeekDay, Schedules.Status, Contacts.Abb FROM Schedules INNER JOIN Contacts ON Schedules.Client_Id = Contacts.Id WHERE (DATEPART(WEEK, Schedules.Date) = @Week) AND (DATEPART(YEAR, Schedules.Date) = @Year)">
            <SelectParameters>
                <asp:ControlParameter ControlID="lWeek" DefaultValue="" Name="Week" 
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="lYear" Name="Year" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="gAllAppointments" runat="server" AutoGenerateColumns="False" 
            BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" DataKeyNames="Id" DataSourceID="sqlAllAppointments" 
            Caption="All Appointments" Font-Size="Small">
            <RowStyle BackColor="White" ForeColor="#003399" />
            <Columns>
                <asp:TemplateField HeaderText="Day" InsertVisible="False" SortExpression="Id">
                    <ItemTemplate>
                        <asp:Label ID="lDay" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="9 AM">
                    <ItemTemplate>
                        <asp:GridView ID="g1" runat="server" AutoGenerateColumns="False" 
                            ShowHeader="False" onrowdatabound="Detail_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" DataFormatString="{0:t}" />
                                <asp:HyperLinkField DataNavigateUrlFields="Id" 
                                    DataNavigateUrlFormatString="Schedules.aspx?Id={0}" DataTextField="Abb" 
                                    HeaderText="Abb" />
                            </Columns>
                        </asp:GridView>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="10 AM">
                    <ItemTemplate>
                        <asp:GridView ID="g2" runat="server" AutoGenerateColumns="False" 
                            ShowHeader="False" onrowdatabound="Detail_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" DataFormatString="{0:t}" />
                                <asp:HyperLinkField DataNavigateUrlFields="Id" 
                                    DataNavigateUrlFormatString="Schedules.aspx?Id={0}" DataTextField="Abb" 
                                    HeaderText="Abb" />
                            </Columns>
                        </asp:GridView>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="11 AM">
                    <ItemTemplate>
                        <asp:GridView ID="g3" runat="server" AutoGenerateColumns="False" 
                            ShowHeader="False" onrowdatabound="Detail_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" DataFormatString="{0:t}" />
                                <asp:HyperLinkField DataNavigateUrlFields="Id" 
                                    DataNavigateUrlFormatString="Schedules.aspx?Id={0}" DataTextField="Abb" 
                                    HeaderText="Abb" />
                            </Columns>
                        </asp:GridView>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="12 PM">
                    <ItemTemplate>
                        <asp:GridView ID="g4" runat="server" AutoGenerateColumns="False" 
                            ShowHeader="False" onrowdatabound="Detail_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" DataFormatString="{0:t}" />
                                <asp:HyperLinkField DataNavigateUrlFields="Id" 
                                    DataNavigateUrlFormatString="Schedules.aspx?Id={0}" DataTextField="Abb" 
                                    HeaderText="Abb" />
                            </Columns>
                        </asp:GridView>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="1 PM">
                    <ItemTemplate>
                        <asp:GridView ID="g5" runat="server" AutoGenerateColumns="False" 
                            ShowHeader="False" onrowdatabound="Detail_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" DataFormatString="{0:t}" />
                                <asp:HyperLinkField DataNavigateUrlFields="Id" 
                                    DataNavigateUrlFormatString="Schedules.aspx?Id={0}" DataTextField="Abb" 
                                    HeaderText="Abb" />
                            </Columns>
                        </asp:GridView>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="2 PM">
                    <ItemTemplate>
                        <asp:GridView ID="g6" runat="server" AutoGenerateColumns="False" 
                            ShowHeader="False" onrowdatabound="Detail_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" DataFormatString="{0:t}" />
                                <asp:HyperLinkField DataNavigateUrlFields="Id" 
                                    DataNavigateUrlFormatString="Schedules.aspx?Id={0}" DataTextField="Abb" 
                                    HeaderText="Abb" />
                            </Columns>
                        </asp:GridView>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="3 PM">
                    <ItemTemplate>
                        <asp:GridView ID="g7" runat="server" AutoGenerateColumns="False" 
                            ShowHeader="False" onrowdatabound="Detail_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" DataFormatString="{0:t}" />
                                <asp:HyperLinkField DataNavigateUrlFields="Id" 
                                    DataNavigateUrlFormatString="Schedules.aspx?Id={0}" DataTextField="Abb" 
                                    HeaderText="Abb" />
                            </Columns>
                        </asp:GridView>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="4 PM">
                    <ItemTemplate>
                        <asp:GridView ID="g8" runat="server" AutoGenerateColumns="False" 
                            ShowHeader="False" onrowdatabound="Detail_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" DataFormatString="{0:t}" />
                                <asp:HyperLinkField DataNavigateUrlFields="Id" 
                                    DataNavigateUrlFormatString="Schedules.aspx?Id={0}" DataTextField="Abb" 
                                    HeaderText="Abb" />
                            </Columns>
                        </asp:GridView>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="5 PM">
                    <ItemTemplate>
                        <asp:GridView ID="g9" runat="server" AutoGenerateColumns="False" 
                            ShowHeader="False" onrowdatabound="Detail_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" DataFormatString="{0:t}" />
                                <asp:HyperLinkField DataNavigateUrlFields="Id" 
                                    DataNavigateUrlFormatString="Schedules.aspx?Id={0}" DataTextField="Abb" 
                                    HeaderText="Abb" />
                            </Columns>
                        </asp:GridView>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            <AlternatingRowStyle BackColor="#E8E8FF" />
        </asp:GridView>
        <br />
        <asp:LinkButton ID="lbPreWeek" runat="server">Previous Week</asp:LinkButton>
&nbsp;
        <asp:LinkButton ID="lbNextWeek" runat="server">Next Week</asp:LinkButton>
    </div>
    </form>
</body>
</html>
