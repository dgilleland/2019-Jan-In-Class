<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchProductsByPrice.aspx.cs" Inherits="WebApp.Admin.SearchProductsByPrice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-header">
        Search Products by Price
        <asp:LinkButton ID="Lookup" runat="server" Text="Lookup Products" CssClass="btn btn-primary" />
    </h1>
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <asp:Label ID="Label1" runat="server" Text="Minimum" AssociatedControlID="MinPrice" />
                <asp:TextBox ID="MinPrice" runat="server" Text="0" />
                <asp:Label ID="Label2" runat="server" Text="Maximum" AssociatedControlID="MaxPrice" />
                <asp:TextBox ID="MaxPrice" runat="server" Text="150" />
            </fieldset>
            <hr />
            <asp:GridView ID="ProductsGridView" runat="server"
                AutoGenerateColumns="False" DataSourceID="ProductsDataSource"
                DataKeyNames="ProductID" CssClass="table table-condensed table-hover" AllowPaging="True">
                <Columns>
                    <asp:CommandField ShowSelectButton="True"></asp:CommandField>
                    <asp:BoundField DataField="ProductName" HeaderText="Product"></asp:BoundField>
                    <asp:BoundField DataField="SupplierID" HeaderText="Supplier"></asp:BoundField>
                    <asp:BoundField DataField="CategoryID" HeaderText="Category"></asp:BoundField>
                    <asp:BoundField DataField="QuantityPerUnit" HeaderText="Qty Per Unit"></asp:BoundField>
                    <asp:BoundField DataField="MinimumOrderQuantity" HeaderText="Min Order Qty"></asp:BoundField>
                    <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price" DataFormatString="{0:c}"></asp:BoundField>
                    <asp:BoundField DataField="UnitsOnOrder" HeaderText="On Order"></asp:BoundField>
                    <asp:CheckBoxField DataField="Discontinued" HeaderText="Discontinued"></asp:CheckBoxField>
                </Columns>
            </asp:GridView>

            <asp:ObjectDataSource ID="ProductsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetProductsByPriceRange" TypeName="WestWindSystem.BLL.ProductController">
                <SelectParameters>
                    <asp:ControlParameter ControlID="MinPrice" PropertyName="Text" Name="minValue" Type="Decimal"></asp:ControlParameter>
                    <asp:ControlParameter ControlID="MaxPrice" PropertyName="Text" Name="maxValue" Type="Decimal"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </div>
    <link href="../Content/bootwrap-freecode.css" rel="stylesheet" />
    <script src="../Scripts/bootwrap-freecode.js"></script>
</asp:Content>
