using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.MessageLabel.Text = "Hello Webforms!";
        }

        protected void RespondToUser_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(UserReply.Text))
                MessageLabel.Text = "What? Speak up!";
            else
                MessageLabel.Text = "You don't say...";
        }

        protected void TellUserBirthdate_Click(object sender, EventArgs e)
        {
            if (Calendar1.SelectedDate != DateTime.MinValue)
                MessageLabel.Text = $"I see you were born on {Calendar1.SelectedDate.ToShortDateString()}.";
        }
    }
}