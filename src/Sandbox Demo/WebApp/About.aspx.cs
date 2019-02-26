using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Is a "stage" of processing the page where you get to set up
            // aspects of the page's content before any of the events of 
            // your page's controls are processed.

            if(!IsPostBack) // !IsPostBack means a GET request
            {
                MessageLabel.Text = "Tell us about yourself! You can trust us!";
                // Label    .String
            }
            else
            {
                MessageLabel.Text = string.Empty; // clear the contents
            }
        }

        protected void GetInitials_Click(object sender, EventArgs e)
        {
            // This method is what gets called when the <asp:LinkButton ID="GetInitials" ...
            // is clicked.
            // We can say that this method "handles" the click event of that button/link.
            
            // Take the user's input, and create an array of strings (use space as delimiter)
            var nameParts = FullName.Text.Split(' ');
            // Construct the initials by taking the first character of each word part.
            string result = "";
            foreach (var part in nameParts)
                if (!string.IsNullOrWhiteSpace(part))
                    result += $"{part[0]}.";
            // Place the result in the label on the form
            Initials.Text = result;

            if (string.IsNullOrEmpty(result))
            {
                MessageLabel.Text = "I can't get initials from empty text...";
                MessageLabel.CssClass = "bg-info";
            }
            else
                ReverseName.Visible = true; // Show the button
        }

        protected void ReverseName_Click(object sender, EventArgs e)
        {
            string reversed = string.Join("", FullName.Text.ToArray().Reverse());
            MessageLabel.Text = $"Your name reversed is <b>{reversed}</b>";
        }
    }
}