using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WestWindModels;
using WestWindSystem.BLL;

namespace WebApp.Admin
{
    public partial class AddEditOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MessagePanel.Visible = false;
        }

        protected void FilterCompanies_Click(object sender, EventArgs e)
        {
            try
            {
                var controller = new CustomerController();
                var companyShortList = controller.GetCustomersByCompanyName(PartialCompany.Text);
                FilteredCompanyDropDown.DataSource = companyShortList;
                FilteredCompanyDropDown.DataTextField = nameof(Customer.CompanyName);
                FilteredCompanyDropDown.DataValueField = nameof(Customer.CustomerID);
                FilteredCompanyDropDown.DataBind(); // Populate the control
                FilteredCompanyDropDown.Items.Insert(0, new ListItem("[Select a Company]", ""));
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, STYLE_DANGER);
            }
        }

        #region Error Messages
        const string STYLE_DANGER = "alert-danger";
        const string STYLE_WARNING = "alert-warning"; // This is a Bootstrap style
        const string STYLE_INFO = "alert-info";
        const string STYLE_SUCCESS = "alert-success";

        private void ShowMessage(string message, string style)
        {
            MessageLabel.Text = message;
            MessagePanel.CssClass = $"alert {style} alert-dismissible";
            MessagePanel.Visible = true;
        }
        #endregion

        protected void LookupOrders_Click(object sender, EventArgs e)
        {
            if(FilteredCompanyDropDown.SelectedIndex == 0)
            {
                ShowMessage("Select a company before looking up orders", STYLE_INFO);
            }
            else
            {
                try
                {
                    var controller = new OrderController();
                    var data = controller.ListOrders(FilteredCompanyDropDown.SelectedValue);
                    OrdersDropDown.DataSource = data;
                    OrdersDropDown.DataTextField = nameof(Order.OrderID);
                    OrdersDropDown.DataValueField = nameof(Order.OrderID);
                    OrdersDropDown.DataBind();
                    OrdersDropDown.Items.Insert(0, "[Select an Order]");
                }
                catch (Exception ex)
                {
                    ShowMessage(ex.Message, STYLE_DANGER);
                }
            }
        }

        protected void ViewOrder_Click(object sender, EventArgs e)
        {

        }
    }
}