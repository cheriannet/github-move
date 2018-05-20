<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Billing.aspx.vb" Inherits="Billing" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
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
         <table class="style1">
             <tr>
                 <td>
                     Select Contact
                     <asp:DropDownList ID="dContacts" runat="server" AutoPostBack="True" 
                         DataSourceID="sqlContacts" DataTextField="Name" DataValueField="Id">
                     </asp:DropDownList>
                     <asp:SqlDataSource ID="sqlContacts" runat="server" 
                         ConnectionString="<%$ ConnectionStrings:LawnWorksHouston %>" 
                         SelectCommand="SELECT [Id], [Name] FROM [Contacts] WHERE ([Active] = 1) ORDER BY [Name]">
                     </asp:SqlDataSource>
                 </td>
                 <td>
                     <asp:HyperLink ID="hInvoice" runat="server" NavigateUrl="~/Invoice.aspx">Pending Charges</asp:HyperLink>
                 </td>
             </tr>
         </table>
         
         <asp:SqlDataSource ID="sqlInvoices" runat="server" 
             ConnectionString="<%$ ConnectionStrings:LawnWorksHouston %>" 
             SelectCommand="SELECT Invoice.Id, Invoice.Inv_Date, Invoice.Bill_To_Address, Invoice.Bill_To_City, Invoice.Bill_To_State, Invoice.Bill_To_Zip, SUM(Invoice_Detail.Charge) AS Amount, Invoice.Paid, Invoice.Paid_On FROM Invoice INNER JOIN Invoice_Detail ON Invoice.Id = Invoice_Detail.Inv_Id WHERE (Invoice.Client_Id = @Id) GROUP BY Invoice.Id, Invoice.Inv_Date, Invoice.Bill_To_Address, Invoice.Bill_To_City, Invoice.Bill_To_State, Invoice.Bill_To_Zip, Invoice.Paid, Invoice.Paid_On ORDER BY Invoice.Paid, Invoice.Inv_Date DESC" 
             UpdateCommand="UPDATE Invoice SET Paid = @Paid, Paid_On = @Paid_On WHERE (Id = @Id)">
             <SelectParameters>
                 <asp:ControlParameter ControlID="dContacts" Name="Id" 
                     PropertyName="SelectedValue" />
             </SelectParameters>
             <UpdateParameters>
                 <asp:Parameter Name="Paid" />
                 <asp:Parameter Name="Paid_On" />
                 <asp:Parameter Name="Id" />
             </UpdateParameters>
         </asp:SqlDataSource>
         <br />
         <asp:GridView ID="gInvoice" runat="server" AutoGenerateColumns="False" 
             BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" 
             CellPadding="4" DataKeyNames="Id" DataSourceID="sqlInvoices" Font-Size="Small">
             <RowStyle BackColor="White" ForeColor="#003399" />
             <Columns>
                 <asp:CommandField ShowEditButton="True" />
                 <asp:HyperLinkField DataNavigateUrlFields="Id" 
                     DataNavigateUrlFormatString="Print_Invoice.aspx?Id={0}" HeaderText="Print" 
                     Target="_blank" Text="Print" />
                 <asp:TemplateField HeaderText="Invoice Number" InsertVisible="False" 
                     SortExpression="Id">
                     <EditItemTemplate>
                         <asp:Label ID="lId" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lId" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:BoundField DataField="Inv_Date" DataFormatString="{0:d}" 
                     HeaderText="Inv_Date" ReadOnly="True" SortExpression="Inv_Date" />
                 <asp:TemplateField HeaderText="Bill_To_Address" 
                     SortExpression="Bill_To_Address">
                     <EditItemTemplate>
                         <asp:Label ID="lAddress" runat="server" Text='<%# Bind("Bill_To_Address") %>'></asp:Label>
                         ,<asp:Label ID="lCity" runat="server" Text='<%# Bind("Bill_To_City") %>'></asp:Label>
                         ,<asp:Label ID="lState" runat="server" Text='<%# Bind("Bill_To_State") %>'></asp:Label>
                         &nbsp;-
                         <asp:Label ID="lZip" runat="server" Text='<%# Bind("Bill_To_Zip") %>'></asp:Label>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lAddress" runat="server" Text='<%# Bind("Bill_To_Address") %>'></asp:Label>
                         ,<asp:Label ID="lCity" runat="server" Text='<%# Bind("Bill_To_City") %>'></asp:Label>
                         ,<asp:Label ID="lState" runat="server" Text='<%# Bind("Bill_To_State") %>'></asp:Label>
                         &nbsp;-
                         <asp:Label ID="lZip" runat="server" Text='<%# Bind("Bill_To_Zip") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:BoundField DataField="Amount" DataFormatString="{0:c}" HeaderText="Amount" 
                     ReadOnly="True" SortExpression="Amount" />
                 <asp:CheckBoxField DataField="Paid" HeaderText="Paid" SortExpression="Paid" />
                 <asp:TemplateField HeaderText="Paid_On" SortExpression="Paid_On">
                     <EditItemTemplate>
                         <asp:Label ID="lPaid_On" runat="server" Text='<%# Bind("Paid_On", "{0:d}") %>'></asp:Label>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lPaid_On" runat="server" Text='<%# Bind("Paid_On", "{0:d}") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Notes">
                     <EditItemTemplate>
                         <asp:TextBox ID="tNotes" runat="server" Height="60px" TextMode="MultiLine" 
                             Width="240px"></asp:TextBox>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:TextBox ID="tNotes" runat="server" Height="60px" ReadOnly="True" 
                             TextMode="MultiLine" Width="240px"></asp:TextBox>
                     </ItemTemplate>
                 </asp:TemplateField>
             </Columns>
             <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
             <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
             <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
             <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
         </asp:GridView>
    </center>

    
    </div>
    </form>
</body>
</html>
