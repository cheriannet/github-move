<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Invoice.aspx.vb" Inherits="Invoice" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
             <br />
             <asp:Label ID="lCaption" runat="server" Text="Pending Charges To Drop Invoice"></asp:Label>
             <br />
             Select Contact
             <asp:DropDownList ID="dContacts" runat="server" AutoPostBack="True" 
                 DataSourceID="sqlContacts" DataTextField="Name" DataValueField="Id">
             </asp:DropDownList>
             <asp:SqlDataSource ID="sqlContacts" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:LawnWorksHouston %>" 
                 
                 
                 SelectCommand="SELECT DISTINCT Contacts.Id, Contacts.Name FROM Contacts INNER JOIN Schedules ON Contacts.Id = Schedules.Client_Id WHERE (Contacts.Active = 1) AND (Schedules.Status = 'Done') AND (Schedules.Billed_On IS NULL) ORDER BY Contacts.Name">
             </asp:SqlDataSource>
             <br />
             <br />
             <asp:SqlDataSource ID="sqlPending" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:LawnWorksHouston %>" 
                 
                 
                 SelectCommand="SELECT Schedules.Client_Id, Schedules.Name, Schedules.Date, Schedules.Time, Schedules.Charge, Schedules.Workdone, Schedules.Notes, Schedules.Id AS Schedule_Id, Contacts.Charge_by, Contacts.Default_Charge FROM Schedules INNER JOIN Contacts ON Schedules.Client_Id = Contacts.Id WHERE (Schedules.Status = 'Done') AND (Schedules.Billed_On IS NULL) AND (Schedules.Billed_By IS NULL) AND (Schedules.Client_Id = @Client_Id)">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="dContacts" Name="Client_Id" 
                         PropertyName="SelectedValue" />
                 </SelectParameters>
             </asp:SqlDataSource>
             <asp:GridView ID="gPending" runat="server" AutoGenerateColumns="False" 
                 BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" 
                 CellPadding="4" DataSourceID="sqlPending" Font-Size="Small" 
                 DataKeyNames="Charge_by,Default_Charge">
                 <RowStyle BackColor="White" ForeColor="#003399" />
                 <Columns>
                     <asp:TemplateField HeaderText="Bill">
                         <ItemTemplate>
                             <asp:CheckBox ID="ckBill" runat="server" Text="Bill" />
                         </ItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Client_Id" SortExpression="Client_Id">
                         <EditItemTemplate>
                             <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Client_Id") %>'></asp:TextBox>
                         </EditItemTemplate>
                         <ItemTemplate>
                             <asp:Label ID="lClient_Id" runat="server" Text='<%# Bind("Client_Id") %>'></asp:Label>
                         </ItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Schedule_Id" InsertVisible="False" 
                         SortExpression="Schedule_Id">
                         <EditItemTemplate>
                             <asp:Label ID="Label1" runat="server" Text='<%# Eval("Schedule_Id") %>'></asp:Label>
                         </EditItemTemplate>
                         <ItemTemplate>
                             <asp:Label ID="lSchedule_Id" runat="server" Text='<%# Bind("Schedule_Id") %>'></asp:Label>
                         </ItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Date" SortExpression="Date">
                         <EditItemTemplate>
                             <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Date") %>'></asp:TextBox>
                         </EditItemTemplate>
                         <ItemTemplate>
                             <asp:Label ID="lDate" runat="server" Text='<%# Bind("Date", "{0:d}") %>'></asp:Label>
                         </ItemTemplate>
                     </asp:TemplateField>
                     <asp:BoundField DataField="Time" HeaderText="Time" 
                         SortExpression="Time" DataFormatString="{0:t}" />
                     <asp:TemplateField HeaderText="Workdone" SortExpression="Workdone">
                         <ItemTemplate>
                             <asp:TextBox ID="tWorkdone" runat="server" Text='<%# Bind("Workdone") %>' 
                                 Width="200px"></asp:TextBox>
                         </ItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Notes" SortExpression="Notes">
                         <ItemTemplate>
                             <asp:TextBox ID="tNotes" runat="server" Height="57px" 
                                 Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="225px"></asp:TextBox>
                         </ItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Charge" SortExpression="Charge">
                         <ItemTemplate>
                             <asp:TextBox ID="tCharge" runat="server" Text='<%# Bind("Charge", "{0:F}") %>' 
                                 Width="50px"></asp:TextBox>
                             <asp:RangeValidator ID="rvCharge" runat="server" ControlToValidate="tCharge" 
                                 Display="Dynamic" ErrorMessage="&lt;br/&gt;Invalid Amount" 
                                 MaximumValue="100000" MinimumValue="0" Type="Double"></asp:RangeValidator>
                         </ItemTemplate>
                     </asp:TemplateField>
                 </Columns>
                 <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                 <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                 <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                 <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
             </asp:GridView>
             <br />
             <asp:Panel ID="pMonthly" runat="server" Visible="False">
                 <table>
                     <tr>
                         <td>
                             <asp:CheckBox ID="ckMonthly" runat="server" Checked="True" 
                                 Text="Monthly Charge" />
                         </td>
                         <td>
                             &nbsp;&nbsp;&nbsp; &nbsp;</td>
                         <td>
                             Workdone :</td>
                         <td>
                             <asp:TextBox ID="tMonthlyWorkdone" runat="server" Width="150px"></asp:TextBox>
                         </td>
                         <td>
                             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
                         <td>
                             Notes :</td>
                         <td>
                             <asp:TextBox ID="tMonthlyNotes" runat="server" Width="250px"></asp:TextBox>
                         </td>
                         <td>
                             &nbsp;&nbsp; &nbsp;</td>
                         <td>
                             Charge :
                         </td>
                         <td>
                             <asp:TextBox ID="tMonthlyCharge" runat="server" Width="50px"></asp:TextBox>
                         </td>
                     </tr>
                 </table>
             </asp:Panel>
             <br />
             <asp:Button ID="bCreate" runat="server" Text="Create Invoice" />
    </center>
    </div>
    </form>
</body>
</html>
