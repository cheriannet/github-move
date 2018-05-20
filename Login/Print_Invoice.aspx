<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Print_Invoice.aspx.vb" Inherits="Print_Invoice" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Print Invoice</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
            text-align:left;
            vertical-align:text-top;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center>
        <table>
            <tr>
                <td align="center">
                    <asp:ImageButton ID="iLogo" runat="server" ImageUrl="~/Images/Logo.jpg" />
                    <br />
                    <asp:Label ID="lAddress1" runat="server" Font-Names="Verdana" 
                        Text="21611 Harveys Way"></asp:Label> 
                    <br />
                   <asp:Label ID="lAddress2" runat="server" Font-Names="Verdana" 
                        Text="Humble, TX 77338"></asp:Label> 
                    <br />
                 <asp:Label ID="lPhone" runat="server" Font-Names="Verdana" Text="281-745-4358"></asp:Label>
                    <br />
                    <br />
                    <table class="style1">
                        <tr>
                            <td valign="top">
                                <asp:Label ID="lClient_Name_Label" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small" Text="Client Name :" Font-Bold="True"></asp:Label>
                            </td>
                            <td valign="top">
                                <asp:Label ID="lClient_Name" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                &nbsp;&nbsp;</td>
                            <td>
                                <asp:Label ID="lAccount_Type_Label" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small" Font-Bold="True">Account Type</asp:Label>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <asp:Label ID="lService_Address_Label" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small" Font-Bold="True">Service Address :</asp:Label>
                            </td>
                            <td valign="top">
                                <asp:Label ID="lService_Address" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small"></asp:Label>
                            </td>
                            <td valign="top">
                                &nbsp;</td>
                            <td valign="top">
                                <asp:Label ID="lAccount_Type" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small"></asp:Label>
                            </td>
                            <td valign="top">
                                <asp:Label ID="lRegular" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td valign="top">
                                &nbsp;</td>
                            <td valign="top">
                                <asp:Label ID="lInvoiceNo_Label" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small" Font-Bold="True">Invoice Number :</asp:Label>
                            </td>
                            <td valign="top">
                                <asp:Label ID="lInvoice_No" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <asp:Label ID="lBill_To_Address_Label" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small" Font-Bold="True">Bill  To Address :</asp:Label>
                            </td>
                            <td valign="top">
                                <asp:Label ID="lBill_To_Address" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small"></asp:Label>
                            </td>
                            <td valign="top">
                                &nbsp;</td>
                            <td valign="top">
                                <asp:Label ID="lInvoiceDate" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small" Font-Bold="True">Invoice Date :</asp:Label>
                            </td>
                            <td valign="top">
                                <asp:Label ID="lInvoice_Date" runat="server" Font-Names="Verdana" 
                                    Font-Size="Small"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    &nbsp;<asp:SqlDataSource ID="sqlDetail" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:LawnWorksHouston %>" 
                        
                        SelectCommand="SELECT Id, Date, Workdone, Notes, Charge FROM Invoice_Detail WHERE (Inv_Id = @Inv_Id)" 
                        DeleteCommand="DELETE FROM [Invoice_Detail] WHERE [Id] = @Id" 
                        InsertCommand="INSERT INTO [Invoice_Detail] ([Inv_Id], [Schedule_Id], [Date], [Workdone], [Notes], [Charge]) VALUES (@Inv_Id, @Schedule_Id, @Date, @Workdone, @Notes, @Charge)" 
                        UpdateCommand="UPDATE [Invoice_Detail] SET [Inv_Id] = @Inv_Id, [Schedule_Id] = @Schedule_Id, [Date] = @Date, [Workdone] = @Workdone, [Notes] = @Notes, [Charge] = @Charge WHERE [Id] = @Id">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="Inv_Id" QueryStringField="Id" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="Id" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Inv_Id" Type="Int32" />
                            <asp:Parameter Name="Schedule_Id" Type="Int32" />
                            <asp:Parameter DbType="Date" Name="Date" />
                            <asp:Parameter Name="Workdone" Type="String" />
                            <asp:Parameter Name="Notes" Type="String" />
                            <asp:Parameter Name="Charge" Type="Decimal" />
                            <asp:Parameter Name="Id" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Inv_Id" Type="Int32" />
                            <asp:Parameter Name="Schedule_Id" Type="Int32" />
                            <asp:Parameter DbType="Date" Name="Date" />
                            <asp:Parameter Name="Workdone" Type="String" />
                            <asp:Parameter Name="Notes" Type="String" />
                            <asp:Parameter Name="Charge" Type="Decimal" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="gDetail" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="Charge,Id" DataSourceID="sqlDetail" Font-Bold="False" 
                        Font-Size="Small" ShowFooter="True" Width="100%">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" />
                            <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" 
                                SortExpression="Date" />
                            <asp:BoundField DataField="Workdone" HeaderText="Workdone" 
                                SortExpression="Workdone" />
                            <asp:BoundField DataField="Notes" FooterText="Total" HeaderText="Notes" 
                                SortExpression="Notes" />
                            <asp:BoundField DataField="Charge" DataFormatString="{0:c}" HeaderText="Amount" 
                                SortExpression="Charge" />
                        </Columns>
                        <FooterStyle Font-Bold="True" />
                    </asp:GridView>
                    
                </td>
            </tr>
        </table>
        <br />
        <br />
    </center>
    </div>
    </form>
</body>
</html>
