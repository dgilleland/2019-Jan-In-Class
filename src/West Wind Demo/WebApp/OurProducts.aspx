<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OurProducts.aspx.cs" Inherits="WebApp.OurProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-header">Our Products</h1>

    <div class="row">
        <div class="col-md-12">
            <asp:Repeater ID="CategoryRepeater" runat="server"
                 DataSourceID="CategoryDataSource"
                 ItemType="WestWindSystem.DataModels.ProductCategory">
                <ItemTemplate>
                    <img style="float:left;height:30px; margin-right:7px;"
                         src="data:image/png;base64,<%# Convert.ToBase64String(Item.Picture) %>" />
                    <h3><%# Item.CategoryName %></h3>
                    <p><%# Item.Description %></p>
                    <blockquote>
                        <asp:Repeater ID="ProductRepeater" runat="server"
                             DataSource="<%# Item.Products %>"
                             ItemType="WestWindSystem.DataModels.ProductSummary">
                            <HeaderTemplate>
                                <table class="table table-hover table-condensed">
                            </HeaderTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                            <ItemTemplate>
                                <tr>
                                    <th class="col-md-3"><%# Item.Name %></th>
                                    <th class="col-md-2" style="text-align: right;"><%# $"{Item.Price:C}" %></th>
                                    <th class="col-md-1"></th>
                                    <th class="col-md-6"><%# Item.Quantity %></th>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </blockquote>
                </ItemTemplate>
            </asp:Repeater>

            <asp:ObjectDataSource ID="CategoryDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="ListCurrentProducts" TypeName="WestWindSystem.BLL.ProductManagementController"></asp:ObjectDataSource>
        </div>
    </div>
</asp:Content>
