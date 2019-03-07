<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebApp.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <h3>Your application description page.</h3>
    <p>Use this area to provide additional information.</p>

    <div class="row">
        <div class="col-md-12">
            <asp:Label ID="MessageLabel" runat="server" />
            <asp:TextBox ID="UserReply" runat="server" />
            <asp:LinkButton ID="RespondToUser" runat="server"
                 Text="Tell me something" OnClick="RespondToUser_Click" />
            <br />
            <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
            <asp:LinkButton ID="TellUserBirthdate" runat="server" OnClick="TellUserBirthdate_Click">Tell me your birthdate.</asp:LinkButton>
        </div>
    </div>
</asp:Content>
