<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebApp.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %> - Demo Setup.</h2>
    <p>To set up the database for this demo, open the <b>Package Manager Console</b> under the <i>Tools > NuGet Package Manager</i> menu option in Visual Studio. Inside the console, ensure the "Default project" is set to "EyeMaxBooking", and run the following in the console: <code>update-database</code></p>
</asp:Content>
