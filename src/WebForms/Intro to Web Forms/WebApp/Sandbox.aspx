<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sandbox.aspx.cs" Inherits="WebApp.Sandbox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-header">Sandbox Page</h1>

    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <asp:Label ID="Label1" runat="server" Text="First Name"
                    AssociatedControlID="FirstName"></asp:Label>
                <asp:TextBox ID="FirstName" runat="server"></asp:TextBox>

                <asp:Label ID="Label2" runat="server" Text="Last Name"
                    AssociatedControlID="LastName"></asp:Label>
                <asp:TextBox ID="LastName" runat="server"></asp:TextBox>

                <asp:Label ID="Label3" runat="server" Text="Date of Birth"
                    AssociatedControlID="DOB"></asp:Label>
                <asp:TextBox ID="DOB" runat="server"></asp:TextBox>

                <asp:Label ID="Label4" runat="server" Text="Home Town"
                    AssociatedControlID="HomeCity"></asp:Label>
                <asp:TextBox ID="HomeCity" runat="server"></asp:TextBox>
            </fieldset>
        </div>
    </div>
    <script src="Scripts/bootwrap-freecode.js"></script>
</asp:Content>
