<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1 {
            color: #FFFFFF;
            font-weight: bold;
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
        <br />
        <br />
        <table id="tblLogin" runat="server">
            <tr>
                <td bgcolor="#003399" class="style1" colspan="2">
                    Login</td>
            </tr>
            <tr>
                <td align="left">
                    Username :&nbsp;&nbsp;
                </td>
                <td align="left">
                    <asp:TextBox ID="tUsername" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="left">
                    Password :
                </td>
                <td align="left">
                    <asp:TextBox ID="tPassword" runat="server" TextMode="Password"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:CheckBox ID="chkPersistLogin" runat="server" Text="Remember Me" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="bLogin" runat="server" Text="Login" />
&nbsp;
                    <asp:Button ID="bCancel" runat="server" Text="Cancel" />
                </td>
            </tr>
        </table>
        &nbsp;<asp:Label ID="lError" runat="server" ForeColor="Red"></asp:Label>
    </center>
    </div>
    </form>
</body>
</html>
