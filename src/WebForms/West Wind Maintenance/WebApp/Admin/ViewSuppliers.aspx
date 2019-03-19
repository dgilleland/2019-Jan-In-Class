<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewSuppliers.aspx.cs" Inherits="WebApp.Admin.ViewSuppliers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-header">Suppliers</h1>
    <div class="row">
        <div class="col-md-12">
            <asp:GridView ID="SupplierGridView" runat="server" CssClass="table table-hover">
            </asp:GridView>
        </div>
    </div>
</asp:Content>
