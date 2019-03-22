<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerOrderForm.aspx.cs" Inherits="WebApp.Sales.CustomerOrderForm" %>
<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1 class="page-header">Customer Order Form</h1>
    <asp:Panel ID="CustomerSelectionPanel" runat="server" Visible="true" CssClass="row">
        <div class="col-md-6">
            <asp:Label ID="Label1" runat="server" Text="Customer: " AssociatedControlID="CustomerDropDown" />
            <asp:DropDownList ID="CustomerDropDown" runat="server" DataSourceID="CustomerDataSource" DataTextField="Text" DataValueField="Key" CssClass="form-control" style="display: inline-block;">
            </asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="CustomerDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="ListCustomerNames" TypeName="WestWindSystem.BLL.SalesController">
                <SelectParameters>
                    <asp:ControlParameter ControlID="AllCustomersCheckBox" PropertyName="Checked" Name="listAll" Type="Boolean"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:LinkButton ID="SelectCustomer" runat="server" OnClick="SelectCustomer_Click" CssClass="btn btn-default">Select</asp:LinkButton>
            <asp:LinkButton ID="CancelSelection" runat="server" OnClick="CancelSelection_Click" CssClass="btn btn-default" Visible="false">Cancel</asp:LinkButton>
            <asp:LinkButton ID="NewOrder" runat="server" OnClick="NewOrder_Click" CssClass="btn btn-primary" Visible="false">New Order</asp:LinkButton>
            <div>
                <asp:CheckBox ID="AllCustomersCheckBox" runat="server" Checked="true" AutoPostBack="true" />
                <asp:Label ID="Label3" runat="server" Text="All Customers" AssociatedControlID="AllCustomersCheckBox" />
            </div>
        </div>
        <asp:Panel ID="CustomerInfoPanel" runat="server" CssClass="col-md-6" Visible="false">
            <div class="row">
                <div class="col-sm-3"><asp:Label ID="CompanyNameLabel" runat="server" Text="Company Name" AssociatedControlID="CompanyName" /></div>
                <div class="col-sm-9"><asp:TextBox ID="CompanyName" runat="server" Enabled="false" CssClass="form-control" /></div>
            </div>
            <div class="row">
                <div class="col-sm-3"><asp:Label ID="ContactNameLabel" runat="server" Text="Contact Name" AssociatedControlID="ContactName" /></div>
                <div class="col-sm-9"><asp:TextBox ID="ContactName" runat="server" Enabled="false" CssClass="form-control" /></div>
            </div>
            <div class="row">
                <div class="col-sm-3"><asp:Label ID="PhoneLabel" runat="server" Text="Phone" AssociatedControlID="Phone" /></div>
                <div class="col-sm-9"><asp:TextBox ID="Phone" runat="server" Enabled="false" CssClass="form-control" /></div>
            </div>
            <div class="row">
                <div class="col-sm-3"><asp:Label ID="FaxLabel" runat="server" Text="Fax" AssociatedControlID="Fax" /></div>
                <div class="col-sm-9"><asp:TextBox ID="Fax" runat="server" Enabled="false" CssClass="form-control" /></div>
            </div>
        </asp:Panel>
    </asp:Panel>

    <asp:Panel ID="CustomerOrderHistoryPanel" runat="server" CssClass="row" Visible="false">
        <div class="col-md-12">
            <h3>Order History</h3>
            <asp:Label ID="FilterLabel" runat="server" AssociatedControlID="HistorySelectionList" Text="Order History Filter" />
            <asp:RadioButtonList ID="HistorySelectionList" runat="server" AutoPostBack="true" RepeatDirection="Horizontal" RepeatLayout="Flow" OnDataBound="HistorySelectionList_DataBound" DataSourceID="HistoryFilterDataSource" DataTextField="Text" DataValueField="Key">
            </asp:RadioButtonList>
            <asp:ObjectDataSource runat="server" ID="HistoryFilterDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetOrderHistoryFilters" TypeName="WestWindSystem.BLL.SalesController"></asp:ObjectDataSource>
            <hr />
            <asp:GridView ID="CustomerOrderHistoryGridView" runat="server"
                CssClass="table table-condensed table-hover"
                SelectedRowStyle-CssClass="active"
                AutoGenerateColumns="False" DataSourceID="OrderHistoryDataSource" DataKeyNames="OrderId"
                OnSelectedIndexChanged="CustomerOrderHistoryGridView_SelectedIndexChanged"
                ItemType="WestWindSystem.DataModels.CustomerOrder">
                <Columns>
                    <asp:CommandField ShowSelectButton="True"></asp:CommandField>
                </Columns>
                <EmptyDataTemplate>
                    <div>No customer order history available for the selected filter.</div>
                </EmptyDataTemplate>
                <Columns>
                    <asp:BoundField DataField="Employee" HeaderText="Employee" SortExpression="Employee"></asp:BoundField>
                    <asp:BoundField DataField="OrderDate" HeaderText="Order Date" SortExpression="OrderDate" DataFormatString="{0:MMM dd, yyyy}"></asp:BoundField>
                    <asp:BoundField DataField="RequiredDate" HeaderText="Required Date" SortExpression="RequiredDate" DataFormatString="{0:MMM dd, yyyy}"></asp:BoundField>
                    <asp:BoundField DataField="OrderTotal" HeaderText="Order Total" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" SortExpression="OrderTotal"></asp:BoundField>
                    <asp:BoundField DataField="Freight" HeaderText="Freight" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" SortExpression="Freight"></asp:BoundField>
                    <asp:TemplateField HeaderText="Shipments">
                        <ItemTemplate>
                            <asp:Repeater ID="ShipmentsRepeater" runat="server"
                                DataSource="<%# Item.Shipments %>"
                                ItemType="WestWindSystem.DataModels.ShipmentSummary">
                                <ItemTemplate><%# Item.ShippedOn.ToString("MMM dd yyyy") %> (<%# Item.Carrier %>)</ItemTemplate>
                                <SeparatorTemplate>, </SeparatorTemplate>
                            </asp:Repeater>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource runat="server" ID="OrderHistoryDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetOrdersByCustomer" TypeName="WestWindSystem.BLL.SalesController">
                <SelectParameters>
                    <asp:ControlParameter ControlID="CustomerDropDown" PropertyName="SelectedValue" Name="customerId" Type="String"></asp:ControlParameter>
                    <asp:ControlParameter ControlID="HistorySelectionList" PropertyName="SelectedValue" Name="filter" Type="String" DefaultValue="&quot;&quot;"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </asp:Panel>

    <asp:Panel ID="CustomerOrderEditingPanel" runat="server" CssClass="row" Visible="false">
        <div class="col-md-12">
            <h3>Edit Order:
                <asp:HiddenField ID="OrderId" runat="server" />

                <asp:LinkButton ID="SaveOrder" runat="server" CssClass="btn btn-info btn-sm" OnClick="SaveOrder_Click">
                    Save
                    &nbsp;
                </asp:LinkButton>
                <asp:LinkButton ID="PlaceOrder" runat="server" CssClass="btn btn-success btn-sm" OnClick="PlaceOrder_Click">Place Order</asp:LinkButton>
                <asp:LinkButton ID="BackToList" runat="server" CssClass="btn btn-default btn-sm" OnClick="BackToList_Click">Back to Order History</asp:LinkButton>
            </h3>
            <uc1:MessageUserControl runat="server" ID="MessageUserControl" />
            <table class="table table-condensed">
                <tr>
                    <th>Order Date</th>
                    <th>Required By</th>
                    <th>Freight</th>
                    <th>Total</th>
                </tr>
                <tr>
                    <td><asp:TextBox ID="EditOrderDate" runat="server" TextMode="Date" CssClass="form-control" Enabled="false" /></td>
                    <td><asp:TextBox ID="EditRequiredDate" runat="server" TextMode="Date" CssClass="form-control" /></td>
                    <td><asp:TextBox ID="EditFreight" runat="server" CssClass="form-control" /></td>
                    <td class="bg-success" style="vertical-align:middle;"><asp:Label ID="OrderTotal" runat="server" CssClass="h4" style="font-weight:bold;" /></td>
                </tr>
            </table>
            <asp:ListView ID="OrderItemsListView" runat="server"
                 ItemType="WestWindSystem.DataModels.CustomerOrderItem"
                 InsertItemPosition="FirstItem"
                 OnItemCommand="OrderItemsListView_ItemCommand"
                 OnLayoutCreated="OrderItemsListView_LayoutCreated">
                <LayoutTemplate>
                    <table class="table table-hover table-condensed table-bordered">
                        <tr runat="server" id="itemPlaceholder"></tr>
                        <tr>
                            <td colspan="3"></td>
                            <td class="text-right bg-info h4"><asp:Label ID="TotalExtended" runat="server" /></td>
                            <td></td>
                            <td class="text-right bg-success h4"><asp:Label ID="TotalDiscounted" runat="server" /></td>
                            <td></td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <InsertItemTemplate>
                    <tr class="success">
                        <td colspan="1">
                            <asp:Label ID="ProductsLabel" runat="server" AssociatedControlID="AvailableProducts" Text="Add Product:"></asp:Label>
                            <asp:DropDownList ID="AvailableProducts" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="AvailableProducts_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="Label2" runat="server" AssociatedControlID="NewItemQuantity" Text="Quantity"></asp:Label>
                            <asp:TextBox ID="NewItemQuantity" runat="server" CssClass="form-control"></asp:TextBox>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="PriceLabel" runat="server" AssociatedControlID="NewItemPrice" Text="Price"></asp:Label>
                            <asp:TextBox ID="NewItemPrice" runat="server" CssClass="form-control"></asp:TextBox>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="DiscountLabel" runat="server" AssociatedControlID="NewItemDiscount" Text="Discount (%)"></asp:Label>
                            <asp:TextBox ID="NewItemDiscount" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                        </td>
                        <td style="vertical-align:bottom;">
                            <asp:LinkButton ID="AddItem" runat="server" CommandName="Insert" CssClass="btn btn-success"><i class="glyphicon glyphicon-plus"></i> Add</asp:LinkButton>
                        </td>
                    </tr>
                    <tr runat="server" style="">
                        <th runat="server">Product Name &hArr; Qty Per Unit<br /><i>Supplier</i></th>
                        <th runat="server">Order Qty</th>
                        <th runat="server">Unit Price</th>
                        <th runat="server">Extended Price</th>
                        <th runat="server">Discount</th>
                        <th runat="server">Discount Price</th>
                        <th runat="server"></th>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:HiddenField ID="ProductId" runat="server" Value="<%# Item.ProductId %>" />
                            <b><asp:Label id="ProductNameLabel" runat="server" Text="<%# Item.ProductName %>" ToolTip='<%# $"Product ID: {Item.ProductId}" %>' /></b>
                            &hArr;
                            <asp:Label id="QuantityPerUnitLabel" runat="server" Text="<%# Item.QuantityPerUnit %>" />
                            <br /> &mdash;
                            <asp:Label ID="SupplierName" runat="server" Text="<%# Item.Supplier %>" />
                        </td>
                        <td><asp:TextBox id="QuantityTextBox" runat="server" Text="<%# Item.Quantity %>" CssClass="form-control" /></td>
                        <td><asp:TextBox id="UnitPriceTextBox" runat="server" Text='<%# Item.UnitPrice.ToString("C") %>' CssClass="form-control" /></td>
                        <td class="text-right"><asp:Label id="Label4" runat="server" Text='<%# (Item.Quantity * Item.UnitPrice).ToString("C") %>' /></td>
                        <td><asp:TextBox id="DiscountPercentTextBox" runat="server" Text='<%# Item.DiscountPercent.ToString("P") %>' CssClass="form-control" /></td>
                        <td class="text-right"><asp:Label id="Label5" runat="server" Text='<%# ((Item.Quantity * Item.UnitPrice) - (Item.Quantity * Item.UnitPrice) * (Convert.ToDecimal(Item.DiscountPercent))).ToString("C") %>' /></td>
                        <td style="vertical-align:top; white-space: nowrap;">
                            <asp:LinkButton ID="Refresh" runat="server" CommandName="Refresh" CssClass="btn btn-info" ToolTip="Update Totals"><i class="glyphicon glyphicon-refresh"></i></asp:LinkButton>
                            <asp:LinkButton ID="Remove" runat="server" CommandName="Delete" CommandArgument="<%# Item.ProductId %>" CssClass="btn btn-danger" ToolTip="Remove Item"><i class="glyphicon glyphicon-remove"></i></asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </asp:Panel>
    <style>
        .aspNetDisabled, a:not([href]) {
            cursor: not-allowed;
        }
    </style>
</asp:Content>