
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

partial class FormSamples_ContestEntry
    : System.Web.UI.Page
{
    protected void Page_Load(Object sender, EventArgs e)
    {
    }
    protected void Submit_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            if (AgreeToTerms.Checked)
            {
                MessageLabel.Text = "Good luck on the contest!";
            }
            else
            {
                MessageLabel.Text = "You MUST agree to the terms of the contest!!";
            }
        }
    }
    protected void ClearForm_Click(object sender, EventArgs e)
    {
        // TODO: Empty out the text on all the controls on the form...
    }
}
