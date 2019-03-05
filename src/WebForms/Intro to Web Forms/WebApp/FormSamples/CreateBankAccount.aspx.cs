
using System;
using System.Collections.Generic; // Access to the List<T> class
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApp.FormSamples.Classes; // Access to the BankAccount class

partial class FormSamples_CreateBankAccount
    : System.Web.UI.Page
{
    private static List<BankAccount> BankAccounts = new List<BankAccount>();

    protected void Page_Load(Object sender, EventArgs e)
    {
        // Page_Load happens before any of the individual control events.
        // It's a great point in time of the page's Page Lifecycle to go
        // ahead and "populate" the form's controls on the first visit to
        // the page.
        if (!IsPostBack) // a GET request - the "first" visit to the page
        {
            // Populate the GridView with data
            BankAccountGridView.DataSource = BankAccounts;
            BankAccountGridView.DataBind();
        }
    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        if (IsValid) // IsValid is a property on the page that checks with the validation controls to ensure that the data in the controls passes all the validation.
        {
            if (IsDuplicate())
            {
                MessageLabel.Text = "That account number has already been taken";
            }
            else
            {
                MessageLabel.Text = "Your new bank account will be processed soon.";
                BankAccount data = new BankAccount
                // The following is an "initializer list"
                {
                    AccountHolder = AccountHolder.Text,
                    AccountNumber = long.Parse(AccountNumber.Text),
                    OpeningBalance = decimal.Parse(OpeningBalance.Text),
                    AccountType = AccountType.Text
                };

                BankAccounts.Add(data);
                BankAccountGridView.DataSource = BankAccounts;
                BankAccountGridView.DataBind();
            }
        }
        // else....
        //      The ValidationSummary will automatically display its contents should the IsValid check return False.
    }

    private bool IsDuplicate()
    {
        bool duplicate = false;
        foreach (var item in BankAccounts)
            if (item.AccountNumber == long.Parse(AccountNumber.Text))
                duplicate = true;
        return duplicate;
    }

    protected void ClearForm_Click(object sender, EventArgs e)
    {
        // Empty out all the values of the textboxes, etc.
        AccountHolder.Text = "";
        AccountNumber.Text = "";
        OverdraftLimit.Text = "";
        OpeningBalance.Text = "";
        // To "clear" a DropDownList, RadioButtonList, or CheckBoxList, you would change the .SelectedValue
        AccountType.SelectedValue = "";
        // (Alternatively, I could have changed the .SelectedIndex instead)
        AccountType.SelectedIndex = -1; // -1, just in case there are no items in the control

    }
}
