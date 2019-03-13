<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApp._Default" %>

<%@ Register Src="~/UserControls/BetaRelease.ascx" TagPrefix="uc1" TagName="BetaRelease" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>West-Wind Wholesale</h1>
        <p class="lead">This demo uses a database spun from the Northwind Trader's sample database from Microsoft.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>

    <div class="row">
        <div class="col-md-6">
            <h2>The Database</h2>
            <uc1:BetaRelease runat="server" ID="BetaRelease" CssClass="bg-info" />
            <p>The following ERD represents the entire database schema.</p>
            <a href="/Images/Diagrams-WestWindERD.png" data-toggle="lightbox" data-title="West Wind ERD">
                <img src="/Images/Diagrams-WestWindERD.png" class="img-responsive" />
            </a>
        </div>
        <div class="col-md-6">
            <h2>Get more libraries</h2>
            <p>
                NuGet is a free Visual Studio extension that makes it easy to add, remove, and update libraries and tools in Visual Studio projects.
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301949">Learn more &raquo;</a>
            </p>
        </div>
    </div>
    <link href="Scripts/Bootstrap-Lightbox/ekko-lightbox.min.css" rel="stylesheet" />
    <script src="Scripts/Bootstrap-Lightbox/ekko-lightbox.min.js"></script>
    <script>
        $(document).ready(function () {
            $(document).on('click', '[data-toggle="lightbox"]', function (event) {
                event.preventDefault();
                $(this).ekkoLightbox();
            });
        });
    </script>
</asp:Content>
