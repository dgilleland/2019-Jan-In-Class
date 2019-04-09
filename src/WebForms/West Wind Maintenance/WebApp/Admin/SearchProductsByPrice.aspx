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
            <asp:GridView ID="ProductsGridView" runat="server" AutoGenerateColumns="False" DataSourceID="ProductsDataSource">
                <Columns>
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" SortExpression="ProductID"></asp:BoundField>
                    <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName"></asp:BoundField>
                    <asp:BoundField DataField="SupplierID" HeaderText="SupplierID" SortExpression="SupplierID"></asp:BoundField>
                    <asp:BoundField DataField="CategoryID" HeaderText="CategoryID" SortExpression="CategoryID"></asp:BoundField>
                    <asp:BoundField DataField="QuantityPerUnit" HeaderText="QuantityPerUnit" SortExpression="QuantityPerUnit"></asp:BoundField>
                    <asp:BoundField DataField="MinimumOrderQuantity" HeaderText="MinimumOrderQuantity" SortExpression="MinimumOrderQuantity"></asp:BoundField>
                    <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" SortExpression="UnitPrice"></asp:BoundField>
                    <asp:BoundField DataField="UnitsOnOrder" HeaderText="UnitsOnOrder" SortExpression="UnitsOnOrder"></asp:BoundField>
                    <asp:CheckBoxField DataField="Discontinued" HeaderText="Discontinued" SortExpression="Discontinued"></asp:CheckBoxField>
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
