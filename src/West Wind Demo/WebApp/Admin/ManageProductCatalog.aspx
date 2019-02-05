<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageProductCatalog.aspx.cs" Inherits="WebApp.Admin.ManageProductCatalog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-header">Manage Product Catalog</h1>
    <div class="row">
        <div class="col-md-4">
            <h2>Filter</h2>
            <asp:Label ID="Label1" runat="server" AssociatedControlID="PartialName">Partial Product Name</asp:Label>
            <asp:TextBox ID="PartialName" runat="server" CssClass="form-control" placeholder="Enter partial product name" />
            <br />
            <asp:CheckBox ID="IncludeDiscontinued" runat="server" Text="Include Discontinued Products" />
            <asp:LinkButton ID="Filter" runat="server" CssClass="btn btn-primary">Filter by Partial Name</asp:LinkButton>
        </div>
        <div class="col-md-8">
            <h2>Products</h2>
            <asp:ListView ID="ProductListView" runat="server"
                 DataSourceID="ProductDataSource" InsertItemPosition="LastItem"
                 ItemType="WestWindSystem.DataModels.ProductInfo">
                <EditItemTemplate>
                </EditItemTemplate>

                <InsertItemTemplate>
                </InsertItemTemplate>

                <ItemTemplate>
                    <div class="row" style="border-bottom: solid 1px lightgray">
                        <div class="col-sm-8">
                            <b><%# Item.Name %></b>
                            <br />
                            Supplier: <i><%# Item.Supplier %></i>
                            <br />
                            Category: <i><%# Item.Category %></i>
                        </div>
                        <div class="col-sm-4">
                            <%# $"{Item.Price:C}" %>
                            (for <%# Item.QtyPerUnit %>)
                            <br />
                            <asp:CheckBox ID="IsDiscontinued" runat="server"
                                 Text="Discontinued" Visible="<%# Item.IsDiscontinued %>"
                                 Checked="<%# Item.IsDiscontinued %>"
                                 Enabled="false"/>
                            <asp:LinkButton ID="Discontinue" runat="server"
                                 CssClass="btn btn-default"
                                 Text="Discontinue" Visible="<%# !Item.IsDiscontinued %>" />
                            <asp:LinkButton ID="Edit" runat="server"
                                 CssClass="btn btn-default"
                                 Text="Edit" />
                        </div>
                    </div>
                </ItemTemplate>

                <LayoutTemplate>
                    <%--Use the id="itemPlaceholderContainer" for a container of the whole ListView contents--%>
                    <%--Use the id="itemPlaceholder" for the spot where the Item/EditItem template contents are displayed--%>
                    <div runat="server" id="itemPlaceholder" />
                </LayoutTemplate>
            </asp:ListView>

            <asp:ObjectDataSource ID="ProductDataSource" runat="server" DataObjectTypeName="WestWindSystem.DataModels.ProductInfo" DeleteMethod="DiscontinueProductItem" InsertMethod="AddProductItem" OldValuesParameterFormatString="original_{0}" SelectMethod="FilterProducts" TypeName="WestWindSystem.BLL.ProductManagementController" UpdateMethod="UpdateProductItem">
                <SelectParameters>
                    <asp:ControlParameter ControlID="PartialName" PropertyName="Text" Name="partialName" Type="String"></asp:ControlParameter>
                    <asp:ControlParameter ControlID="IncludeDiscontinued" PropertyName="Checked" Name="includeDiscontinued" Type="Boolean"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </div>
</asp:Content>
