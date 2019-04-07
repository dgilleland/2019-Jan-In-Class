<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddEditProduct.aspx.cs" Inherits="WebApp.Admin.AddEditProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <h1 class="page-header">Add/Edit Products</h1>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-inline">
                        <asp:Label ID="Label1" runat="server" CssClass="control-label"
                            Text="Products" AssociatedControlID="CurrentProducts" />
                        <asp:DropDownList ID="CurrentProducts" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                        <asp:LinkButton ID="ShowProductDetails" runat="server" CausesValidation="false"
                            CssClass="btn btn-primary" OnClick="ShowProductDetails_Click">
                            Show Product Details <i class="glyphicon glyphicon-search"></i>
                        </asp:LinkButton>
                    </div>
                </div>
                <div class="col-sm-6 text-center">
                    <asp:LinkButton ID="AddProduct" runat="server"
                        CssClass="btn btn-default" OnClick="AddProduct_Click">Add Product</asp:LinkButton>
                    <asp:LinkButton ID="UpdateProduct" runat="server"
                        CssClass="btn btn-default" OnClick="UpdateProduct_Click">Update Product</asp:LinkButton>
                    <asp:LinkButton ID="DeleteProduct" runat="server"
                        CssClass="btn btn-default" OnClick="DeleteProduct_Click">Delete Product</asp:LinkButton>
                    <asp:LinkButton ID="ClearForm" runat="server" CausesValidation="false"
                        CssClass="btn btn-default" OnClick="ClearForm_Click">Clear Form</asp:LinkButton>
                </div>
            </div>
        </div>
        <hr />
        <div class="col-md-12">
            <br />
            <asp:Panel ID="MessagePanel" runat="server" Visible="false" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="MessageLabel" runat="server" />
            </asp:Panel>

            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-info"
                HeaderText="Please note the following problems with your form. Correct these before adding or updating a Product." />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ControlToValidate="ProductName" ErrorMessage="Product Name is required"
                Display="None" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                ControlToValidate="QtyPerUnit" ErrorMessage="Quantity-per-unit is required"
                Display="None" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                ControlToValidate="UnitPrice" ErrorMessage="Unit Price is required"
                Display="None" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                ControlToValidate="OnOrder" ErrorMessage="On-Order quantity is required"
                Display="None" />
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="UnitPrice" ValueToCompare="0" Type="Currency" Display="None" ErrorMessage="Unit price must be a positive money value" Operator="GreaterThan" />
            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="OnOrder" ValueToCompare="0" Type="Integer" Display="None" ErrorMessage="Quantity On-Order cannot be negative" Operator="GreaterThanEqual" />
        </div>
        <div class="col-md-12">
            <fieldset>
                <legend>Product Details</legend>
                <asp:Label ID="Label3" runat="server" Text="Product ID" AssociatedControlID="ProductID" />
                <asp:TextBox ID="ProductID" runat="server" Enabled="false" />

                <asp:Label ID="Label2" runat="server" Text="Product Name" AssociatedControlID="ProductName" />
                <asp:TextBox ID="ProductName" runat="server" />

                <asp:Label ID="Label4" runat="server" Text="Supplier" AssociatedControlID="SupplierDropDown"></asp:Label>
                <asp:DropDownList ID="SupplierDropDown" runat="server"></asp:DropDownList>

                <asp:Label ID="Label5" runat="server" Text="Category" AssociatedControlID="CategoryDropDown"></asp:Label>
                <asp:DropDownList ID="CategoryDropDown" runat="server"></asp:DropDownList>

                <asp:Label ID="Label6" runat="server" Text="Qty per Unit" AssociatedControlID="QtyPerUnit"></asp:Label>
                <asp:TextBox ID="QtyPerUnit" runat="server"></asp:TextBox>

                <asp:Label ID="Label7" runat="server" Text="Unit Price" AssociatedControlID="UnitPrice"></asp:Label>
                <asp:TextBox ID="UnitPrice" runat="server"></asp:TextBox>

                <asp:Label ID="Label9" runat="server" Text="On Order" AssociatedControlID="OnOrder"></asp:Label>
                <asp:TextBox ID="OnOrder" runat="server"></asp:TextBox>

                <asp:Label ID="Label11" runat="server" Text="Discontinued" AssociatedControlID="Discontinued"></asp:Label>
                <asp:CheckBox ID="Discontinued" runat="server" Text="Product is discontinued"></asp:CheckBox>
            </fieldset>
        </div>
    </div>
    <link href="../Content/bootwrap-freecode.css" rel="stylesheet" />
    <script src="../Scripts/bootwrap-freecode.js"></script>
    <style>
        select.form-control {
            width: auto;
        }
    </style>
</asp:Content>
