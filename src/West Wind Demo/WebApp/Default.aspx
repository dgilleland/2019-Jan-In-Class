<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApp._Default" %>

<%@ Register Src="~/UserControls/BetaRelease.ascx" TagPrefix="uc1" TagName="BetaRelease" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>West-Wind Wholesale</h1>
        <p class="lead">This demo uses a database spun from the Northwind Trader's sample database from Microsoft.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more about ASP.Net &raquo;</a></p>
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
            <h2>Webmaster</h2>
            <p>The webmaster has access to parts of the site related to security, but not to parts that have general day-to-day business activity.</p>
            <h2>Employees</h2>
            <p>Employees can generate orders for customers and change information about products that we sell.</p>
            <h2>Customers</h2>
            <p>Customers can view their order history.</p>
            <h2>Suppliers</h2>
            <p><span class="badge">Future</span> Suppliers can offer new items that we can consider adding to our product offerings.</p>
            <hr />
            <p>
                <a class="btn btn-default" href="/About">Change your Login &raquo;</a>
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
