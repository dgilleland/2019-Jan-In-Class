using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    public partial class DemoWebControls : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TextBox1.BackColor = System.Drawing.Color.Bisque;
            TextBox1.ForeColor = System.Drawing.Color.Pink;
            TextBox1.Font.Bold = true;
        }

        protected void ProcessTextboxes_Click(object sender, EventArgs e)
        {
            // The name (id) of the control, .Text gets/sets the value for a TextBox, Label, and Literal control.
            string result = "";

            result += "From type=text : '" + TextBox1.Text + "' <br />";
            double numberValue;
            if(double.TryParse(TextBox3.Text, out numberValue))
                result += "From type=number : " + numberValue + " <br />";

            DateTime when;
            if (DateTime.TryParse(TextBox13.Text, out when))
                result += "From type=datetime : " + when.ToString() + " <br />";
            else
                result += "-No datetime entered-";

            if (DateTime.TryParse(TextBox11.Text, out when))
                result += "From type=date : " + when.ToLongDateString() + " <br />";
            else
                result += "-No date entered-";

            if (DateTime.TryParse(TextBox14.Text, out when))
                result += "From type=datetime-local : " + when.ToString() + " <br />";
            else
                result += "-No date entered-";

            MessageLabel.Text = result;
        }

        protected void ProcessListControls_Click(object sender, EventArgs e)
        {
            // For List controls, such as a DropDownList, there are certain properties we use:
            // .SelectedIndex -> gives us the index position of the selected item in the list
            // .SelectedValue -> gives us the value for the selected item in the list
            // .SelectedItem  -> gives us the key/value object for the selected item in the list

            // 95% of the time, the property we want to use is the .SelectedValue, as this value
            // typically acts as our unique identifier for the object/item selected by the user.

            // Demo the DropDownList
            string message =
                string.Format("You selected {0} in the dropdown. Its position is {1} and its value is {2}",
                              DropDownList1.SelectedItem?.Text,
                              DropDownList1.SelectedIndex,
                              DropDownList1.SelectedValue);

            // Demo the ListBox with multiple selected items
            // For multiple selected items, you need to loop through the items in the control and check each item's .Selected property.
            message += "<br /> Multiselect Items: ";

            foreach (ListItem item in ListBox2.Items) // .Items is a collection of ListItem objects
                if (item.Selected)
                    message += item.Value + ", ";

            // Have some fun with the radio button items....
            if(RadioButtonList0.SelectedItem != null)
                RadioButtonList0.SelectedItem.Text += "."; // what will this line do?!?

            MessageLabel.Text = message;
        }

        protected void ProcessOthers_Click(object sender, EventArgs e)
        {

        }
    }
}