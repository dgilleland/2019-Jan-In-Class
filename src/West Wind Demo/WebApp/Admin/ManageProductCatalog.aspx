<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageProductCatalog.aspx.cs" Inherits="WebApp.Admin.ManageProductCatalog" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>


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
            <uc1:MessageUserControl runat="server" ID="MessageUserControl" />
            <asp:ListView ID="ProductListView" runat="server"
                 DataSourceID="ProductDataSource" InsertItemPosition="LastItem"
                 ItemType="WestWindSystem.DataModels.ProductInfo"
                 DataKeyNames="ProductId">
                <EditItemTemplate>
                    <div class="row" style="border-bottom: solid 1px lightgray">
                        <div class="col-sm-8">
                            <asp:TextBox ID="ProductName" runat="server"
                                 Text="<%# BindItem.Name %>" CssClass="form-control"
                                 placeholder="Product Name" required="required" />

                            <asp:DropDownList ID="SupplierDropDown" runat="server"
                                CssClass="form-control"
                                SelectedValue="<%# BindItem.SupplierId %>"
                                AppendDataBoundItems="true" DataSourceID="SupplierDataSource"
                                DataTextField="Value" DataValueField="Key">
                                <asp:ListItem Value="0">[Select a Supplier]</asp:ListItem>
                            </asp:DropDownList>

                            <asp:DropDownList ID="CategoryDropDown" runat="server"
                                CssClass="form-control"
                                SelectedValue="<%# BindItem.CategoryId %>"
                                AppendDataBoundItems="true" DataSourceID="CategoryDataSource" 
                                DataTextField="Value" DataValueField="Key">
                                <asp:ListItem Value="0">[Select a Category]</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-4">
                            <asp:TextBox ID="UnitPrice" runat="server" CssClass="form-control"
                                Text="<%# BindItem.Price %>" TextMode="Number"></asp:TextBox>
                            <asp:TextBox ID="Qty" runat="server" CssClass="form-control"
                                Text="<%# BindItem.QtyPerUnit %>"></asp:TextBox>
                            <asp:LinkButton ID="Update" runat="server"
                                 CssClass="btn btn-default" CommandName="Update"
                                 Text="Update" />
                            <asp:LinkButton ID="Cancel" runat="server"
                                 CssClass="btn btn-default" CommandName="Cancel"
                                 Text="Cancel" />
                        </div>
                    </div>
                </EditItemTemplate>

                <InsertItemTemplate>
                    <div class="row bg-info" style="border: solid 1px lightgray; padding:4px 0;">
                        <div class="col-sm-8">
                            <asp:TextBox ID="ProductName" runat="server"
                                 Text="<%# BindItem.Name %>" CssClass="form-control"
                                 placeholder="Product Name" required="required" />

                            <asp:DropDownList ID="SupplierDropDown" runat="server"
                                CssClass="form-control"
                                SelectedValue="<%# BindItem.SupplierId %>"
                                AppendDataBoundItems="true" DataSourceID="SupplierDataSource"
                                DataTextField="Value" DataValueField="Key">
                                <asp:ListItem Value="0">[Select a Supplier]</asp:ListItem>
                            </asp:DropDownList>

                            <asp:DropDownList ID="CategoryDropDown" runat="server"
                                CssClass="form-control"
                                SelectedValue="<%# BindItem.CategoryId %>"
                                AppendDataBoundItems="true" DataSourceID="CategoryDataSource" 
                                DataTextField="Value" DataValueField="Key">
                                <asp:ListItem Value="0">[Select a Category]</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-4">
                            <asp:TextBox ID="UnitPrice" runat="server" CssClass="form-control"
                                Text="<%# BindItem.Price %>"
                                placeholder="Unit Price" TextMode="Number"></asp:TextBox>
                            <asp:TextBox ID="Qty" runat="server" CssClass="form-control"
                                Text="<%# BindItem.QtyPerUnit %>"
                                placeholder="Qty per Unit"></asp:TextBox>
                            <asp:LinkButton ID="Insert" runat="server"
                                 CssClass="btn btn-default" CommandName="Insert"
                                 Text="Add New Product" />
                            <asp:LinkButton ID="Cancel" runat="server"
                                 CssClass="btn btn-default" CommandName="Cancel"
                                 Text="Clear" />
                        </div>
                    </div>
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
                                 CssClass="btn btn-default" CommandName="Edit"
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

            <asp:ObjectDataSource ID="ProductDataSource" runat="server"
                DataObjectTypeName="WestWindSystem.DataModels.ProductInfo"
                DeleteMethod="DiscontinueProductItem"
                InsertMethod="AddProductItem"
                OldValuesParameterFormatString="original_{0}"
                SelectMethod="FilterProducts"
                TypeName="WestWindSystem.BLL.ProductManagementController"
                UpdateMethod="UpdateProductItem"
                OnUpdated="CheckForExceptions"
                OnDeleted="CheckForExceptions"
                OnInserted="CheckForExceptions">
                <SelectParameters>
                    <asp:ControlParameter ControlID="PartialName" PropertyName="Text" Name="partialName" Type="String"></asp:ControlParameter>
                    <asp:ControlParameter ControlID="IncludeDiscontinued" PropertyName="Checked" Name="includeDiscontinued" Type="Boolean"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>

            <asp:ObjectDataSource ID="SupplierDataSource" runat="server"
                OldValuesParameterFormatString="original_{0}"
                SelectMethod="ListSuppliersNameAndId"
                TypeName="WestWindSystem.BLL.ProductManagementController"></asp:ObjectDataSource>

            <asp:ObjectDataSource ID="CategoryDataSource" runat="server"
                OldValuesParameterFormatString="original_{0}"
                SelectMethod="ListCategoriesNameAndId"
                TypeName="WestWindSystem.BLL.ProductManagementController"></asp:ObjectDataSource>
        </div>
    </div>
</asp:Content>
