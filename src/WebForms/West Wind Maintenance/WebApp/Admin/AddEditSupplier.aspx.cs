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
    public partial class AddEditSupplier : System.Web.UI.Page
    {
        #region Page Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                try
                {
                    //throw new NotImplementedException("TBA");
                    BindSupplierDropDown();
                }
                catch (Exception ex)
                {
                    MessageLabel.Text = ex.Message;
                    MessagePanel.CssClass = "alert alert-warning alert-dismissible";
                    MessagePanel.Visible = true;
                }
            }
        }
        #endregion

        #region Button Events
        protected void LookupSupplier_Click(object sender, EventArgs e)
        {

        }
        #endregion

        #region Private Methods
        private void BindSupplierDropDown()
        {
            SupplierController controller = new SupplierController();
            // SupplierDropDown is an object of type DropDownList.
            // The .DataSource property takes any enumerable list of data.
            SupplierDropDown.DataSource = controller.ListSuppliers();
            // The .DataTextField property specifies what property name should be called to get the
            // data to display for the drop-down's options.
            SupplierDropDown.DataTextField = nameof(Supplier.CompanyName);
            // The .DataValueField property specified what property name should be called to get the
            // data to use as the value for the drop-down's options.
            SupplierDropDown.DataValueField = nameof(Supplier.SupplierID);
            // Populate the drop-down by taking the data and "unpacking" it.
            SupplierDropDown.DataBind();
            // Insert an item into index position [0] for the drop-down.
            SupplierDropDown.Items.Insert(0, new ListItem("[Select a supplier]", "-1"));
        }
        #endregion
    }
}