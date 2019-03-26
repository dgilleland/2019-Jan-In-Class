﻿using System;
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
    public partial class AddEditSupplier : System.Web.UI.Page
    {
        #region Private properties/fields
        const string STYLE_WARNING = "alert-warning"; // This is a Bootstrap style
        const string STYLE_INFO = "alert-info";
        const string STYLE_SUCCESS = "alert-success";
        #endregion

        #region Page Events
        protected void Page_Load(object sender, EventArgs e)
        {
            MessagePanel.Visible = false; // hide messages
            if(!IsPostBack)
            {
                try
                {
                    BindSupplierDropDown();
                    BindCountryDropDown();
                }
                catch (Exception ex)
                {
                    ShowMessage(ex.Message, STYLE_WARNING);
                }
            }
        }
        #endregion

        #region Button Events
        protected void LookupSupplier_Click(object sender, EventArgs e)
        {
            // Check that the supplier selected is not the prompt line (index 0)
            if (SupplierDropDown.SelectedIndex == 0)
            {
                // Error message
                ShowMessage("Please select a supplier before clicking the Lookup button.", STYLE_INFO);
            }
            else
            {
                try
                {
                    // Get the supplier info from the BLL
                    // Note that the .SelectedValue is always a string
                    int supplierId = int.Parse(SupplierDropDown.SelectedValue);
                    var controller = new SupplierController();
                    var result = controller.GetSuppier(supplierId);

                    // "Unpack" the object into the form's controls
                    CurrentSupplier.Text = result.SupplierID.ToString();
                    CompanyName.Text = result.CompanyName;
                    ContactTitle.Text = result.ContactTitle;
                    ContactName.Text = result.ContactName;
                    Email.Text = result.Email;
                    Address.Text = result.Address;
                    City.Text = result.City;
                    PostalCode.Text = result.PostalCode;
                    Phone.Text = result.Phone;
                    Fax.Text = result.Fax;
                    CountryDropDown.SelectedValue = result.Country;
                }
                catch (Exception ex)
                {
                    ShowMessage(ex.Message, STYLE_WARNING);
                }
            }
        }
        #endregion

        #region Private Methods
        private void ShowMessage(string message, string style)
        {
            MessageLabel.Text = message;
            MessagePanel.CssClass = $"alert {style} alert-dismissible";
            MessagePanel.Visible = true;
        }
        private void BindCountryDropDown()
        {
            SupplierController controller = new SupplierController();
            CountryDropDown.DataSource = controller.ListCountries();
            CountryDropDown.DataTextField = nameof(Country.Name);
            CountryDropDown.DataValueField = nameof(Country.Name);
            CountryDropDown.DataBind();
            CountryDropDown.Items.Insert(0, "[select a country]");
        }
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