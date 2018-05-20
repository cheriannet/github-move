<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Contacts.aspx.vb" Inherits="Contacts" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contacts</title>
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
        <asp:SqlDataSource ID="sqlContacts" runat="server" 
            ConnectionString="<%$ ConnectionStrings:LawnWorksHouston %>" 
            DeleteCommand="DELETE FROM [Contacts] WHERE [Id] = @Id" 
            InsertCommand="INSERT INTO Contacts(Name, Service_Address, Service_City, Service_State, Service_Zip, BillTo_Address, BillTo_City, BillTo_State, BillTo_Zip, Email, Contract_Start_Date, Contract_End_Date, Default_Charge, Notes, Account_Type, Regular, Abb, Charge_by) VALUES (@Name, @Service_Address, @Service_City, @Service_State, @Service_Zip, @BillTo_Address, @BillTo_City, @BillTo_State, @BillTo_Zip, @Email, @Contract_Start_Date, @Contract_End_Date, @Default_Charge, @Notes, @Account_Type, @Regular, @Abb, @Charge_by)" 
            SelectCommand="SELECT * FROM [Contacts]" 
            
            
            
            
            UpdateCommand="UPDATE Contacts SET Name = @Name, Service_Address = @Service_Address, Service_City = @Service_City, Service_State = @Service_State, Service_Zip = @Service_Zip, BillTo_Address = @BillTo_Address, BillTo_City = @BillTo_City, BillTo_State = @BillTo_State, BillTo_Zip = @BillTo_Zip, Email = @Email, Active = @Active, Contract_Start_Date = @Contract_Start_Date, Contract_End_Date = @Contract_End_Date, Default_Charge = @Default_Charge, Notes = @Notes, Account_Type = @Account_Type, Regular = @Regular, Abb = @Abb, Charge_by = @Charge_by WHERE (Id = @Id)">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Service_Address" Type="String" />
                <asp:Parameter Name="Service_City" Type="String" />
                <asp:Parameter Name="Service_State" Type="String" />
                <asp:Parameter Name="Service_Zip" Type="String" />
                <asp:Parameter Name="BillTo_Address" Type="String" />
                <asp:Parameter Name="BillTo_City" Type="String" />
                <asp:Parameter Name="BillTo_State" Type="String" />
                <asp:Parameter Name="BillTo_Zip" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="Active" Type="Boolean" />
                <asp:Parameter Name="Contract_Start_Date" Type="DateTime" />
                <asp:Parameter Name="Contract_End_Date" Type="DateTime" />
                <asp:Parameter Name="Default_Charge" Type="Decimal" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="Account_Type" />
                <asp:Parameter Name="Regular" />
                <asp:Parameter Name="Abb" />
                <asp:Parameter Name="Charge_by" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Service_Address" Type="String" />
                <asp:Parameter Name="Service_City" Type="String" />
                <asp:Parameter Name="Service_State" Type="String" />
                <asp:Parameter Name="Service_Zip" Type="String" />
                <asp:Parameter Name="BillTo_Address" Type="String" />
                <asp:Parameter Name="BillTo_City" Type="String" />
                <asp:Parameter Name="BillTo_State" Type="String" />
                <asp:Parameter Name="BillTo_Zip" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="Contract_Start_Date" Type="DateTime" />
                <asp:Parameter Name="Contract_End_Date" Type="DateTime" />
                <asp:Parameter Name="Default_Charge" Type="Decimal" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="Account_Type" />
                <asp:Parameter Name="Regular" />
                <asp:Parameter Name="Abb" />
                <asp:Parameter Name="Charge_by" />
            </InsertParameters>
        </asp:SqlDataSource>
        <br />
        <asp:FormView ID="frmContacts" runat="server" CellPadding="4" DataKeyNames="Id" 
            DataSourceID="sqlContacts" Font-Size="Small" ForeColor="#333333">
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <InsertItemTemplate>
                <table>
                    <tr>
                        <td>
                            Client Name:
                        </td>
                        <td>
                            <asp:TextBox ID="NameTextBox" runat="server" MaxLength="250" 
                                Text='<%# Bind("Name") %>' Width="200px" />
                            <asp:RequiredFieldValidator ID="rvName" runat="server" 
                                ControlToValidate="NameTextBox" Display="Dynamic" 
                                ErrorMessage="Name is required"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            Abbreviation</td>
                        <td>
                            <asp:TextBox ID="AbbTextBox" runat="server" MaxLength="25" 
                                Text='<%# Bind("Abb") %>' Width="100px" />
                            <asp:RequiredFieldValidator ID="rvAbb" runat="server" 
                                ControlToValidate="AbbTextBox" Display="Dynamic" 
                                ErrorMessage="Abbreviation is required"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Service Address:</td>
                        <td>
                            <asp:TextBox ID="Service_AddressTextBox" runat="server" MaxLength="250" 
                                Text='<%# Bind("Service_Address") %>' Width="200px" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            Bill To Address:</td>
                        <td>
                            <asp:TextBox ID="BillTo_AddressTextBox" runat="server" MaxLength="250" 
                                Text='<%# Bind("BillTo_Address") %>' Width="200px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Service City:</td>
                        <td>
                            <asp:TextBox ID="Service_CityTextBox" runat="server" MaxLength="50" 
                                Text='<%# Bind("Service_City") %>' />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            Bill To City:
                        </td>
                        <td>
                            <asp:TextBox ID="BillTo_CityTextBox" runat="server" MaxLength="50" 
                                Text='<%# Bind("BillTo_City") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Service State:
                        </td>
                        <td>
                            <asp:TextBox ID="Service_StateTextBox" runat="server" MaxLength="50" 
                                Text='<%# Bind("Service_State") %>' Width="50px" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            Bill To State:
                        </td>
                        <td>
                            <asp:TextBox ID="BillTo_StateTextBox" runat="server" MaxLength="50" 
                                Text='<%# Bind("BillTo_State") %>' Width="50px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Service Zip:
                        </td>
                        <td>
                            <asp:TextBox ID="Service_ZipTextBox" runat="server" MaxLength="50" 
                                Text='<%# Bind("Service_Zip") %>' Width="50px" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            Bill To Zip:
                        </td>
                        <td>
                            <asp:TextBox ID="BillTo_ZipTextBox" runat="server" MaxLength="50" 
                                Text='<%# Bind("BillTo_Zip") %>' Width="50px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Email:</td>
                        <td>
                            <asp:TextBox ID="EmailTextBox" runat="server" MaxLength="150" 
                                Text='<%# Bind("Email") %>' Width="200px" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Contract_Start_Date:</td>
                        <td>
                            <asp:TextBox ID="Contract_Start_DateTextBox" runat="server" 
                                Text='<%# Bind("Contract_Start_Date") %>' Width="70px" />
                            <asp:RangeValidator ID="rvStartDate" runat="server" 
                                ControlToValidate="Contract_Start_DateTextBox" 
                                ErrorMessage="Invalid Start Date" MaximumValue="1/1/2100" 
                                MinimumValue="1/1/1900" Type="Date"></asp:RangeValidator>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            Contract_End_Date:</td>
                        <td>
                            <asp:TextBox ID="Contract_End_DateTextBox" runat="server" 
                                Text='<%# Bind("Contract_End_Date") %>' Width="70px" />
                            <asp:RangeValidator ID="rvEndDate" runat="server" 
                                ControlToValidate="Contract_End_DateTextBox" ErrorMessage="Invalid End Date" 
                                MaximumValue="1/1/2100" MinimumValue="1/1/1900" Type="Date"></asp:RangeValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Default Charge:</td>
                        <td>
                            <asp:TextBox ID="Default_ChargeTextBox" runat="server" 
                                Text='<%# Bind("Default_Charge") %>' Width="70px" />
                            <asp:RangeValidator ID="rvCharge" runat="server" 
                                ControlToValidate="Default_ChargeTextBox" ErrorMessage="Invalid Amount" 
                                MaximumValue="100000" MinimumValue="0" Type="Currency"></asp:RangeValidator>
                            <asp:RequiredFieldValidator ID="rqCharge" runat="server" 
                                ControlToValidate="Default_ChargeTextBox" Display="Dynamic" 
                                ErrorMessage="Default Charge is required"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            Regular</td>
                        <td>
                            <asp:TextBox ID="RegularTextbox" runat="server" Text='<%# Bind("Regular") %>' 
                                Width="40px"></asp:TextBox>
                            &nbsp;Days&nbsp;<asp:RangeValidator ID="rvRegular" runat="server" 
                                ControlToValidate="RegularTextbox" ErrorMessage="Invalid Number" 
                                MaximumValue="300" MinimumValue="0" Type="Integer"></asp:RangeValidator>
                            <asp:RequiredFieldValidator ID="rqRegular" runat="server" 
                                ControlToValidate="RegularTextbox" Display="Dynamic" 
                                ErrorMessage="Please type 0 Or  # of days"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Charge_By:</td>
                        <td>
                            <asp:DropDownList ID="ChargeBy" runat="server" 
                                SelectedValue='<%# Bind("Charge_by") %>'>
                                <asp:ListItem>Appointment</asp:ListItem>
                                <asp:ListItem>Month</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            Account_Type</td>
                        <td>
                            <asp:DropDownList ID="Account_TypeDropDownList" runat="server" 
                                SelectedValue='<%# Bind("Account_Type") %>'>
                                <asp:ListItem>Residential</asp:ListItem>
                                <asp:ListItem>Commercial</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Notes:</td>
                        <td colspan="3">
                            <asp:TextBox ID="NotesTextBox" runat="server" Height="101px" 
                                Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="366px" />
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
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
                        <td>
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                CommandName="Insert" Text="Add Contact" />
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                                CommandName="Cancel" Text="Cancel" />
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
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
                </table>
                &nbsp;
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                    CommandName="New" Text="Add New Contact" />
            </ItemTemplate>
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <EmptyDataTemplate>
                <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                    CommandName="New" Text="Add New Contact" />
            </EmptyDataTemplate>
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#999999" />
        </asp:FormView>
        <br />
        <asp:GridView ID="gContacts" runat="server" AutoGenerateColumns="False" 
            BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" DataKeyNames="Id" DataSourceID="sqlContacts" Font-Size="Small">
            <RowStyle BackColor="White" ForeColor="#003399" />
            <Columns>
                <asp:CommandField ButtonType="Button" CancelText="Close" EditText="View Detail" 
                    ShowEditButton="True" />
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" 
                    ReadOnly="True" SortExpression="Id" />
                <asp:TemplateField SortExpression="Name">
                    <EditItemTemplate>
                        <table>
                            <tr>
                                <td>
                                    Client Name:
                                </td>
                                <td>
                                    <asp:TextBox ID="NameTextBox" runat="server" MaxLength="250" 
                                        Text='<%# Bind("Name") %>' Width="200px" />
                                    <asp:RequiredFieldValidator ID="rvName" runat="server" 
                                        ControlToValidate="NameTextBox" Display="Dynamic" 
                                        ErrorMessage="Name is required"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    Abbreviation</td>
                                <td>
                                    <asp:TextBox ID="AbbTextBox" runat="server" MaxLength="25" 
                                        Text='<%# Bind("Abb") %>' Width="100px" />
                                    <asp:RequiredFieldValidator ID="rvAbb" runat="server" 
                                        ControlToValidate="AbbTextBox" Display="Dynamic" 
                                        ErrorMessage="Abbreviation is required"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Service Address:</td>
                                <td>
                                    <asp:TextBox ID="Service_AddressTextBox" runat="server" MaxLength="250" 
                                        Text='<%# Bind("Service_Address") %>' Width="200px" />
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    Bill To Address:</td>
                                <td>
                                    <asp:TextBox ID="BillTo_AddressTextBox" runat="server" MaxLength="250" 
                                        Text='<%# Bind("BillTo_Address") %>' Width="200px" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Service City:</td>
                                <td>
                                    <asp:TextBox ID="Service_CityTextBox" runat="server" MaxLength="50" 
                                        Text='<%# Bind("Service_City") %>' />
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    Bill To City:
                                </td>
                                <td>
                                    <asp:TextBox ID="BillTo_CityTextBox" runat="server" 
                                        Text='<%# Bind("BillTo_City") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Service State:
                                </td>
                                <td>
                                    <asp:TextBox ID="Service_StateTextBox" runat="server" 
                                        Text='<%# Bind("Service_State") %>' Width="50px" />
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    Bill To State:
                                </td>
                                <td>
                                    <asp:TextBox ID="BillTo_StateTextBox" runat="server" 
                                        Text='<%# Bind("BillTo_State") %>' Width="50px" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Service Zip:
                                </td>
                                <td>
                                    <asp:TextBox ID="Service_ZipTextBox" runat="server" 
                                        Text='<%# Bind("Service_Zip") %>' Width="50px" />
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    Bill To Zip:
                                </td>
                                <td>
                                    <asp:TextBox ID="BillTo_ZipTextBox" runat="server" 
                                        Text='<%# Bind("BillTo_Zip") %>' Width="50px" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Email:</td>
                                <td>
                                    <asp:TextBox ID="EmailTextBox" runat="server" MaxLength="150" 
                                        Text='<%# Bind("Email") %>' Width="200px" />
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    Active:
                                </td>
                                <td>
                                    <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                                        Checked='<%# Bind("Active") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Contract_Start_Date:</td>
                                <td>
                                    <asp:TextBox ID="Contract_Start_DateTextBox" runat="server" 
                                        Text='<%# Bind("Contract_Start_Date", "{0:d}") %>' Width="70px" />
                                    <asp:RangeValidator ID="rvStartDate" runat="server" 
                                        ControlToValidate="Contract_Start_DateTextBox" 
                                        ErrorMessage="Invalid Start Date" MaximumValue="1/1/2100" 
                                        MinimumValue="1/1/1900" Type="Date"></asp:RangeValidator>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    Contract_End_Date:</td>
                                <td>
                                    <asp:TextBox ID="Contract_End_DateTextBox" runat="server" 
                                        Text='<%# Bind("Contract_End_Date", "{0:d}") %>' Width="70px" />
                                    <asp:RangeValidator ID="rvEndDate" runat="server" 
                                        ControlToValidate="Contract_End_DateTextBox" ErrorMessage="Invalid End Date" 
                                        MaximumValue="1/1/2100" MinimumValue="1/1/1900" Type="Date"></asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Default Charge:</td>
                                <td>
                                    <asp:TextBox ID="Default_ChargeTextBox" runat="server" 
                                        Text='<%# Bind("Default_Charge", "{0:F}") %>' Width="70px" />
                                    <asp:RangeValidator ID="rvCharge" runat="server" 
                                        ControlToValidate="Default_ChargeTextBox" ErrorMessage="Invalid Amount" 
                                        MaximumValue="100000" MinimumValue="0" Type="Currency"></asp:RangeValidator>
                                    <asp:RequiredFieldValidator ID="rqCharge" runat="server" 
                                        ControlToValidate="Default_ChargeTextBox" Display="Dynamic" 
                                        ErrorMessage="Default Charge is required"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    Regular</td>
                                <td>
                                    <asp:TextBox ID="RegularTextbox" runat="server" Text='<%# Bind("Regular") %>' 
                                        Width="40px"></asp:TextBox>
                                    &nbsp;Days
                                    <asp:RangeValidator ID="rvRegular" runat="server" 
                                        ControlToValidate="RegularTextbox" ErrorMessage="Invalid Number" 
                                        MaximumValue="300" MinimumValue="0" Type="Integer"></asp:RangeValidator>
                                    <asp:RequiredFieldValidator ID="rqRegular" runat="server" 
                                        ControlToValidate="RegularTextbox" Display="Dynamic" 
                                        ErrorMessage="Please type 0 Or  # of days"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Charge_By</td>
                                <td>
                                    <asp:DropDownList ID="ChargeBy" runat="server" 
                                        SelectedValue='<%# Bind("Charge_by") %>'>
                                        <asp:ListItem>Appointment</asp:ListItem>
                                        <asp:ListItem>Month</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    Account_Type</td>
                                <td>
                                    <asp:DropDownList ID="Account_TypeDropDownList" runat="server" 
                                        SelectedValue='<%# Bind("Account_Type") %>'>
                                        <asp:ListItem>Residential</asp:ListItem>
                                        <asp:ListItem>Commercial</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Notes:</td>
                                <td colspan="3">
                                    <asp:TextBox ID="NotesTextBox" runat="server" Height="101px" 
                                        Text='<%# Bind("Notes") %>' TextMode="MultiLine" Width="366px" />
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
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
                        </table>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lName" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="500px" />
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
        </asp:GridView>
    </div>
    </form>
</body>
</html>
