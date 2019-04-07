using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WestWindModels;
using WestWindSystem.BLL;
using WestWindSystem.DataModels;

namespace WebApp.Admin
{
    public partial class SearchProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MessagePanel.Visible = false;
            if (!IsPostBack)
            {
                try
                {
                    PopulateCategoryDropDown();
                    PopulateSupplierDropDown();
                    PopulateFilterDisplay();
                }
                catch (Exception ex)
                {
                    ShowFullExceptionMessage(ex);
                }
            }
        }

        private void PopulateFilterDisplay()
        {
            // TODO: 
            SearchFilter.Visible = false;
        }

        private void PopulateSupplierDropDown()
        {
            var controller = new SupplierController();
            List<Supplier> data = controller.ListSuppliers();
            SupplierDropDown.DataSource = data;
            SupplierDropDown.DataTextField = nameof(Supplier.CompanyName);
            SupplierDropDown.DataValueField = nameof(Supplier.SupplierID);
            SupplierDropDown.DataBind();
            SupplierDropDown.Items.Insert(0, "[select a supplier]");

        }

        private void PopulateCategoryDropDown()
        {
            CategoryController controller = new CategoryController();
            var data = controller.ListCategoriesNameAndId();
            CategoryDropDown.DataSource = data;
            CategoryDropDown.DataTextField = nameof(DropDownSelection<int>.Text);
            CategoryDropDown.DataValueField = nameof(DropDownSelection<int>.Value);
            CategoryDropDown.DataBind();
            CategoryDropDown.Items.Insert(0, "[select a Category]");
        }

        private enum ProductSearch { ByCategory, BySupplier, ByPartialName }

        protected void LookupByCategory_Click(object sender, EventArgs e)
        {
            try
            {
                if (CategoryDropDown.SelectedIndex == 0)
                    ShowMessage("Select a category before looking up products", AlertStyle.info);
                else
                {
                    SearchBy.Value = ProductSearch.ByCategory.ToString();
                    ProductController controller = new ProductController();
                    int searchId = int.Parse(CategoryDropDown.SelectedValue);
                    List<Product> data = controller.GetProductsByCategory(searchId);
                    PopulateGridView(data);
                }
            }
            catch (Exception ex)
            {
                ShowFullExceptionMessage(ex);
            }
        }

        protected void LookupBySupplier_Click(object sender, EventArgs e)
        {
            if (SupplierDropDown.SelectedIndex == 0)
                ShowMessage("Select a category before looking up products", AlertStyle.info);
            else
            {
                try
                {
                    SearchBy.Value = ProductSearch.BySupplier.ToString();
                    ProductController controller = new ProductController();
                    int searchId = int.Parse(SupplierDropDown.SelectedValue);
                    List<Product> data = controller.GetProductsBySupplier(searchId);
                    PopulateGridView(data);
                }
                catch (Exception ex)
                {
                    ShowFullExceptionMessage(ex);
                }
            }
        }

        protected void LookupByName_Click(object sender, EventArgs e)
        {
            try
            {
                SearchBy.Value = ProductSearch.ByPartialName.ToString();
                var controller = new ProductController();
                string name = PartialName.Text;
                List<Product> data = controller.GetProductsByPartialName(name);

                // Hook up the data to the GridView
                SearchResultsGridView.DataSource = data;
                SearchResultsGridView.DataBind();
            }
            catch (Exception ex)
            {
                ShowFullExceptionMessage(ex);
            }
        }

        private void PopulateGridView(List<Product> data)
        {
            SearchResultsGridView.DataSource = data;
            SearchResultsGridView.DataBind();
        }

        protected void SearchResultsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            ProductSearch search;
            if (Enum.TryParse(SearchBy.Value, out search))
            {
                SearchResultsGridView.PageIndex = e.NewPageIndex;
                switch (search)
                {
                    case ProductSearch.ByCategory:
                        LookupByCategory_Click(sender, e);
                        break;
                    case ProductSearch.BySupplier:
                        LookupBySupplier_Click(sender, e);
                        break;
                    case ProductSearch.ByPartialName:
                        LookupByName_Click(sender, e);
                        break;
                }
            }
        }

        // Enumeration values based off of Bootstrap styles for alerts.
        public enum AlertStyle { success, info, warning, danger }

        private void ShowMessage(string message, AlertStyle alertStyle)
        {
            MessageLabel.Text = message;
            MessagePanel.CssClass = $"alert alert-{alertStyle} alert-dismissible";
            MessagePanel.Visible = true;
        }

        private void ShowFullExceptionMessage(Exception ex)
        {
            string message = $"ERROR: {ex.Message}";
            // get the inner exception....
            Exception inner = ex;
            // this next statement drills down on the details of the exception
            while (inner.InnerException != null)
                inner = inner.InnerException;
            if (inner != ex)
                message += $"<blockquote>{inner.Message}</blockquote>";
            ShowMessage(message, AlertStyle.danger);
        }
    }
}