<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddEditSupplier.aspx.cs" Inherits="WebApp.Admin.AddEditSupplier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <h1 class="page-header">Add/Edit Supplier</h1>
    </div>
    <div class="row">
        <div class="col-sm-6 form-inline">
            <h4>Actions:</h4>
            <div class="form-group">
                <asp:Label ID="Label1" runat="server" CssClass="control-label"
                    Text="Company Name" AssociatedControlID="SupplierDropDown" />
                <asp:DropDownList ID="SupplierDropDown" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:LinkButton ID="LookupSupplier" runat="server" CssClass="btn btn-primary"
                    OnClick="LookupSupplier_Click">Lookup Supplier</asp:LinkButton>
            </div>
            <br /><br />
            <div>
                <asp:LinkButton ID="AddSupplier" runat="server" CssClass="btn btn-default"
                     OnClick="AddSupplier_Click">Add Supplier</asp:LinkButton>
                <asp:LinkButton ID="UpdateSupplier" runat="server" CssClass="btn btn-default"
                     OnClick="UpdateSupplier_Click">Update Supplier</asp:LinkButton>
                <asp:LinkButton ID="DeleteSupplier" runat="server" CssClass="btn btn-default"
                     OnClick="DeleteSupplier_Click" OnClientClick="return confirm('Are you sure you want to delete this supplier?')">Delete Supplier</asp:LinkButton>
                <asp:LinkButton ID="ClearForm" runat="server" CssClass="btn btn-default"
                     OnClick="ClearForm_Click">Clear Form</asp:LinkButton>
            </div>
        </div>
        <div class="col-sm-6">
            <h4>Notes:</h4>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <asp:Panel ID="MessagePanel" runat="server" role="alert" Visible="false">
                <button type="button" class="close" data-dismiss="alert"
                    aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <asp:Label ID="MessageLabel" runat="server" />
            </asp:Panel>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>Supplier Details</legend>
                <asp:Label ID="Label3" runat="server" Text="Supplier ID" AssociatedControlID="CurrentSupplier"></asp:Label>
                <asp:TextBox ID="CurrentSupplier" runat="server" Enabled="false"></asp:TextBox>

                <asp:Label ID="Label4" runat="server" Text="Company Name" AssociatedControlID="CompanyName"></asp:Label>
                <asp:TextBox ID="CompanyName" runat="server"></asp:TextBox>

                <asp:Label ID="Label5" runat="server" Text="Contact name" AssociatedControlID="ContactName"></asp:Label>
                <asp:TextBox ID="ContactName" runat="server"></asp:TextBox>

                <asp:Label ID="Label2" runat="server" Text="Contact Title" AssociatedControlID="ContactTitle"></asp:Label>
                <asp:TextBox ID="ContactTitle" runat="server"></asp:TextBox>

                <asp:Label ID="Label13" runat="server" Text="Email Address" AssociatedControlID="Email"></asp:Label>
                <asp:TextBox ID="Email" runat="server"></asp:TextBox>

                <asp:Label ID="Label6" runat="server" Text="Address" AssociatedControlID="Address"></asp:Label>
                <asp:TextBox ID="Address" runat="server"></asp:TextBox>

                <asp:Label ID="Label7" runat="server" Text="City" AssociatedControlID="City"></asp:Label>
                <asp:TextBox ID="City" runat="server"></asp:TextBox>

                <asp:Label ID="Label8" runat="server" Text="Region" AssociatedControlID="Region"></asp:Label>
                <asp:TextBox ID="Region" runat="server"></asp:TextBox>

                <asp:Label ID="Label9" runat="server" Text="Postal Code" AssociatedControlID="PostalCode"></asp:Label>
                <asp:TextBox ID="PostalCode" runat="server"></asp:TextBox>

                <asp:Label ID="Label10" runat="server" Text="Country" AssociatedControlID="CountryDropDown"></asp:Label>
                <asp:DropDownList ID="CountryDropDown" runat="server"></asp:DropDownList>

                <asp:Label ID="Label11" runat="server" Text="Phone" AssociatedControlID="Phone"></asp:Label>
                <asp:TextBox ID="Phone" runat="server"></asp:TextBox>

                <asp:Label ID="Label12" runat="server" Text="Fax" AssociatedControlID="FAx"></asp:Label>
                <asp:TextBox ID="Fax" runat="server"></asp:TextBox>
            </fieldset>
        </div>
    </div>
    <link href="../Content/bootwrap-freecode.css" rel="stylesheet" />
    <script src="../Scripts/bootwrap-freecode.js"></script>
</asp:Content>
