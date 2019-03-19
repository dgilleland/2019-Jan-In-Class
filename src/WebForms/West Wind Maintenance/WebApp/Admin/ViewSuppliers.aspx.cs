using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WestWindSystem.BLL;

namespace WebApp.Admin
{
    public partial class ViewSuppliers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack) // on the first GET of the page
            {
                var controller = new SupplierController();
                SupplierGridView.DataSource = controller.ListSuppliers();
                SupplierGridView.DataBind();
            }
        }
    }
}