<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddEditOrder.aspx.cs" Inherits="WebApp.Admin.AddEditOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <h1 class="page-header">Add/Edit Order</h1>
    </div>
    <div class="row">
        <div class="col-sm-6 form-inline">
            <h4>Actions:</h4>
            <div class="form-group">
                <asp:Label ID="Label1" runat="server" CssClass="control-label"
                     AssociatedControlID="PartialCompany" Text="Company Name"  />
                <asp:TextBox ID="PartialCompany" runat="server" CssClass="form-control"
                    placeholder="Partial Company Name" />
                <asp:LinkButton ID="FilterCompanies" runat="server" CssClass="btn btn-default"
                    Text="Filter" OnClick="FilterCompanies_Click" />
            </div>
            <div class="form-group">
                <asp:Label ID="Label2" runat="server" CssClass="control-label"
                     AssociatedControlID="FilteredCompanyDropDown" Text="Companies" />
                <asp:DropDownList ID="FilteredCompanyDropDown" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:LinkButton ID="LookupOrders" runat="server" CssClass="btn btn-default"
                     Text="Lookup Orders" OnClick="LookupOrders_Click" />
            </div>
            <div class="form-group">
                <asp:Label ID="Label3" runat="server" CssClass="control-label"
                     AssociatedControlID="OrdersDropDown" Text="Orders" />
                <asp:DropDownList ID="OrdersDropDown" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:LinkButton ID="ViewOrder" runat="server" CssClass="btn btn-default"
                     Text="View Order" OnClick="ViewOrder_Click" />
            </div>
            <br /><br />
            <div>
                <i>TBA - Add/Update/Delete Buttons</i>
            </div>
        </div>
        <div class="col-sm-6">
            <h4>Notes:</h4>
            <ul>
                <li>Filtered Lookup - to deal with large amounts of data</li>
            </ul>
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
</asp:Content>
