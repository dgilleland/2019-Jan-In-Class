<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebApp.About" %>

<%@ Register Src="~/UserControls/BetaRelease.ascx" TagPrefix="my" TagName="BetaRelease" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <h3>Your application description page.</h3>
    <my:BetaRelease runat="server" id="BetaRelease" />
    <p>Use this area to provide additional information.</p>
</asp:Content>
