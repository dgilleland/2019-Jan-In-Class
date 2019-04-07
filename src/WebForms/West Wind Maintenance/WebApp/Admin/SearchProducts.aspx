<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchProducts.aspx.cs" Inherits="WebApp.Admin.SearchProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <h1 class="page-header">Search Products Page</h1>
    </div>

    <div class="row">
        <asp:HiddenField ID="SearchBy" runat="server" />
        <div class="col-md-4">
            <h3>Find by Category</h3>
            <asp:DropDownList ID="CategoryDropDown" runat="server" CssClass="form-control"></asp:DropDownList>
            <asp:LinkButton ID="LookupByCategory" runat="server"
                CssClass="btn btn-default" OnClick="LookupByCategory_Click">Lookup</asp:LinkButton>
        </div>
        <div class="col-md-4">
            <h3>Find by Supplier</h3>
            <asp:DropDownList ID="SupplierDropDown" runat="server" CssClass="form-control"></asp:DropDownList>
            <asp:LinkButton ID="LookupBySupplier" runat="server"
                CssClass="btn btn-default" OnClick="LookupBySupplier_Click">Lookup</asp:LinkButton>
        </div>
        <div class="col-md-4">
            <h3>Find by Product Name <small class="fas fa-biohazard"></small></h3>
            <asp:TextBox ID="PartialName" runat="server" CssClass="form-control" placeholder="SQL Injection Vulnerable" />
            <asp:LinkButton ID="LookupByName" runat="server"
                 OnClick="LookupByName_Click" CssClass="btn btn-default">Lookup Products</asp:LinkButton>
             <pre>';UPDATE Products SET UnitPrice = 0;--</pre>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <asp:Panel ID="MessagePanel" runat="server" Visible="false" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="MessageLabel" runat="server" />
            </asp:Panel>
            <asp:RadioButtonList ID="SearchFilter" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" CssClass="table"></asp:RadioButtonList>
            <asp:GridView ID="SearchResultsGridView" runat="server"
                ItemType="WestWindModels.Product" AutoGenerateColumns="False" AllowPaging="True" PageSize="5" OnPageIndexChanging="SearchResultsGridView_PageIndexChanging"
                CssClass="table table-hover table-condensed">
                <Columns>
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name"></asp:BoundField>
                    <asp:BoundField DataField="QuantityPerUnit" HeaderText="Qty/Unit" />
                    <asp:BoundField DataField="UnitPrice" HeaderText="Price" DataFormatString="{0:c}" />
                    <asp:BoundField DataField="UnitsOnOrder" HeaderText="On Order" />
                </Columns>
                <EmptyDataTemplate>No products for the selected search.</EmptyDataTemplate>
                <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" PageButtonCount="2" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
