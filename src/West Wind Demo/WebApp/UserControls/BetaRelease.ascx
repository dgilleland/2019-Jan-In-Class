<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BetaRelease.ascx.cs" Inherits="WebApp.UserControls.BetaRelease" %>

<div id="ReleaseInfo" runat="server" class="beta">
    Beta Release
    <asp:TextBox ID="SignUp" runat="server" CssClass="form-content black" placeholder="Sign up with email" />
    <asp:LinkButton ID="RegisterForUpdates" runat="server" CssClass="btn btn-primary">Register for Beta Access</asp:LinkButton>

</div>

<style>
    .black {
        color:black;
    }
    .beta {
        font-style: italic; background-color: orangered; color: white; font-weight:bold;
    }
</style>