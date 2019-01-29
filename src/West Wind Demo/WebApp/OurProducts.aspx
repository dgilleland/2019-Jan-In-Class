<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OurProducts.aspx.cs" Inherits="WebApp.OurProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-header">Our Products</h1>

    <div class="row">
        <div class="col-md-12">
            <asp:Repeater ID="CategoryRepeater" runat="server"
                 DataSourceID="CategoryDataSource"
                 ItemType="WestWindSystem.DataModels.ProductCategory">
                <ItemTemplate>
                    <h3><%# Item.CategoryName %></h3>
                </ItemTemplate>
            </asp:Repeater>

            <asp:ObjectDataSource ID="CategoryDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="ListCurrentProducts" TypeName="WestWindSystem.BLL.ProductManagementController"></asp:ObjectDataSource>
        </div>
    </div>
</asp:Content>
