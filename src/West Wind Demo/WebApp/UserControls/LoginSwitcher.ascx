<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginSwitcher.ascx.cs" Inherits="WebApp.UserControls.LoginSwitcher" %>

<div>
    <h2>Login Switcher</h2>
    <asp:LoginView ID="LoginView" runat="server" ViewStateMode="Disabled">
        <AnonymousTemplate>
            <div class="row">
                <div class="col-md-4">
                    <asp:RadioButtonList ID="RoleList" runat="server" AutoPostBack="True"
                        DataSourceID="RoleDataSource" DataTextField="Text" DataValueField="Value"
                        CssClass="spaced" RepeatLayout="Flow" RepeatDirection="Horizontal"></asp:RadioButtonList>
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="UserList" runat="server" AppendDataBoundItems="true" CssClass="form-control"
                        DataSourceID="UserDataSource" DataTextField="Text" DataValueField="Value">
                        <asp:ListItem Value="">[Select a User]</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <asp:LinkButton ID="UserLogin" runat="server" Text="Login as user"
                        CssClass="btn btn-primary" OnClick="UserLogin_Click" />
                </div>
            </div>
            <asp:ObjectDataSource runat="server" ID="UserDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="ListUsers" TypeName="WebApp.UserControls.LoginController">
                <SelectParameters>
                    <asp:ControlParameter ControlID="RoleList" PropertyName="SelectedValue" Name="roleId" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource runat="server" ID="RoleDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="ListRoles" TypeName="WebApp.UserControls.LoginController"></asp:ObjectDataSource>
        </AnonymousTemplate>
        <LoggedInTemplate>
            You are logged in as <b><%: Context.User.Identity.GetUserName()  %></b>.
                <asp:LoginStatus runat="server" CssClass="btn btn-info" LogoutAction="Refresh"
                    LogoutText="Log off" OnLoggingOut="Unnamed_LoggingOut" />
        </LoggedInTemplate>
    </asp:LoginView>
    <style>
        .spaced label {
            margin-left: 2px;
            margin-right: 10px;
        }
    </style>
</div>
