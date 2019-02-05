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
            <asp:ListView ID="ProductListView" runat="server" DataSourceID="ProductDataSource" InsertItemPosition="LastItem">
                <AlternatingItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                        </td>
                        <td>
                            <asp:Label Text='<%# Eval("ProductId") %>' runat="server" ID="ProductIdLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QtyPerUnit") %>' runat="server" ID="QtyPerUnitLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Supplier") %>' runat="server" ID="SupplierLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("SupplierId") %>' runat="server" ID="SupplierIdLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Category") %>' runat="server" ID="CategoryLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("CategoryId") %>' runat="server" ID="CategoryIdLabel" /></td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                            <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                        </td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ProductId") %>' runat="server" ID="ProductIdTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Name") %>' runat="server" ID="NameTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Price") %>' runat="server" ID="PriceTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("QtyPerUnit") %>' runat="server" ID="QtyPerUnitTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Supplier") %>' runat="server" ID="SupplierTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("SupplierId") %>' runat="server" ID="SupplierIdTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Category") %>' runat="server" ID="CategoryTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("CategoryId") %>' runat="server" ID="CategoryIdTextBox" /></td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                            <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                        </td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ProductId") %>' runat="server" ID="ProductIdTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Name") %>' runat="server" ID="NameTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Price") %>' runat="server" ID="PriceTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("QtyPerUnit") %>' runat="server" ID="QtyPerUnitTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Supplier") %>' runat="server" ID="SupplierTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("SupplierId") %>' runat="server" ID="SupplierIdTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Category") %>' runat="server" ID="CategoryTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("CategoryId") %>' runat="server" ID="CategoryIdTextBox" /></td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                        </td>
                        <td>
                            <asp:Label Text='<%# Eval("ProductId") %>' runat="server" ID="ProductIdLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QtyPerUnit") %>' runat="server" ID="QtyPerUnitLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Supplier") %>' runat="server" ID="SupplierLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("SupplierId") %>' runat="server" ID="SupplierIdLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Category") %>' runat="server" ID="CategoryLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("CategoryId") %>' runat="server" ID="CategoryIdLabel" /></td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                    <tr runat="server" style="">
                                        <th runat="server"></th>
                                        <th runat="server">ProductId</th>
                                        <th runat="server">Name</th>
                                        <th runat="server">Price</th>
                                        <th runat="server">QtyPerUnit</th>
                                        <th runat="server">Supplier</th>
                                        <th runat="server">SupplierId</th>
                                        <th runat="server">Category</th>
                                        <th runat="server">CategoryId</th>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="">
                                <asp:DataPager runat="server" ID="DataPager1">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                        </td>
                        <td>
                            <asp:Label Text='<%# Eval("ProductId") %>' runat="server" ID="ProductIdLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QtyPerUnit") %>' runat="server" ID="QtyPerUnitLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Supplier") %>' runat="server" ID="SupplierLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("SupplierId") %>' runat="server" ID="SupplierIdLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Category") %>' runat="server" ID="CategoryLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("CategoryId") %>' runat="server" ID="CategoryIdLabel" /></td>
                    </tr>
                </SelectedItemTemplate>
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
